import 'package:flutter/material.dart';
import 'package:fungid3/screens/home_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'screens/ai_screen.dart';
import 'screens/splash_screen.dart';
import 'screens/output_screen.dart';

void main() {
  runApp(const MyApp());
}




class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FungiGuard',
      theme: ThemeData(
        primaryColor: const Color(0xFF4CAF50),
        textTheme: GoogleFonts.poppinsTextTheme(), // font global
        scaffoldBackgroundColor: const Color(0xFFF5F5F5),
      ),
      home: const SplashScreen(), // Halaman pertama yang dijalankan
    );
  }
}
