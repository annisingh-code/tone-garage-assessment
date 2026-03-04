import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/workout.dart';

// 🔥 Ab ye StatefulWidget ban gaya hai taaki hum UI refresh kar sakein
class WorkoutListScreen extends StatefulWidget {
  const WorkoutListScreen({super.key});

  @override
  State<WorkoutListScreen> createState() => _WorkoutListScreenState();
}

class _WorkoutListScreenState extends State<WorkoutListScreen> {
  final ApiService _apiService = ApiService();

  // Seed data ke hisaab se hum userId 1 use kar rahe hain
  final String currentUserId = "1";

  late Future<List<Workout>> _workoutsFuture;
  late Future<int> _streakFuture;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  // Initial API calls (React ke useEffect jaisa)
  void _loadData() {
    _workoutsFuture = _apiService.fetchWorkouts();
    _streakFuture = _apiService.getUserStreak(currentUserId);
  }

  // Jab workout complete ho, toh streak refresh karne ke liye
  void _refreshStreak() {
    setState(() {
      _streakFuture = _apiService.getUserStreak(currentUserId);
    });
  }

  // Complete button pe click karne ka function
  Future<void> _markWorkoutCompleted(int workoutId, String title) async {
    try {
      bool success = await _apiService.completeWorkout(
        currentUserId,
        workoutId,
      );

      if (success && mounted) {
        // Success message dikhao
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Awesome! $title completed. 💪'),
            backgroundColor: Colors.green,
          ),
        );
        // Streak update karo (Ye API dobara call karke AppBar refresh karega)
        _refreshStreak();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to complete workout.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tone Garage"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          // 🔥 Ye doosra FutureBuilder sirf Streak dikhane ke liye hai
          FutureBuilder<int>(
            future: _streakFuture,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: Center(
                    child: Text(
                      '🔥 Streak: ${snapshot.data}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              }
              // Jab tak streak load ho rahi hai, empty space dikhao
              return const SizedBox.shrink();
            },
          ),
        ],
      ),
      body: FutureBuilder<List<Workout>>(
        future: _workoutsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No workouts found!"));
          }

          final workouts = snapshot.data!;

          return ListView.builder(
            itemCount: workouts.length,
            itemBuilder: (context, index) {
              final workout = workouts[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                child: ListTile(
                  leading: const CircleAvatar(
                    child: Icon(Icons.fitness_center),
                  ),
                  title: Text(
                    workout.title,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    "${workout.durationMinutes} mins • Difficulty: ${workout.difficulty}",
                  ),
                  trailing: IconButton(
                    icon: const Icon(
                      Icons.check_circle_outline,
                      color: Colors.green,
                    ),
                    onPressed: () =>
                        _markWorkoutCompleted(workout.id, workout.title),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
