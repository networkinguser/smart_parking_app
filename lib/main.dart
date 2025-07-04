import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';

void main() {
  runApp(SmartParkingApp());
}

class SmartParkingApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smart Parking',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.grey[100],
        appBarTheme: AppBarTheme(
         backgroundColor: Colors.blue[800],
         foregroundColor: Colors.white,
         ),
      ),
      home: SplashScreen(),
    );
  }
}
