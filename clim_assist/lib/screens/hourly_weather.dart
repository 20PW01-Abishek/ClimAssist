import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../constants.dart';
import '../utils/utils.dart';
import '../provider/weather_provider.dart';

// ignore: must_be_immutable
class HourlyWeather extends StatelessWidget {
  static const routeName = '/hourlyWeather';
  dynamic weather;

  Widget hourlyWidget(dynamic weather, BuildContext context) {
    final time = weather.date;
    final hours = DateFormat.Hm().format(time);
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
      child: Material(
        elevation: 5,
        color: ColorConstants.primaryColor,
        borderRadius: BorderRadius.circular(15.0),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Text(
                hours,
                style: TextStyle(
                  color: ColorConstants.fontColor,
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const Spacer(),
              Text(
                '${weather.dailyTemp.toStringAsFixed(1)}°',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(width: 16.0),
              MapString.mapStringToIcon(context, weather.condition, 25),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final weatherData = Provider.of<WeatherProvider>(context);
    final mediaQuery = MediaQuery.of(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: ColorConstants.primaryColor,
          title: Text(
            'Next 24 Hours',
            style: TextStyle(color: ColorConstants.fontColor),
          ),
        ),
        body: SizedBox(
          height: mediaQuery.size.height,
          width: mediaQuery.size.width,
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: weatherData.hourly24Weather.map((item) => hourlyWidget(item, context)).toList(),
          ),
        ),
      ),
    );
  }
}
