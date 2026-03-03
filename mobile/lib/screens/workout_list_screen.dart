import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/workout.dart';

class WorkoutListScreen extends StatelessWidget {
  const WorkoutListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tone Garage Workouts"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      // 🔥 FutureBuilder = useEffect + useState
      body: FutureBuilder<List<Workout>>(
        future: ApiService().fetchWorkouts(),
        builder: (context, snapshot) {
          // 1. Loading State (Spinner dikhao)
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          // 2. Error State (Agar backend band ho ya net na chal raha ho)
          else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }
          // 3. Empty State (Database khali ho toh)
          else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No workouts found!"));
          }

          // 4. Success State (Data ko map karke list banana)
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
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      // Yahan hum baad mein Complete Workout wali API call karenge
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('${workout.title} clicked!')),
                      );
                    },
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
