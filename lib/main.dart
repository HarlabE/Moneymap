import 'package:app/widgets/expenses.dart';
import 'package:flutter/material.dart';

var kDarkColorScheme =
    ColorScheme.fromSeed(
      brightness: Brightness.dark,
      seedColor: const Color.fromARGB(255, 5, 99, 125));

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        darkTheme: ThemeData.dark().copyWith(
            useMaterial3: true,
            colorScheme: kDarkColorScheme,
            cardTheme: const CardTheme().copyWith(
                color: kDarkColorScheme.secondaryContainer,
                margin:
                    const EdgeInsets.symmetric( 
                      horizontal: 16,
                      vertical: 8))),
        debugShowCheckedModeBanner: false,
        home: const Expenses());
  }
}
