import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/workout.dart';
import '../screens/workout_history_screen.dart';

class WorkoutListScreen extends StatefulWidget {
  const WorkoutListScreen({super.key});

  @override
  State<WorkoutListScreen> createState() => _WorkoutListScreenState();
}

class _WorkoutListScreenState extends State<WorkoutListScreen> {
  final ApiService _apiService = ApiService();

  // Using a hardcoded user ID for demonstration purposes
  final String currentUserId = "1";

  late Future<List<Workout>> _workoutsFuture;
  late Future<int> _streakFuture;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  // Initialize API calls to fetch data when the screen loads
  void _loadData() {
    _workoutsFuture = _apiService.fetchWorkouts();
    _streakFuture = _apiService.getUserStreak(currentUserId);
  }

  // Refresh the user's streak by triggering a state update
  void _refreshStreak() {
    setState(() {
      _streakFuture = _apiService.getUserStreak(currentUserId);
    });
  }

  // Handler for marking a workout as completed
  Future<void> _markWorkoutCompleted(int workoutId, String title) async {
    try {
      bool success = await _apiService.completeWorkout(
        currentUserId,
        workoutId,
      );

      if (success && mounted) {
        // Display success notification
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Awesome! $title completed. 💪'),
            backgroundColor: Colors.green,
          ),
        );
        // Refresh the AppBar to reflect the newly updated streak
        _refreshStreak();
      }
    } catch (e) {
      if (mounted) {
        // Display error notification
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
          // Navigation button to the Workout History screen
          IconButton(
            icon: const Icon(Icons.history),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const WorkoutHistoryScreen(userId: "1"),
                ),
              );
            },
          ),
          // Dynamic widget to load and display the user's active streak
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
              // Return an empty placeholder while the streak data is loading
              return const SizedBox.shrink();
            },
          ),
        ],
      ),
      body: FutureBuilder<List<Workout>>(
        future: _workoutsFuture,
        builder: (context, snapshot) {
          // Handle Loading State
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          // Handle Error State
          else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }
          // Handle Empty State
          else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No workouts found!"));
          }

          final workouts = snapshot.data!;

          // Render the list of available workouts
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
