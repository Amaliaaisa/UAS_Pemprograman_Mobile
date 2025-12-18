class MenstruationEntry {
  final String id;
  final DateTime date;
  final String note;
  final String symptoms;
  final int flowLevel; // 1-5

  MenstruationEntry({
    required this.id,
    required this.date,
    required this.note,
    this.symptoms = '',
    this.flowLevel = 3,
  });

  MenstruationEntry copyWith({
    String? id,
    DateTime? date,
    String? note,
    String? symptoms,
    int? flowLevel,
  }) {
    return MenstruationEntry(
      id: id ?? this.id,
      date: date ?? this.date,
      note: note ?? this.note,
      symptoms: symptoms ?? this.symptoms,
      flowLevel: flowLevel ?? this.flowLevel,
    );
  }
}