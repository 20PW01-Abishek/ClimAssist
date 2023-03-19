import 'package:clim_assist/constants.dart';
import 'package:clim_assist/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'provider/weather_provider.dart';

void main() {
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => WeatherProvider(),
      child: MaterialApp(
        title: 'Clim Assist',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          appBarTheme: AppBarTheme(
            iconTheme: IconThemeData(
              color: ColorConstants.secondaryColor,
            ),
            elevation: 0,
          ),
          scaffoldBackgroundColor: ColorConstants.primaryColor,
          primaryColor: ColorConstants.secondaryColor,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          colorScheme:
              ColorScheme.fromSwatch().copyWith(secondary: ColorConstants.secondaryColor),
        ),
        home:
        SplashScreen()
      ),
    );
  }
}
