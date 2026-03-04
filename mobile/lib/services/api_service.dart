import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/workout.dart';

class ApiService {
  // Ye baseUrl class ke andar hai, isliye sab functions isko use kar sakte hain
  final String baseUrl = 'http://localhost:3000/api';

  // 1. Fetch Workouts
  Future<List<Workout>> fetchWorkouts() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/workouts'));

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);
        final List<dynamic> data = jsonResponse['data'];
        return data.map((workout) => Workout.fromJson(workout)).toList();
      } else {
        throw Exception('Failed to load workouts');
      }
    } catch (e) {
      throw Exception('Server connect error: $e');
    }
  }

  // 2. Fetch User Streak
  Future<int> getUserStreak(String userId) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/users/$userId/streak'),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);
        return jsonResponse['data']['streak'];
      } else {
        throw Exception('Failed to load streak');
      }
    } catch (e) {
      throw Exception('Server connect error: $e');
    }
  }

  // 3. Complete a Workout
  Future<bool> completeWorkout(String userId, int workoutId) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/users/$userId/workouts/$workoutId/complete'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'completedAt': DateTime.now().toUtc().toIso8601String(),
        }),
      );

      if (response.statusCode == 201) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      throw Exception('Server connect error: $e');
    }
  }

  // 4. Fetch Workout History
  Future<List<dynamic>> getWorkoutHistory(String userId) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/users/$userId/workout-history'),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);
        return jsonResponse['data'];
      } else {
        throw Exception('Failed to load history');
      }
    } catch (e) {
      throw Exception('Server connect error: $e');
    }
  }
}
