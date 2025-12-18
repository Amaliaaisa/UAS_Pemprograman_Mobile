import 'package:flutter/material.dart';
import '../models/menstruation_model.dart';

class MenstruationProvider extends ChangeNotifier {
  List<MenstruationEntry> _entries = [];
  bool _isLoading = false;
  final String _error = '';

  List<MenstruationEntry> get entries => _entries;
  bool get isLoading => _isLoading;
  String get error => _error;

  MenstruationProvider() {
    _loadInitialData();
  }

  void _loadInitialData() {
    _isLoading = true;
    notifyListeners();

    // Simulasi loading data
    Future.delayed(const Duration(seconds: 1), () {
      _entries = [
        MenstruationEntry(
          id: '1',
          date: DateTime.now().subtract(const Duration(days: 28)),
          note: 'Hari pertama, rasa sakit sedang',
          symptoms: 'Kram perut, lelah',
          flowLevel: 4,
        ),
        MenstruationEntry(
          id: '2',
          date: DateTime.now().subtract(const Duration(days: 56)),
          note: 'Siklus normal, mood baik',
          symptoms: 'Sedikit kram',
          flowLevel: 3,
        ),
        MenstruationEntry(
          id: '3',
          date: DateTime.now().subtract(const Duration(days: 84)),
          note: 'Siklus lebih pendek dari biasa',
          symptoms: 'Pusing, mual',
          flowLevel: 5,
        ),
      ];
      _isLoading = false;
      notifyListeners();
    });
  }

  // CREATE
  void addEntry({
    required DateTime date,
    required String note,
    String symptoms = '',
    int flowLevel = 3,
  }) {
    _isLoading = true;
    notifyListeners();

    Future.delayed(const Duration(milliseconds: 500), () {
      final newEntry = MenstruationEntry(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        date: date,
        note: note,
        symptoms: symptoms,
        flowLevel: flowLevel,
      );
      
      _entries.add(newEntry);
      _entries.sort((a, b) => b.date.compareTo(a.date));
      _isLoading = false;
      notifyListeners();
    });
  }

  // UPDATE
  void updateEntry({
    required String id,
    required DateTime date,
    required String note,
    required String symptoms,
    required int flowLevel,
  }) {
    _isLoading = true;
    notifyListeners();

    Future.delayed(const Duration(milliseconds: 500), () {
      final index = _entries.indexWhere((entry) => entry.id == id);
      if (index != -1) {
        _entries[index] = _entries[index].copyWith(
          date: date,
          note: note,
          symptoms: symptoms,
          flowLevel: flowLevel,
        );
      }
      _isLoading = false;
      notifyListeners();
    });
  }

  // DELETE
  void deleteEntry(String id) {
    _isLoading = true;
    notifyListeners();

    Future.delayed(const Duration(milliseconds: 500), () {
      _entries.removeWhere((entry) => entry.id == id);
      _isLoading = false;
      notifyListeners();
    });
  }

  // READ dengan filter
  List<MenstruationEntry> getEntriesForMonth(DateTime month) {
    return _entries.where((entry) {
      return entry.date.year == month.year && entry.date.month == month.month;
    }).toList();
  }

  List<MenstruationEntry> getRecentEntries(int count) {
    return _entries.take(count).toList();
  }

  // Analytics
  DateTime getNextPrediction() {
    if (_entries.length < 2) {
      return DateTime.now().add(const Duration(days: 28));
    }
    
    int totalDays = 0;
    for (int i = 1; i < _entries.length; i++) {
      final diff = _entries[i-1].date.difference(_entries[i].date).inDays;
      totalDays += diff.abs();
    }
    
    final avgCycle = totalDays ~/ (_entries.length - 1);
    final lastEntry = _entries.first;
    
    return lastEntry.date.add(Duration(days: avgCycle));
  }

  int getAverageCycleLength() {
    if (_entries.length < 2) return 28;
    
    int totalDays = 0;
    int count = 0;
    
    for (int i = 1; i < _entries.length; i++) {
      final diff = _entries[i-1].date.difference(_entries[i].date).inDays;
      totalDays += diff.abs();
      count++;
    }
    
    return totalDays ~/ count;
  }

  int getTotalEntries() => _entries.length;
  int getAverageFlowLevel() {
    if (_entries.isEmpty) return 3;
    final total = _entries.map((e) => e.flowLevel).reduce((a, b) => a + b);
    return total ~/ _entries.length;
  }
}