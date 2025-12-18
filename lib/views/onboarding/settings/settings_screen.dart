import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../providers/settings_provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final settingsProvider = Provider.of<SettingsProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pengaturan'), // Sesuai screenshot
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Bagian Umum
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Umum',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
            ),

            // Bahasa (Sesuai screenshot)
            ListTile(
              leading: const Icon(Icons.language, color: Colors.pink),
              title: const Text('Bahasa'),
              subtitle: const Text('Default'),
              onTap: () {},
            ),

            // Notifikasi dan Pengingat (Sesuai screenshot)
            ListTile(
              leading: const Icon(
                Icons.notifications_active_outlined,
                color: Colors.pink,
              ),
              title: const Text('Notifikasi dan Pengingat'),
              onTap: () {},
            ),

            const Divider(),

            // Bagian Kustom
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Kustom',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
            ),

            // Format Tanggal (Menggunakan SharedPreferences)
            ListTile(
              leading: const Icon(Icons.date_range, color: Colors.pink),
              title: const Text('Format Tanggal'),
              subtitle: Text(settingsProvider.dateFormat),
              onTap: () {
                // Dialog untuk mengubah format
                _showFormatDialog(context, settingsProvider);
              },
            ),

            // Hari Awal Minggu (Menggunakan SharedPreferences)
            ListTile(
              leading: const Icon(Icons.calendar_today, color: Colors.pink),
              title: const Text('Hari Awal Minggu'),
              subtitle: Text(
                settingsProvider.startDayOfWeek,
              ), // Sesuai screenshot
              onTap: () {
                _showDayOfWeekDialog(context, settingsProvider);
              },
            ),
          ],
        ),
      ),
    );
  }

  // Dialog untuk mengubah Format Tanggal
  void _showFormatDialog(BuildContext context, SettingsProvider provider) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Pilih Format Tanggal'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: ['dd-MM-yyyy', 'MM/dd/yyyy', 'yyyy/MM/dd']
              .map(
                (format) => RadioListTile<String>(
                  title: Text(format),
                  value: format,
                  groupValue: provider.dateFormat,
                  onChanged: (value) {
                    if (value != null) {
                      provider.updateDateFormat(value);
                      Navigator.pop(ctx);
                    }
                  },
                ),
              )
              .toList(),
        ),
      ),
    );
  }

  // Dialog untuk mengubah Hari Awal Minggu
  void _showDayOfWeekDialog(BuildContext context, SettingsProvider provider) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Pilih Hari Awal Minggu'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: ['Minggu', 'Senin']
              .map(
                (day) => RadioListTile<String>(
                  title: Text(day),
                  value: day,
                  groupValue: provider.startDayOfWeek,
                  onChanged: (value) {
                    if (value != null) {
                      provider.updateStartDayOfWeek(value);
                      Navigator.pop(ctx);
                    }
                  },
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
