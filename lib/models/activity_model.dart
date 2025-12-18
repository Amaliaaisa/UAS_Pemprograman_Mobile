class Activity {
  final String id;
  final String title;
  final String time;
  final String category;
  final String day;
  final DateTime date;
  bool isCompleted;

  Activity({
    required this.id,
    required this.title,
    required this.time,
    required this.category,
    required this.day,
    required this.date,
    this.isCompleted = false,
  });

  Activity copyWith({
    String? id,
    String? title,
    String? time,
    String? category,
    String? day,
    DateTime? date,
    bool? isCompleted,
  }) {
    return Activity(
      id: id ?? this.id,
      title: title ?? this.title,
      time: time ?? this.time,
      category: category ?? this.category,
      day: day ?? this.day,
      date: date ?? this.date,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}