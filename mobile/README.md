# Tone Garage - Flutter App 📱

The mobile application for the Workout Tracker, built with Flutter. It provides a clean, responsive UI for users to view workouts, mark them as complete, and track their active streaks.

## 🌐 Live API Pre-Configured
The application is currently configured to connect to the live production backend hosted on Render. You can compile and run the app immediately on your device without needing to set up the backend locally!

## 🛠️ Tech Stack
* Flutter & Dart
* Material Design 3
* `http` package for API communication

## 🚀 Setup & Run (Physical Android Device)

1. **Install Packages**
   ```bash
   flutter pub get
   ```

2. **Run the App**
   Connect your Android device via USB (with USB Debugging enabled) and run:
   ```bash
   flutter run
   ```

### ⚙️ Optional: Running with Local Backend
If you wish to test the mobile app against a local instance of the backend instead of the live API:
* Open `lib/services/api_service.dart`.
* Update the `baseUrl` variable to match your machine's local IP address (e.g., `http://192.168.x.x:3000/api`) since a physical device cannot route to `localhost`. If using an Android Emulator, use `http://10.0.2.2:3000/api`.

## 🧠 Architecture Notes
* **State Management:** Leveraged Flutter's native `StatefulWidget` and `FutureBuilder` to handle API loading and error states cleanly without introducing heavy third-party state management libraries.
* **UI/UX:** Implemented snackbar notifications for success states and dynamic UI updates for the streak counter.