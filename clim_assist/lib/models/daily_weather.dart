import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class DailyWeather with ChangeNotifier {
  final dynamic dailyTemp;
  final String? condition;
  final String? date;

  DailyWeather({
    this.dailyTemp,
    this.condition,
    this.date,
  });

  factory DailyWeather.fromJson(Map<String, dynamic> json) {
    return DailyWeather(
      dailyTemp: json['main']['temp'],
      condition: json['weather'][0]['main'],
      date: DateFormat('hh:mm a').format(DateTime.fromMillisecondsSinceEpoch(json['dt'] * 1000)),
    );
  }

  static DailyWeather fromDailyJson(dynamic json) {
    return DailyWeather(
      dailyTemp: json['main']['temp'],
      condition: json['weather'][0]['main'],
      date: DateFormat('hh:mm a').format(DateTime.fromMillisecondsSinceEpoch(json['dt'] * 1000)),
    );
  }

  static DailyWeather fromHourlyJson(dynamic json) {
    return DailyWeather(
      dailyTemp: json['main']['temp'],
      condition: json['weather'][0]['main'],
      date: DateFormat('hh:mm a').format(DateTime.fromMillisecondsSinceEpoch(json['dt'] * 1000)),
    );
  }
}
