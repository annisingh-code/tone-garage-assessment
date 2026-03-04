import { Request, Response } from "express";
import { pool } from "../config/db";

/**
 * Retrieves a list of all available workouts.
 * Fetches all records from the workouts table to be displayed in the workout catalog.
 */
export const getAllWorkouts = async (req: Request, res: Response) => {
  try {
    // Fetch all workout records from the database
    const [rows] = await pool.query("SELECT * FROM workouts");
    
    res.status(200).json({
      success: true,
      data: rows,
    });
  } catch (error) {
    console.error("Error fetching workouts:", error);
    res.status(500).json({
      success: false,
      message: "Internal server error",
    });
  }
};