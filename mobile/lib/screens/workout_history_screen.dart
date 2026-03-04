import 'package:flutter/material.dart';
import '../services/api_service.dart';

/// Displays the user's completed workout history in a scrollable list.
/// Fetches data dynamically from the backend API and handles loading/error states.
class WorkoutHistoryScreen extends StatelessWidget {
  final String userId;

  const WorkoutHistoryScreen({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    final ApiService apiService = ApiService();

    return Scaffold(
      appBar: AppBar(title: const Text("Workout History")),
      // FutureBuilder manages the async API call and UI states seamlessly
      body: FutureBuilder(
        future: apiService.getWorkoutHistory(userId),
        builder: (context, snapshot) {
          // 1. Loading State
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          // 2. Error State
          if (snapshot.hasError) {
            return const Center(child: Text("Failed to load history"));
          }

          final history = snapshot.data as List;

          // 3. Empty State
          if (history.isEmpty) {
            return const Center(child: Text("No workout history yet"));
          }

          // 4. Success State: Display the list of completed workouts
          return ListView.builder(
            itemCount: history.length,
            itemBuilder: (context, index) {
              final workout = history[index];

              return ListTile(
                leading: const Icon(Icons.history),
                title: Text(workout['title']),
                subtitle: Text(
                  "${workout['duration_minutes']} mins • ${workout['difficulty']}",
                ),
                trailing: Text(
                  // Extracting only the YYYY-MM-DD portion of the ISO date string
                  workout['completed_at'].toString().split("T")[0],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
