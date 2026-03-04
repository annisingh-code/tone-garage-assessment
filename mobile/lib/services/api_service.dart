import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/workout.dart';

/// Service class responsible for handling all HTTP requests to the backend API.
class ApiService {
  // Base URL for the API. Update this to the production URL once the backend is deployed.
  final String baseUrl = 'http://192.168.31.12:3000/api';

  /// Fetches the list of all available workouts from the backend catalog.
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

  /// Retrieves the current consecutive workout streak for a specific user.
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

  /// Submits a request to mark a specific workout as completed.
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

  /// Fetches the chronological history of completed workouts for a given user.
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
