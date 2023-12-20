import 'package:ecommerce_app/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

final kColorScheme = ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 25, 200, 235));

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: kColorScheme,
        useMaterial3: true,
        scaffoldBackgroundColor: const Color.fromARGB(255, 213, 237, 249),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
        ),
        textTheme: GoogleFonts.robotoTextTheme().copyWith(
          titleLarge: TextStyle(
            fontWeight: FontWeight.w800,
            color: kColorScheme.secondary,
          ),
          bodyLarge: TextStyle(
            fontWeight: FontWeight.w700,
            color: kColorScheme.onBackground,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: kColorScheme.primaryContainer,
            foregroundColor: kColorScheme.onPrimary,
          ),
        ),
      ),
      home: const HomeScreen(),
    );
  }
}
