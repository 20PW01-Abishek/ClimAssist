import 'package:clim_assist/constants.dart';
import 'package:clim_assist/widgets/SunAnimation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_weather_icons/flutter_weather_icons.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'dart:async';

void main() {
  runApp(SunriseSunsetApp());
}

class SunriseSunsetApp extends StatefulWidget {
  @override
  _SunriseSunsetState createState() => _SunriseSunsetState();
}

class _SunriseSunsetState extends State<SunriseSunsetApp> {
  late String _timeString = "";
  String _locationString = "";
  String _sunriseTimeString = "";
  String _sunsetTimeString = "";
  String _temperatureString = "";
  String _weatherConditionString = "";
  bool _isDaytime = true;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
    _updateTime();
    _getCurrentWeather();
  }

  void _getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    Placemark placemark = placemarks[0];
    setState(() {
      _locationString =
          '${placemark.locality}, ${placemark.administrativeArea}, ${placemark.country}';
    });
  }

  void _updateTime() {
    Timer.periodic(Duration(seconds: 1), (Timer t) {
      setState(() {
        _timeString = DateFormat.jm().format(DateTime.now());
      });
    });
  }

  void _getCurrentWeather() {
    setState(() {
      _temperatureString = "30°C";
      _weatherConditionString = "Sunny";
    });
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    DateTime now = DateTime.now();
    // DateTime now=DateTime(2021, 8, 20, 15, 30);
    DateTime sunriseTime = DateTime(now.year, now.month, now.day, 6, 30);
    DateTime sunsetTime = DateTime(now.year, now.month, now.day, 18, 0);

    if (now.isBefore(sunriseTime) || now.isAfter(sunsetTime)) {
      _isDaytime = false;
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          height: screenHeight,
          width: screenWidth,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: DateTime.now().hour < 12 // if current time is morning
                  ? [ColorConstants.primaryColor, ColorConstants.primaryColor] 
                  : [ColorConstants.primaryColor, ColorConstants.primaryColor],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                child: Column(
                  children: [
                    Text(
                      _locationString,
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: ColorConstants.fontColor),
                    ),
                    SizedBox(height: 10),
                    Text(
                      DateFormat.yMMMEd().format(DateTime.now()),
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: ColorConstants.fontColor),
                    ),
                    SizedBox(height: 10),
                    Text(
                      _timeString,
                      style: TextStyle(
                          fontSize: 42,
                          fontWeight: FontWeight.bold,
                          color: ColorConstants.secondaryColor),
                    ),
                  ],
                ),
              ),
              Container(
                child: Column(
                  children: [
                    // SvgPicture.asset(
                    //   _isDaytime
                    //       ? 'assets/images/suntemp.svg'
                    //       : 'assets/images/suntemp.svg',
                    //   height: 100,
                    // ),
                    SunAnimation(),
                    SizedBox(height: 10),
                    Text(
                      'Sunrise and Sunset',
                      style: TextStyle(fontSize: 24, color: Colors.white),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Sunrise: ${DateFormat.jm().format(sunriseTime)}',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Sunset: ${DateFormat.jm().format(sunsetTime)}',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ],
                ),
              ),
              Container(
                child: Column(
                  children: [
                    Icon(
                      _isDaytime
                          ? WeatherIcons.wiSunrise
                          : WeatherIcons.wiSunset,
                      size: 100,
                      color: ColorConstants.secondaryColor,
                    ),
                    SizedBox(height: 10),
                    Text(
                      _temperatureString,
                      style: TextStyle(fontSize: 24, color: Colors.white),
                    ),
                    SizedBox(height: 10),
                    Text(
                      _weatherConditionString,
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
