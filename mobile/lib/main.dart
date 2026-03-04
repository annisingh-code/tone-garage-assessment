import 'package:flutter/material.dart';
import 'screens/workout_list_screen.dart'; // 🔥 Ye import zaroori hai

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
          const WorkoutListScreen(), // 🔥 Yahan par humne screen connect kar di
    );
  }
  
}
