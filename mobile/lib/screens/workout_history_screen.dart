import 'package:flutter/material.dart';
import '../services/api_service.dart';

class WorkoutHistoryScreen extends StatelessWidget {
  final String userId;

  const WorkoutHistoryScreen({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    final ApiService apiService = ApiService();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Workout History"),
      ),
      body: FutureBuilder(
        future: apiService.getWorkoutHistory(userId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return const Center(child: Text("Failed to load history"));
          }

          final history = snapshot.data as List;

          if (history.isEmpty) {
            return const Center(child: Text("No workout history yet"));
          }

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