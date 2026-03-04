import express, { Request, Response, NextFunction } from "express";
import cors from "cors";
import dotenv from "dotenv";
import { pool } from "./config/db";
import workoutRoutes from "./routes/workout.routes";
import userRoutes from "./routes/user.routes";

dotenv.config();

const app = express();

// Middleware
app.use(cors());
app.use(express.json());

// API Routes
app.use("/api/workouts", workoutRoutes);
app.use("/api/users", userRoutes);

// Health Check Route
app.get("/", (req: Request, res: Response) => {
  res.send("Workout Tracker API is running.");
});

// 404 Route Not Found Handler
app.use((req: Request, res: Response) => {
  res.status(404).json({
    success: false,
    message: "Route not found",
  });
});

// Global Error Handling Middleware
app.use((err: any, req: Request, res: Response, next: NextFunction) => {
  console.error(err.stack);
  res.status(500).json({
    success: false,
    message: "Internal server error",
  });
});

const PORT = process.env.PORT || 3000;

// Initialize Server and Test Database Connection
app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});

pool
  .getConnection()
  .then((connection) => {
    console.log("Database connected successfully.");
    connection.release(); // Best practice: release the connection after pinging
  })
  .catch((err) => {
    console.error("Database connection failed:", err);
  });