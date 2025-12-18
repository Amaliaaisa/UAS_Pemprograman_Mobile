class Note {
  final String id;
  final String title;
  final String content;
  final String category;
  final DateTime date;
  final bool isFavorite;

  Note({
    required this.id,
    required this.title,
    required this.content,
    required this.category,
    required this.date,
    this.isFavorite = false,
  });

  // Untuk CRUD: Membuat salinan objek dengan perubahan (digunakan saat Edit)
  Note copyWith({
    String? id,
    String? title,
    String? content,
    String? category,
    DateTime? date,
    bool? isFavorite,
  }) {
    return Note(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      category: category ?? this.category,
      date: date ?? this.date,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}