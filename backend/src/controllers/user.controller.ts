import { Request, Response } from "express";
import { pool } from "../config/db";

/**
 * Fetch the workout completion history for a specific user
 */
export const getUserWorkoutHistory = async (req: Request, res: Response) => {
  try {
    const { userId } = req.params;

    // Join with workouts table to get descriptive details for the history log
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
 * Mark a specific workout as completed for a user
 */
export const completeWorkout = async (req: Request, res: Response) => {
  try {
    const { userId, workoutId } = req.params;
    const { completedAt } = req.body;

    if (!completedAt) {
      return res.status(400).json({
        success: false,
        message: "completedAt is required",
      });
    }

    // Convert ISO string to MySQL compatible DATETIME format (YYYY-MM-DD HH:MM:SS)
    const workoutDate = new Date(completedAt);
    const formattedDate = workoutDate
      .toISOString()
      .slice(0, 19)
      .replace("T", " ");

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
