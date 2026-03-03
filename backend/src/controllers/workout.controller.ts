import { Request, Response } from "express";
import { pool } from "../config/db";

/**
 * Fetch all available workouts from the database
 */
export const getAllWorkouts = async (req: Request, res: Response) => {
  try {
    // Retrieve all workout records
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