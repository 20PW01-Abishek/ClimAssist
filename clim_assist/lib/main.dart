
import 'package:clim_assist/screens/hourlyWeather.dart';
import 'package:clim_assist/screens/splashScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// import 'screens/hourlyWeatherScreen.dart';
import './provider/weatherProvider.dart';
// import 'screens/weeklyWeatherScreen.dart';
// import 'screens/homeScreen.dart';

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
        title: 'ClimAssist',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          appBarTheme: AppBarTheme(
            iconTheme: IconThemeData(
              color: Colors.blue,
            ),
            elevation: 0,
          ),
          scaffoldBackgroundColor: Colors.white,
          primaryColor: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          colorScheme:
              ColorScheme.fromSwatch().copyWith(secondary: Colors.white),
        ),
        home: 
        // SplashScreen(),
        hourlyWeather()
        // routes: {
        //   WeeklyScreen.routeName: (myCtx) => WeeklyScreen(),
        //   HourlyScreen.routeName: (myCtx) => HourlyScreen(),
        // },
      ),
    );
  }
}
