# Tone Garage - Flutter App 📱

The mobile application for the Workout Tracker, built with Flutter. It provides a clean, responsive UI for users to view workouts, mark them as complete, and track their active streaks.

## 🛠️ Tech Stack
* Flutter & Dart
* Material Design 3
* `http` package for API communication

## 🚀 Local Setup (Physical Android Device)

1. **Install Packages**
   ```bash
   flutter pub get
   ```

2. **Configure API Endpoint**
   * Open `lib/services/api_service.dart`.
   * Update the `baseUrl` variable to match your machine's local IP address (e.g., `http://192.168.x.x:3000/api`) since the physical device cannot route to `localhost`.

3. **Run the App**
   Connect your Android device via USB (with USB Debugging enabled) and run:
   ```bash
   flutter run
   ```

## 🧠 Architecture Notes
* **State Management:** Leveraged Flutter's native `StatefulWidget` and `FutureBuilder` to handle API loading and error states cleanly without introducing heavy third-party state management libraries.
* **UI/UX:** Implemented snackbar notifications for success states and dynamic UI updates for the streak counter.