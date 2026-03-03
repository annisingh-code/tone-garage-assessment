import express, { Request, Response, NextFunction } from "express";
import { pool } from "./config/db";
import cors from "cors";
import dotenv from "dotenv";
import workoutRoutes from "./routes/workout.routes";
import userRoutes from "./routes/user.routes";

dotenv.config();

const app = express();

app.use(cors());
app.use(express.json());

app.use("/api/workouts", workoutRoutes);
app.use("/api/users", userRoutes);

app.get("/", (req, res) => {
  res.send("Workout Tracker API Running 🚀");
});

// 1. 404 Handler 
app.use((req, res) => {
  res.status(404).json({
    success: false,
    message: "Route not found",
  });
});

// 2. Global Error Handler 
app.use((err: any, req: Request, res: Response, next: NextFunction) => {
  console.error(err.stack);
  res.status(500).json({
    success: false,
    message: "Something went wrong on the server",
  });
});

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});
pool
  .getConnection()
  .then(() => console.log("Database connected ✅"))
  .catch((err) => console.error("Database connection failed ❌", err));
