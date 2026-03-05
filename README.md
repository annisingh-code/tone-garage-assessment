# Tone Garage - Workout Tracker 🏋️‍♂️

A full-stack workout tracking application built to help users manage their fitness routines, track their completion history, and maintain a consecutive daily workout streak.

## 🌐 Live Deployment (Bonus)
* **Live API Base URL:** `https://tone-garage-assessment.onrender.com/api`
* **Cloud Database:** Hosted on Railway (MySQL)
* The Flutter mobile app is pre-configured to point to this live production URL, ensuring immediate testing on any physical Android device without local server setup.

## 🚀 Features

* **Workout Catalog:** View a list of available workouts with details like duration and difficulty.
* **Track Progress:** Mark workouts as completed directly from the UI.
* **Dynamic Streak System:** Calculates active consecutive workout days. The logic is timezone-proof and prevents multiple workouts on the same day from falsely inflating the streak.
* **Workout History:** View a chronological log of all completed workouts.
* **Robust Backend:** Built with TypeScript, Express, and MySQL, featuring strict input validation and clean error handling.

## 🛠️ Tech Stack

**Backend:**
* Node.js & Express.js
* TypeScript
* MySQL (mysql2/promise)
* dotenv & cors
* **Deployment:** Render (API) & Railway (Database)

**Frontend (Mobile):**
* Flutter (Dart)
* `http` package for API integration
* FutureBuilder for clean async state management

## 📦 Local Setup Instructions (Optional)

If you wish to run the backend and database locally instead of using the live deployment, follow these steps:

### Prerequisites
* Node.js installed
* MySQL Server running locally
* Flutter SDK installed (Targeting Android Device/Emulator)

### 1. Database Setup
1. Open your MySQL client (e.g., MySQL Workbench).
2. Create a new database:
   ```sql
   CREATE DATABASE workout_tracker;
   ```
3. Update the database credentials in the backend `.env` file to match your local MySQL setup.

### 2. Backend Setup
Navigate to the backend directory:
```bash
cd backend
```
Install dependencies:
```bash
npm install
```
Run the database seeder to create tables and insert dummy workouts:
```bash
npm run seed
```
Start the development server:
```bash
npm run dev
```
*The local server will run on `http://localhost:3000`.*

### 3. Flutter (Mobile) Setup
Open a new terminal and navigate to the mobile directory:
```bash
cd mobile
```
Fetch the required Flutter packages:
```bash
flutter pub get
```
*(Note: If running the local backend, update the `baseUrl` in `mobile/lib/services/api_service.dart` from the Render URL to your machine's local IP address or `10.0.2.2` for an emulator).*

Run the app on a connected Android device:
```bash
flutter run
```

## 💡 Architecture Decisions
* **Utility-First Validation:** Implemented reusable ID validation functions in the backend to ensure DRY principles and prevent SQL injection/type errors.
* **Timezone Safety:** Handled date manipulation and streak calculations strictly using `Math.floor` and standardized Date objects to prevent timezone-related floating-point discrepancies.
* **State Management:** Utilized Flutter's native `StatefulWidget` and `FutureBuilder` to keep the architecture lightweight and justifiable, avoiding over-engineering with complex state libraries for simple HTTP requests.