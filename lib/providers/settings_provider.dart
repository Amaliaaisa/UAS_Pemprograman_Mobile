import 'package:flutter/material.dart';
import '../services/local_storage_service.dart';

class SettingsProvider extends ChangeNotifier {
  final LocalStorageService _localStorageService = LocalStorageService();

  String _dateFormat = 'dd-MM-yyyy';
  String _startDayOfWeek = 'Minggu';
  bool _isDark = false;

  String get dateFormat => _dateFormat;
  String get startDayOfWeek => _startDayOfWeek;
  bool get isDark => _isDark;

  SettingsProvider() {
    _loadSettings();
  }

  // Memuat data dari SharedPreferences
  Future<void> _loadSettings() async {
    _dateFormat = await _localStorageService.getDateFormat();
    _startDayOfWeek = await _localStorageService.getStartDayOfWeek();
    _isDark = await _localStorageService.getIsDark();
    notifyListeners();
  }

  // Mengubah dan menyimpan Format Tanggal
  Future<void> updateDateFormat(String newFormat) async {
    _dateFormat = newFormat;
    await _localStorageService.saveDateFormat(newFormat);
    notifyListeners();
  }

  // Mengubah dan menyimpan Hari Awal Minggu
  Future<void> updateStartDayOfWeek(String newDay) async {
    _startDayOfWeek = newDay;
    await _localStorageService.saveStartDayOfWeek(newDay);
    notifyListeners();
  }

  // Mengubah dan menyimpan Tema Gelap
  Future<void> updateIsDark(bool isDark) async {
    _isDark = isDark;
    await _localStorageService.saveIsDark(isDark);
    notifyListeners();
  }
}
