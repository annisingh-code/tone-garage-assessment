import { Router } from "express";
import { getAllWorkouts } from "../controllers/workout.controller";

const router = Router();

router.get("/", getAllWorkouts);

export default router;
