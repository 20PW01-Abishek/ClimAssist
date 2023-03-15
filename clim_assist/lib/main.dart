import 'package:clim_assist/constants.dart';
import 'package:clim_assist/screens/splash_screen.dart';
import 'package:clim_assist/widgets/sunrise_sunset.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'screens/hourly_weather.dart';
import './provider/weatherProvider.dart';
import 'screens/weekly_weather.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
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
        // SunriseSunsetApp()
        //  HomeScreen(),
        // sunriseSunset(sunrise: sunrise, sunset: sunset)
        // routes: {
        //   weeklyWeather.routeName: (myCtx) => weeklyWeather(),
        //   hourlyWeather.routeName: (myCtx) => hourlyWeather(),
        // },
        // home:sunriseSunset(sunrise: , sunset: sunset)
      ),
    );
  }
}
