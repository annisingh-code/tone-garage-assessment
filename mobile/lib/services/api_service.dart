import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/workout.dart';

class ApiService {
  // 🚨 IMPORTANT: Kyunki hum Chrome (Web) par test kar rahe hain, localhost use karenge.
  // Agar Android Emulator par karte, toh 'http://10.0.2.2:3000/api' use karte.
  static const String baseUrl = 'http://localhost:3000/api';

  Future<List<Workout>> fetchWorkouts() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/workouts'));

      if (response.statusCode == 200) {
        // Backend se { success: true, data: [...] } format aayega
        final Map<String, dynamic> jsonResponse = json.decode(response.body);
        final List<dynamic> data = jsonResponse['data'];
        
        // Data map karke List<Workout> return kar rahe hain
        return data.map((workout) => Workout.fromJson(workout)).toList();
      } else {
        throw Exception('Failed to load workouts');
      }
    } catch (e) {
      throw Exception('Server connect error: $e');
    }
  }
}