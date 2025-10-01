import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'screens/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Number Guess Game',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.black,
        textTheme: TextTheme(
          headlineSmall: GoogleFonts.pressStart2p(
            fontSize: 22,
            color: Colors.yellowAccent,
            shadows: [
              Shadow(
                offset: const Offset(3, 3),
                blurRadius: 12,
                color: Colors.red.withValues(alpha: 0.9),
              ),
              Shadow(
                offset: const Offset(-3, -3),
                blurRadius: 12,
                color: Colors.cyanAccent.withValues(alpha: 0.9),
              ),
            ],
          ),
          bodyLarge: GoogleFonts.nunito(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          bodyMedium: GoogleFonts.nunito(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      home: const HomeScreen(),
    );
  }
}
