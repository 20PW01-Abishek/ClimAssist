import 'package:clim_assist/screens/splash_screen.dart';
import 'package:clim_assist/widgets/today_weather_widget.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ClimAssist',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: 
      SplashScreen()
      // todayWeatherWidget()
    );
  }
}