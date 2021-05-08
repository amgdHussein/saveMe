import 'package:flutter/material.dart';
import 'config/routes/routes.dart';
import 'config/themes/light_theme.dart';
import 'core/on_boarding/on_boarding.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AppRouter _router = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'save me',
      debugShowCheckedModeBanner: false,
      onGenerateRoute: _router.generateRoute,
      themeMode: ThemeMode.light,
      theme: lightTheme,
      // home: OnboardingScreen(),
    );
  }

  @override
  void dispose() {
    _router.dispose();
    super.dispose();
  }
}
