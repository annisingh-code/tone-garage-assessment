import { Router } from "express";

import {
  getUserWorkoutHistory,
  completeWorkout,
  getUserStreak,
} from "../controllers/user.controller";
const router = Router();

// GET /api/users/:userId/workout-history
router.get("/:userId/workout-history", getUserWorkoutHistory);

// POST /api/users/:userId/workouts/:workoutId/complete
router.post("/:userId/workouts/:workoutId/complete", completeWorkout);

// GET /api/users/:userId/streak
router.get("/:userId/streak", getUserStreak);

export default router;
