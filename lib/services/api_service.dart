import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class ApiService {
  final String _apiUrl = 'https://api.quotable.io/random';
  final List<String> _fallbackQuotes = [
    'Kecantikan sejati berasal dari dalam hati yang bersyukur.',
    'Hari ini adalah kanvas kosong, lukislah dengan warna-warna indah.',
    'Merawat diri bukanlah kemewahan, tetapi kebutuhan.',
    'Perempuan kuat menciptakan hari-hari indah meski dari hal kecil.',
    'Kebahagiaan adalah skincare terbaik untuk kulit bersinar.',
  ];

  Future<String> fetchInspirationalQuote() async {
    try {
      final response = await http.get(
        Uri.parse(_apiUrl),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ).timeout(const Duration(seconds: 10));

      print('API Response Status: ${response.statusCode}');
      print('API Response Body: ${response.body}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final String quote = data['content']?.toString() ?? _getFallbackQuote();
        final String author = data['author']?.toString() ?? 'Anonim';
        return '✨ "$quote" - $author';
      } else {
        if (kDebugMode) {
          print('API Error: Status code ${response.statusCode}');
        }
        return _getFallbackQuote();
      }
    } catch (e) {
      if (kDebugMode) {
        print('API Connection Error: $e');
      }
      return _getFallbackQuote();
    }
  }

  String _getFallbackQuote() {
    final randomIndex = DateTime.now().millisecond % _fallbackQuotes.length;
    return '✨ "${_fallbackQuotes[randomIndex]}" - DailyGlow';
  }
}
