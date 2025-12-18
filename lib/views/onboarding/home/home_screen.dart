import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../../widgets/dashboard_card.dart';
import '../../../providers/note_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final noteProvider = Provider.of<NoteProvider>(context);
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 360;

    return Scaffold(
      backgroundColor: const Color(0xFFFEF6F9),
      appBar: AppBar(
        title: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFFE91E63), Color(0xFFC2185B)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFFE91E63).withOpacity(0.2),
                blurRadius: 6,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.spa_rounded,
                color: Colors.white,
                size: 22,
              ),
              const SizedBox(width: 8),
              Text(
                'DailyGlow',
                style: GoogleFonts.poppins(
                  fontSize: isSmallScreen ? 17 : 19,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 4),
              const Text(
                '✨',
                style: TextStyle(fontSize: 17),
              ),
            ],
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        toolbarHeight: 60,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(
              horizontal: isSmallScreen ? 14 : 16, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Welcome Header
              Container(
                margin: const EdgeInsets.only(bottom: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Halo, Cantik! 👋',
                      style: GoogleFonts.poppins(
                        fontSize: isSmallScreen ? 20 : 22,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF333333),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Rutinitas kecantikanmu hari ini sudah selesai?',
                      style: GoogleFonts.poppins(
                        fontSize: isSmallScreen ? 13 : 14,
                        color: const Color(0xFF666666),
                      ),
                    ),
                  ],
                ),
              ),

              // Quote Card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                margin: const EdgeInsets.only(bottom: 24),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Colors.white, Color(0xFFFEF5F9)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(18),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.pink.withOpacity(0.08),
                      blurRadius: 15,
                      offset: const Offset(0, 5),
                    ),
                  ],
                  border: Border.all(
                    color: const Color(0xFFF8E0E8),
                    width: 1.5,
                  ),
                ),
                child: Column(
                  children: [
                    // Header Quote
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.auto_awesome_rounded,
                          size: 18,
                          color: Colors.pink.shade300,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Kutipan Inspirasi',
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                            color: const Color(0xFFE91E63),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 14),

                    // Quote Content
                    noteProvider.isQuoteLoading
                        ? Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2.5,
                                    color: Colors.pink.shade300,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  'Memuat kutipan...',
                                  style: GoogleFonts.poppins(
                                    fontSize: 12,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          )
                        : Text(
                            noteProvider.dailyQuote,
                            style: GoogleFonts.poppins(
                              fontSize: isSmallScreen ? 13.5 : 14,
                              color: const Color(0xFF555555),
                              fontStyle: FontStyle.italic,
                              height: 1.5,
                            ),
                            textAlign: TextAlign.center,
                          ),

                    const SizedBox(height: 16),

                    // Refresh Button
                    GestureDetector(
                      onTap: () => noteProvider.fetchDailyQuote(),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(25),
                          border: Border.all(
                            color: const Color(0xFFF0D1DC),
                            width: 1.5,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.pink.withOpacity(0.05),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.refresh_rounded,
                              size: 16,
                              color: Colors.pink.shade400,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              'Kutipan Baru',
                              style: GoogleFonts.poppins(
                                fontSize: 12.5,
                                fontWeight: FontWeight.w500,
                                color: Colors.pink.shade500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Features Header
              Container(
                margin: const EdgeInsets.only(bottom: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Menu Utama',
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w700,
                            fontSize: 19,
                            color: const Color(0xFF333333),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 5),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFCE4EC),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            '6 Menu',
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFFE91E63),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Kelola rutinitas harianmu dengan mudah',
                      style: GoogleFonts.poppins(
                        fontSize: isSmallScreen ? 12.5 : 13.5,
                        color: const Color(0xFF666666),
                      ),
                    ),
                  ],
                ),
              ),

              // Dashboard Grid - Responsive
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: isSmallScreen ? 10 : 12,
                mainAxisSpacing: isSmallScreen ? 10 : 12,
                childAspectRatio: isSmallScreen ? 1.0 : 1.05,
                padding: EdgeInsets.zero,
                children: [
                  DashboardCard(
                    icon: Icons.note_alt_rounded,
                    title: 'Catatan\nKecantikan',
                    color: Colors.white,
                    iconColor: const Color(0xFFE91E63),
                    textColor: const Color(0xFF333333),
                    shadowColor: const Color(0xFFFCE4EC),
                    onTap: () => Navigator.pushNamed(context, '/notes'),
                  ),
                  DashboardCard(
                    icon: Icons.add_circle_rounded,
                    title: 'Tambah\nCatatan',
                    color: Colors.white,
                    iconColor: const Color(0xFFFF9800),
                    textColor: const Color(0xFF333333),
                    shadowColor: const Color(0xFFFFF3E0),
                    onTap: () => Navigator.pushNamed(context, '/add-note'),
                  ),
                  DashboardCard(
                    icon: Icons.water_drop_rounded,
                    title: 'Pelacak\nMenstruasi',
                    color: Colors.white,
                    iconColor: const Color(0xFFE91E63),
                    textColor: const Color(0xFF333333),
                    shadowColor: const Color(0xFFFCE4EC),
                    onTap: () => Navigator.pushNamed(context, '/menstruation'),
                  ),
                  DashboardCard(
                    icon: Icons.calendar_month_rounded,
                    title: 'Kalender\nKegiatan',
                    color: Colors.white,
                    iconColor: const Color(0xFF2196F3),
                    textColor: const Color(0xFF333333),
                    shadowColor: const Color(0xFFE3F2FD),
                    onTap: () => Navigator.pushNamed(context, '/weekly'),
                  ),
                  DashboardCard(
                    icon: Icons.history_rounded,
                    title: 'Riwayat\nCatatan',
                    color: Colors.white,
                    iconColor: const Color(0xFF9C27B0),
                    textColor: const Color(0xFF333333),
                    shadowColor: const Color(0xFFF3E5F5),
                    onTap: () => Navigator.pushNamed(context, '/history'),
                  ),
                  DashboardCard(
                    icon: Icons.settings_rounded,
                    title: 'Pengaturan',
                    color: Colors.white,
                    iconColor: const Color(0xFF4CAF50),
                    textColor: const Color(0xFF333333),
                    shadowColor: const Color(0xFFE8F5E9),
                    onTap: () => Navigator.pushNamed(context, '/settings'),
                  ),
                ],
              ),

              // App Info Footer
              Container(
                margin: const EdgeInsets.only(top: 24, bottom: 20),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: const Color(0xFFF0F0F0),
                    width: 1,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.spa_rounded,
                          size: 18,
                          color: Colors.pink.shade400,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'DailyGlow Beauty Tracker',
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                            color: const Color(0xFF333333),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Aplikasi pendamping rutinitas kecantikan perempuan Indonesia',
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: const Color(0xFF666666),
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 12),
                    Container(
                      height: 1,
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      color: const Color(0xFFF0F0F0),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.favorite_rounded,
                          size: 12,
                          color: Colors.pink.shade300,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          'Made with love for Indonesian women',
                          style: GoogleFonts.poppins(
                            fontSize: 11,
                            color: const Color(0xFF999999),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
