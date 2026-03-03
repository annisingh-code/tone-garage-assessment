import { Router } from "express";

import {getUserWorkoutHistory,completeWorkout}from "../controllers/user.controller";
const router = Router();

router.get("/:userId/workout-history", getUserWorkoutHistory);
router.post("/:userId/workouts/:workoutId/complete", completeWorkout);


export default router;
