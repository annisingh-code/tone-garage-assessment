INSERT INTO users (name, email) VALUES ('Test User', 'test@tonegarage.com');

INSERT INTO workouts (title, description, duration_minutes, difficulty)
VALUES 
('Full Body Workout', 'Complete full body workout routine', 45, 'Intermediate'),
('Morning Yoga', 'Gentle yoga for flexibility', 30, 'Beginner'),
('HIIT Cardio', 'High intensity cardio workout', 20, 'Advanced'),
('Upper Body Strength', 'Focus on chest and arms', 40, 'Intermediate'),
('Core Blast', 'Intense core strengthening workout', 25, 'Beginner');

INSERT INTO user_workouts (user_id, workout_id, completed_at)
VALUES
(1, 1, NOW()),
(1, 2, DATE_SUB(NOW(), INTERVAL 1 DAY)),
(1, 3, DATE_SUB(NOW(), INTERVAL 2 DAY));