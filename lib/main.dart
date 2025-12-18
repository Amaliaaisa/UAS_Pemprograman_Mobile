import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';
import 'providers/note_provider.dart';
import 'providers/settings_provider.dart';
import 'providers/menstruation_provider.dart';
import 'providers/activity_provider.dart';
import 'views/onboarding/onboarding_screen.dart';
import 'views/onboarding/home/home_screen.dart';
import 'views/onboarding/notes/notes_list_screen.dart';
import 'views/onboarding/notes/note_form_screen.dart';
import 'views/onboarding/menstruation/menstruation_tracker_screen.dart';
import 'views/onboarding/weekly/weekly_activity_screen.dart';
import 'views/onboarding/notes/notes_history_screen.dart';
import 'views/onboarding/settings/settings_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    if (kDebugMode) {
      print('Firebase initialized successfully');
    }
  } catch (e) {
    if (kDebugMode) {
      print('Firebase initialization failed: $e');
    }
  }

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => NoteProvider()),
        ChangeNotifierProvider(create: (_) => SettingsProvider()),
        ChangeNotifierProvider(create: (_) => MenstruationProvider()),
        ChangeNotifierProvider(create: (_) => ActivityProvider()),
      ],
      child: const DailyGlowApp(),
    ),
  );
}

class DailyGlowApp extends StatelessWidget {
  const DailyGlowApp({super.key});

  @override
  Widget build(BuildContext context) {
    final settings = context.watch<SettingsProvider>();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'DailyGlow',

      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFE91E63),
          brightness: settings.isDark ? Brightness.dark : Brightness.light,
        ),
        scaffoldBackgroundColor:
            settings.isDark ? const Color(0xFF121212) : const Color(0xFFFEF6F9),
        appBarTheme: AppBarTheme(
          centerTitle: true,
          elevation: 0,
          backgroundColor: settings.isDark ? Colors.black : Colors.white,
          iconTheme: IconThemeData(
            color: settings.isDark ? Colors.white : const Color(0xFF333333),
          ),
          titleTextStyle: TextStyle(
            color: settings.isDark ? Colors.white : const Color(0xFF333333),
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      // ROUTING
      initialRoute: '/onboarding',
      routes: {
        '/onboarding': (context) => const OnboardingScreen(),
        '/home': (context) => const HomeScreen(),
        '/notes': (context) => const NotesListScreen(),
        '/add-note': (context) => const NoteFormScreen(),
        '/menstruation': (context) => const MenstruationTrackerScreen(),
        '/weekly': (context) => const WeeklyActivityScreen(),
        '/history': (context) => const NotesHistoryScreen(),
        '/settings': (context) => const SettingsScreen(),
      },

      home: const OnboardingScreen(),
    );
  }
}
