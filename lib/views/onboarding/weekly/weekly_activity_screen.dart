import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../../providers/activity_provider.dart';

class WeeklyActivityScreen extends StatefulWidget {
  const WeeklyActivityScreen({super.key});

  @override
  State<WeeklyActivityScreen> createState() => _WeeklyActivityScreenState();
}

class _WeeklyActivityScreenState extends State<WeeklyActivityScreen> {
  final List<String> _days = [
    'Senin',
    'Selasa',
    'Rabu',
    'Kamis',
    'Jumat',
    'Sabtu',
    'Minggu'
  ];

  int _selectedDayIndex = DateTime.now().weekday - 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFEF6F9),
      appBar: AppBar(
        title: Text(
          'Kegiatan Mingguan',
          style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.add_rounded, color: Color(0xFFE91E63)),
            onPressed: () => _showAddActivityDialog(context),
          ),
        ],
      ),
      body: Consumer<ActivityProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const Center(
              child: CircularProgressIndicator(color: Color(0xFFE91E63)),
            );
          }

          return Column(
            children: [
              /// ================= DAY SELECTOR =================
              Container(
                height: 110, // 🔧 diperbesar agar tidak overflow
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                color: Colors.white,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _days.length,
                  itemBuilder: (context, index) {
                    final isSelected = index == _selectedDayIndex;
                    final completionRate =
                        provider.getCompletionPercentage(_days[index]);

                    return GestureDetector(
                      onTap: () => setState(() {
                        _selectedDayIndex = index;
                      }),
                      child: Container(
                        width: 72,
                        margin: const EdgeInsets.symmetric(horizontal: 6),
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? const Color(0xFFE91E63)
                              : Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: isSelected
                                ? const Color(0xFFE91E63)
                                : Colors.grey.shade300,
                            width: 1.5,
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              _days[index].substring(0, 3),
                              style: GoogleFonts.poppins(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: isSelected
                                    ? Colors.white
                                    : Colors.black87,
                              ),
                            ),
                            CircleAvatar(
                              radius: 14,
                              backgroundColor: isSelected
                                  ? Colors.white
                                  : Colors.grey.shade200,
                              child: Text(
                                '${index + 1}',
                                style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: isSelected
                                      ? const Color(0xFFE91E63)
                                      : Colors.grey,
                                ),
                              ),
                            ),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(2),
                              child: LinearProgressIndicator(
                                value: completionRate,
                                minHeight: 3,
                                backgroundColor: Colors.grey.shade200,
                                valueColor: AlwaysStoppedAnimation(
                                  completionRate == 1
                                      ? Colors.green
                                      : const Color(0xFFE91E63),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),

              /// ================= HEADER =================
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _days[_selectedDayIndex],
                          style: GoogleFonts.poppins(
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          DateFormat('dd MMM yyyy')
                              .format(DateTime.now()),
                          style: GoogleFonts.poppins(color: Colors.grey),
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 6),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFCE4EC),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        '${provider.getActivitiesForDay(_days[_selectedDayIndex]).where((a) => a.isCompleted).length}'
                        '/${provider.getActivitiesForDay(_days[_selectedDayIndex]).length} selesai',
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFFE91E63),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              /// ================= LIST =================
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: _buildActivitiesList(provider),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  /// ================= ACTIVITY LIST =================
  Widget _buildActivitiesList(ActivityProvider provider) {
    final dayActivities =
        provider.getActivitiesForDay(_days[_selectedDayIndex]);

    if (dayActivities.isEmpty) {
      return const Center(child: Text('Belum ada kegiatan'));
    }

    return ListView.builder(
      itemCount: dayActivities.length,
      itemBuilder: (context, index) {
        final activity = dayActivities[index];

        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: ListTile(
            contentPadding: const EdgeInsets.all(16),
            title: Text(
              activity.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w600,
                decoration: activity.isCompleted
                    ? TextDecoration.lineThrough
                    : null,
              ),
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 6),
              child: Row(
                children: [
                  const Icon(Icons.access_time_rounded,
                      size: 14, color: Colors.grey),
                  const SizedBox(width: 4),

                  /// 🔧 FIX OVERFLOW
                  Expanded(
                    child: Text(
                      activity.time,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.poppins(
                        fontSize: 13,
                        color: Colors.grey,
                      ),
                    ),
                  ),

                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.pink.shade50,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      activity.category,
                      style: GoogleFonts.poppins(
                        fontSize: 10,
                        color: const Color(0xFFE91E63),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            trailing: Checkbox(
              value: activity.isCompleted,
              onChanged: (_) =>
                  provider.toggleActivityCompletion(activity.id),
            ),
          ),
        );
      },
    );
  }

  /// ================= DIALOG =================
  Future<void> _showAddActivityDialog(BuildContext context) async {}
}
