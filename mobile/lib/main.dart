import 'package:flutter/material.dart';
import 'screens/workout_list_screen.dart'; // Import the workout list screen

void main() {
  runApp(const WorkoutTrackerApp());
}

class WorkoutTrackerApp extends StatelessWidget {
  const WorkoutTrackerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tone Garage',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        useMaterial3: true,
      ),
      home:
          const WorkoutListScreen(), // Set WorkoutListScreen as the home screen
    );
  }
}
