import 'package:clim_assist/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'screens/hourlyWeather.dart';
import './provider/weatherProvider.dart';
import 'screens/weeklyWeather.dart';
import 'screens/homeScreen.dart';

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
        home: HomeScreen(),
        routes: {
          weeklyWeather.routeName: (myCtx) => weeklyWeather(),
          hourlyWeather.routeName: (myCtx) => hourlyWeather(),
        },
      ),
    );
  }
}
