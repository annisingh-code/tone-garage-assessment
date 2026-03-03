import { Request, Response } from "express";
import { pool } from "../config/db";

/**
 * Retrieves the complete workout history for a specific user.
 * Joins the user_workouts log with the workouts table to provide
 * detailed information (title, duration, difficulty) about each completed session.
 */
export const getUserWorkoutHistory = async (req: Request, res: Response) => {
  try {
    const { userId } = req.params;

    // Fetch user's workout history ordered by the most recent completion date
    const [rows] = await pool.query(
      `
      SELECT 
        user_workouts.id,
        workouts.title,
        workouts.duration_minutes,
        workouts.difficulty,
        user_workouts.completed_at
      FROM user_workouts
      JOIN workouts 
        ON user_workouts.workout_id = workouts.id
      WHERE user_workouts.user_id = ?
      ORDER BY user_workouts.completed_at DESC
      `,
      [userId],
    );

    res.status(200).json({
      success: true,
      data: rows,
    });
  } catch (error) {
    console.error("Error fetching workout history:", error);
    res.status(500).json({
      success: false,
      message: "Internal server error",
    });
  }
};

/**
 * Marks a specific workout as completed for a user.
 * Accepts an ISO timestamp from the client, converts it to a MySQL-compatible
 * DATETIME string, and inserts the record into the database.
 */
export const completeWorkout = async (req: Request, res: Response) => {
  try {
    const { userId, workoutId } = req.params;
    const { completedAt } = req.body;

    // Validate if the timestamp is provided in the request body
    if (!completedAt) {
      return res.status(400).json({
        success: false,
        message: "completedAt is required",
      });
    }

    // Parse the incoming ISO string to a Date object
    const workoutDate = new Date(completedAt);

    // Format the date to standard MySQL DATETIME format: YYYY-MM-DD HH:MM:SS
    const formattedDate = workoutDate
      .toISOString()
      .slice(0, 19)
      .replace("T", " ");

    // Insert the completion record into the database
    await pool.query(
      `
      INSERT INTO user_workouts (user_id, workout_id, completed_at)
      VALUES (?, ?, ?)
      `,
      [userId, workoutId, formattedDate],
    );

    res.status(201).json({
      success: true,
      message: "Workout marked as completed",
    });
  } catch (error) {
    console.error("Error completing workout:", error);
    res.status(500).json({
      success: false,
      message: "Internal server error",
    });
  }
};

/**
 * Calculates the current consecutive workout streak for a user.
 * It counts backward from today or yesterday, ensuring that the streak
 * only increments for consecutive days and ignores multiple workouts on the same day.
 */
export const getUserStreak = async (req: Request, res: Response) => {
  try {
    const { userId } = req.params;

    // Fetch distinct workout dates ordered from newest to oldest.
    // DISTINCT prevents multiple workouts on the same day from breaking the logic.
    const [rows]: any = await pool.query(
      `
      SELECT DISTINCT DATE(completed_at) as completed_date
      FROM user_workouts
      WHERE user_id = ?
      ORDER BY completed_date DESC
      `,
      [userId],
    );

    // If the user has no workout history, their streak is obviously 0.
    if (rows.length === 0) {
      return res.status(200).json({ success: true, streak: 0 });
    }

    let streak = 0;

    // Normalize today's date to midnight (00:00:00) for accurate day-to-day comparison.
    const today = new Date();
    today.setHours(0, 0, 0, 0);

    // Normalize the most recent workout date to midnight.
    let previousDate = new Date(rows[0].completed_date);
    previousDate.setHours(0, 0, 0, 0);

    // Check if the streak is already broken.
    // If the last workout was more than 1 day ago (i.e., not today and not yesterday), streak is 0.
    const diffFirst =
      (today.getTime() - previousDate.getTime()) / (1000 * 60 * 60 * 24);

    if (diffFirst > 1) {
      return res.status(200).json({ success: true, streak: 0 });
    }

    // The streak is active (last workout was either today or yesterday). Start counting at 1.
    streak = 1;

    // Iterate backwards through the remaining workout dates.
    for (let i = 1; i < rows.length; i++) {
      const currentDate = new Date(rows[i].completed_date);
      currentDate.setHours(0, 0, 0, 0);

      // Calculate the difference in days between the current date in the loop and the previously checked date.
      const diff =
        (previousDate.getTime() - currentDate.getTime()) /
        (1000 * 60 * 60 * 24);

      // If the difference is exactly 1 day, it's a consecutive workout.
      if (diff === 1) {
        streak++;
        previousDate = currentDate; // Move the pointer backward
      } else {
        // Gap found, meaning the streak ends here.
        break;
      }
    }

    // Return the final calculated streak
    res.status(200).json({
      success: true,
      data: {
        streak,
        lastWorkoutDate: rows[0].completed_date,
      },
    });
  } catch (error) {
    // Log for debugging and return a generic 500 error to the client
    console.error("Error calculating streak:", error);
    res.status(500).json({ success: false, message: "Internal server error" });
  }
};
