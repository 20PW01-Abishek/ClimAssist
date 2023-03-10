import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_weather_icons/flutter_weather_icons.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:async';

void main() {
  runApp(SunriseSunsetApp());
}

class SunriseSunsetApp extends StatefulWidget {
  @override
  _SunriseSunsetState createState() => _SunriseSunsetState();
}

class _SunriseSunsetState extends State<SunriseSunsetApp> {
  late String _timeString;
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
    List<Placemark> placemarks = await Geolocator.placemarkFromCoordinates(
        position.latitude, position.longitude);
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
    // Code to get the current weather information using an API
    // ...
    setState(() {
      _temperatureString = "72°F";
      _weatherConditionString = "Sunny";
    });
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    DateTime now = DateTime.now();
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
              colors: _isDaytime
                  ? [Colors.yellow[200], Colors.orange[300]]
                  : [Colors.deepPurple[400], Colors.blue[900]],
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
                          color: Colors.white),
                    ),
                    SizedBox(height: 10),
                    Text(
                      DateFormat.yMMMEd().format(DateTime.now()),
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    SizedBox(height: 10),
                    Text(
                      _timeString,
                      style: TextStyle(
                          fontSize: 42,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ],
                ),
              ),
              Container(
                child: Column(
                  children: [
                    SvgPicture.asset(
                      _isDaytime
                          ? 'assets/images/sun.svg'
                          : 'assets/images/sun.svg',
                      height: 100,
                    ),
                    SizedBox(height: 10),
                    Text(
                      _isDaytime ? "Sunrise" : "Sunset",
                      style: TextStyle(fontSize: 24, color: Colors.white),
                    ),
                    SizedBox(height: 10),
                    Text(
                      _isDaytime
                          ? DateFormat.jm().format(sunriseTime)
                          : DateFormat.jm().format(sunsetTime),
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
                          ? WeatherIcons.day_sunny
                          : WeatherIcons.night_clear,
                      size: 100,
                      color: Colors.white,
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
