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

  // Factory constructor to parse JSON data from the backend into a Workout object
  factory Workout.fromJson(Map<String, dynamic> json) {
    return Workout(
      id: json['id'],
      title: json['title'],
      durationMinutes: json['duration_minutes'],
      difficulty: json['difficulty'],
    );
  }
}