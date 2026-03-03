# Workout Tracker Tone Garage Assessment

## Overview
A practical workout tracking application designed to help users manage their fitness routines, track progress, and maintain workout streaks. This project consists of a robust Node.js/Express backend, a MySQL database for persistence, and a Flutter mobile application.

## Tech Stack
* **Backend:** Node.js/Express with TypeScript
* **Mobile:** Flutter
* **Database:** MySQL

## Repository Structure
* `backend/`: Node.js API with Express and TypeScript
* `mobile/`: Flutter Mobile Application
* `database/`: SQL Schema and Seed data

## Setup Instructions

### Database Setup
1.  Create a MySQL database:
    ```sql
    CREATE DATABASE workout_tracker;
    ```
2.  Import the schema:
    ```bash
    mysql -u root -p workout_tracker < database/schema.sql
    ```
3.  Import seed data:
    ```bash
    mysql -u root -p workout_tracker < database/seed.sql
    ```

### Backend Setup
1.  Navigate to the backend directory: `cd backend`
2.  Install dependencies: `npm install`
3.  Configure environment variables: Copy `.env.example` to `.env` and update your database credentials.
4.  Start the server: `npm run dev`
5.  API will be running on `http://localhost:3000`

### Flutter App Setup
1.  Navigate to the mobile directory: `cd mobile`
2.  Install dependencies: `flutter pub get`
3.  Run the app: `flutter run`

## API Endpoints

### Workouts
* `GET /api/workouts`: Fetch all available workouts.
* `GET /api/users/:userId/workout-history`: Get a user's completed workout logs.
* `POST /api/users/:userId/workouts/:workoutId/complete`: Mark a workout as finished.

### User Progress
* `GET /api/users/:userId/streak`: Calculate the current consecutive workout streak.

## Features Implemented
- [x] RESTful API with proper error handling.
- [x] Database schema with Relationships and Indexes for performance.
- [x] Logic for accurate Streak Calculation.
- [x] Input validation for API requests.

## Challenges Faced
As a MERN stack developer, working with a relational database like MySQL and a new framework like Flutter in 48 hours was a great learning curve.
* **SQL Logic:** Shifting from NoSQL to Relational thinking for foreign keys and joins.
* **Algorithm Design:** Implementing the backwards-counting streak logic to handle missing days accurately.

## Future Improvements
* Add JWT Authentication for secure user sessions.
* Implement pagination for workout history.
* Add offline caching in Flutter using Hive.

## Time Spent
Approximately 12-15 hours.