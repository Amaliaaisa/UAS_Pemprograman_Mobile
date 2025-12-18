import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  static const String _dateFormatKey = 'dateFormat';
  static const String _startDayOfWeekKey = 'startDayOfWeek';
  static const String _isDarkKey = 'isDark';

  // Menyimpan Format Tanggal (Contoh implementasi SharedPreferences)
  Future<void> saveDateFormat(String format) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_dateFormatKey, format);
  }

  Future<String> getDateFormat() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_dateFormatKey) ?? 'dd-MM-yyyy';
  }

  // Menyimpan Hari Awal Minggu (Sesuai Screenshot Pengaturan)
  Future<void> saveStartDayOfWeek(String day) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_startDayOfWeekKey, day);
  }

  Future<String> getStartDayOfWeek() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_startDayOfWeekKey) ?? 'Minggu';
  }

  // Menyimpan Tema Gelap
  Future<void> saveIsDark(bool isDark) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_isDarkKey, isDark);
  }

  Future<bool> getIsDark() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_isDarkKey) ?? false;
  }
}
