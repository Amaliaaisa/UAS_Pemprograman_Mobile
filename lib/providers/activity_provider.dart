import 'package:flutter/material.dart';
import '../models/activity_model.dart';

class ActivityProvider extends ChangeNotifier {
  List<Activity> _activities = [];
  bool _isLoading = false;
  final String _error = '';

  List<Activity> get activities => _activities;
  bool get isLoading => _isLoading;
  String get error => _error;

  ActivityProvider() {
    _loadInitialData();
  }

  void _loadInitialData() {
    _isLoading = true;
    notifyListeners();

    Future.delayed(const Duration(seconds: 1), () {
      final now = DateTime.now();
      _activities = [
        Activity(
          id: '1',
          title: 'Skincare Pagi',
          time: '07:00',
          category: 'Perawatan',
          day: 'Senin',
          date: now,
          isCompleted: true,
        ),
        Activity(
          id: '2',
          title: 'Olahraga Ringan',
          time: '08:00 - 09:00',
          category: 'Kesehatan',
          day: 'Senin',
          date: now,
          isCompleted: false,
        ),
        Activity(
          id: '3',
          title: 'Minum Air 2L',
          time: 'Sepanjang hari',
          category: 'Kesehatan',
          day: 'Senin',
          date: now,
          isCompleted: true,
        ),
        Activity(
          id: '4',
          title: 'Meditasi 10 menit',
          time: '19:00',
          category: 'Relaksasi',
          day: 'Selasa',
          date: now.add(const Duration(days: 1)),
          isCompleted: false,
        ),
        Activity(
          id: '5',
          title: 'Catatan Harian',
          time: '21:00',
          category: 'Personal',
          day: 'Rabu',
          date: now.add(const Duration(days: 2)),
          isCompleted: false,
        ),
      ];
      _isLoading = false;
      notifyListeners();
    });
  }

  // CREATE
  void addActivity({
    required String title,
    required String time,
    required String category,
    required String day,
  }) {
    _isLoading = true;
    notifyListeners();

    Future.delayed(const Duration(milliseconds: 500), () {
      final newActivity = Activity(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        title: title,
        time: time,
        category: category,
        day: day,
        date: DateTime.now(),
      );
      
      _activities.add(newActivity);
      _isLoading = false;
      notifyListeners();
    });
  }

  // UPDATE
  void updateActivity({
    required String id,
    required String title,
    required String time,
    required String category,
    required String day,
  }) {
    _isLoading = true;
    notifyListeners();

    Future.delayed(const Duration(milliseconds: 500), () {
      final index = _activities.indexWhere((activity) => activity.id == id);
      if (index != -1) {
        _activities[index] = _activities[index].copyWith(
          title: title,
          time: time,
          category: category,
          day: day,
        );
      }
      _isLoading = false;
      notifyListeners();
    });
  }

  // DELETE
  void deleteActivity(String id) {
    _isLoading = true;
    notifyListeners();

    Future.delayed(const Duration(milliseconds: 500), () {
      _activities.removeWhere((activity) => activity.id == id);
      _isLoading = false;
      notifyListeners();
    });
  }

  // Toggle completion
  void toggleActivityCompletion(String id) {
    final index = _activities.indexWhere((activity) => activity.id == id);
    if (index != -1) {
      _activities[index] = _activities[index].copyWith(
        isCompleted: !_activities[index].isCompleted,
      );
      notifyListeners();
    }
  }

  // Filter methods
  List<Activity> getActivitiesForDay(String day) {
    return _activities
        .where((activity) => activity.day == day)
        .toList()
        .cast<Activity>();
  }

  List<Activity> getActivitiesByCategory(String category) {
    return _activities
        .where((activity) => activity.category == category)
        .toList()
        .cast<Activity>();
  }

  List<Activity> getCompletedActivities() {
    return _activities
        .where((activity) => activity.isCompleted)
        .toList()
        .cast<Activity>();
  }

  List<Activity> getPendingActivities() {
    return _activities
        .where((activity) => !activity.isCompleted)
        .toList()
        .cast<Activity>();
  }

  // Analytics
  double getCompletionPercentage(String day) {
    final dayActivities = getActivitiesForDay(day);
    if (dayActivities.isEmpty) return 0.0;
    
    final completed = dayActivities.where((a) => a.isCompleted).length;
    return completed / dayActivities.length;
  }

  Map<String, int> getCategoryCounts() {
    final Map<String, int> counts = {};
    for (final activity in _activities) {
      counts[activity.category] = (counts[activity.category] ?? 0) + 1;
    }
    return counts;
  }

  int getTotalActivities() => _activities.length;
  int getCompletedCount() => getCompletedActivities().length;
}