class Workout {
  final int id;
  final String title;
  final int durationMinutes;
  final String difficulty;

  Workout({
    required this.id,
    required this.title,
    required this.durationMinutes,
    required this.difficulty,
  });

  // Ye factory function backend ke JSON ko Dart object mein convert karta hai
  factory Workout.fromJson(Map<String, dynamic> json) {
    return Workout(
      id: json['id'],
      title: json['title'],
      durationMinutes: json['duration_minutes'],
      difficulty: json['difficulty'],
    );
  }
}