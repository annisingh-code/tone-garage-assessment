# Tone Garage - Backend API ⚙️

This is the Express.js and TypeScript backend for the Tone Garage Workout Tracker. It serves RESTful APIs to manage workouts, user completion logs, and dynamic streak calculations.

## 🛠️ Tech Stack
* Node.js & Express.js
* TypeScript
* MySQL2 (Raw Queries)
* dotenv & cors

## 🚀 Local Setup

1. **Install Dependencies**
   ```bash
   npm install
   ```

2. **Database Configuration**
   * Create a `.env` file in this directory based on `.env.example`.
   * Ensure your local MySQL server is running.

3. **Database Initialization**
   Run the seed script to create the required tables and insert sample workouts:
   ```bash
   npm run seed
   ```

4. **Start the Server**
   To run the server in development mode (with hot-reloading):
   ```bash
   npm run dev
   ```
   The API will be available at `http://localhost:3000`.

## 📁 Structure
* `src/config/` - Database connection setup.
* `src/controllers/` - Core business logic and API handlers.
* `src/routes/` - Express route definitions.
* `src/utils/` - Shared utility functions (e.g., input validation).