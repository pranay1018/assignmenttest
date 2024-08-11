import 'package:assignmenttest/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:assignmenttest/view/screens/home_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  ProviderScope(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.system,
        theme: MyAppTheme.lightTheme,
        darkTheme: MyAppTheme.dartTheme,
        home: const HomePage(),
      ),
    );
  }
}

