
class CalendarService {
  // Mock API untuk demo (gunakan API asli untuk production)
  Future<List<Map<String, dynamic>>> getHolidays(String year) async {
    try {
      // Untuk demo, kita return data statis
      // Di aplikasi real, ganti dengan API Google Calendar
      await Future.delayed(const Duration(seconds: 1));
      
      return [
        {
          'title': 'Tahun Baru',
          'date': '2024-01-01',
          'type': 'Nasional',
        },
        {
          'title': 'Hari Kartini',
          'date': '2024-04-21',
          'type': 'Nasional',
        },
        {
          'title': 'Hari Kemerdekaan',
          'date': '2025-08-17',
          'type': 'Nasional',
        },
      ];
    } catch (e) {
      throw Exception('Gagal mengambil data kalender: $e');
    }
  }

  // Simulasi CRUD untuk event kalender
  Future<bool> addEvent(Map<String, dynamic> event) async {
    await Future.delayed(const Duration(seconds: 1));
    return true; // Simulasi sukses
  }

  Future<bool> updateEvent(String id, Map<String, dynamic> event) async {
    await Future.delayed(const Duration(seconds: 1));
    return true;
  }

  Future<bool> deleteEvent(String id) async {
    await Future.delayed(const Duration(seconds: 1));
    return true;
  }

  Future<List<Map<String, dynamic>>> getEvents() async {
    await Future.delayed(const Duration(seconds: 1));
    return [];
  }
}