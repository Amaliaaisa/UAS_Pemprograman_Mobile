import 'package:flutter/material.dart';
import '../models/note_model.dart';
import '../services/api_service.dart';

class NoteProvider extends ChangeNotifier {
  final ApiService _apiService = ApiService();
  
  List<Note> _notes = [];
  bool _isLoading = false;
  
  String _dailyQuote = '✨ "Kecantikan dimulai dari hati yang bahagia." - DailyGlow';
  bool _isQuoteLoading = false;

  List<Note> get notes => _notes;
  bool get isLoading => _isLoading;
  String get dailyQuote => _dailyQuote;
  bool get isQuoteLoading => _isQuoteLoading;

  NoteProvider() {
    _initData();
  }

  void _initData() {
    // Data awal
    _notes = [
      Note(
        id: '1',
        title: 'Selamat Datang di DailyGlow ✨',
        content: 'Mulai catat rutinitas kecantikan dan kesehatanmu di sini. Aplikasi ini dibuat khusus untuk perempuan Indonesia.',
        category: 'Personal',
        date: DateTime.now(),
        isFavorite: true,
      ),
      Note(
        id: '2',
        title: 'Skincare Routine Pagi',
        content: '1. Facial wash\n2. Toner\n3. Serum vitamin C\n4. Moisturizer\n5. Sunscreen SPF 50+',
        category: 'Kecantikan',
        date: DateTime.now().subtract(const Duration(days: 1)),
        isFavorite: false,
      ),
      Note(
        id: '3',
        title: 'Minum Air 2L',
        content: 'Target: 8 gelas per hari\n- Pagi: 2 gelas\n- Siang: 3 gelas\n- Sore: 2 gelas\n- Malam: 1 gelas',
        category: 'Kesehatan',
        date: DateTime.now().subtract(const Duration(days: 2)),
        isFavorite: true,
      ),
    ];
    
    // Ambil kutipan dengan delay untuk menghindari error
    Future.delayed(const Duration(seconds: 2), () {
      fetchDailyQuote();
    });
  }

  // --- FUNGSI CRUD ---
  void addNote(String title, String content, String category) {
    final newNote = Note(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: title,
      content: content,
      category: category,
      date: DateTime.now(),
    );
    _notes.add(newNote);
    notifyListeners();
  }

  void updateNote(String id, String title, String content, String category) {
    final index = _notes.indexWhere((n) => n.id == id);
    if (index != -1) {
      _notes[index] = _notes[index].copyWith(
        title: title,
        content: content,
        category: category,
      );
      notifyListeners();
    }
  }

  void deleteNote(String id) {
    _notes.removeWhere((n) => n.id == id);
    notifyListeners();
  }

  // --- FUNGSI API ---
  Future<void> fetchDailyQuote() async {
    _isQuoteLoading = true;
    notifyListeners();

    try {
      _dailyQuote = await _apiService.fetchInspirationalQuote();
    } catch (e) {
      _dailyQuote = '✨ "Hari ini adalah kesempatan untuk versi terbaik dari dirimu." - DailyGlow';
    }

    _isQuoteLoading = false;
    notifyListeners();
  }
  
  // Toggle favorite
  void toggleFavorite(String id) {
    final index = _notes.indexWhere((n) => n.id == id);
    if (index != -1) {
      _notes[index] = _notes[index].copyWith(
        isFavorite: !_notes[index].isFavorite,
      );
      notifyListeners();
    }
  }
}