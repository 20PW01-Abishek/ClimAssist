import 'package:flutter/cupertino.dart';

class DailyWeather with ChangeNotifier {
  final dynamic dailyTemp;
  final String? condition;
  final DateTime? date;
  final DateTime? sunrise;
  final DateTime? sunset;

  DailyWeather({
    this.dailyTemp,
    this.condition,
    this.date,
    this.sunrise,
    this.sunset,
  });

  factory DailyWeather.fromJson(Map<String, dynamic> json) {
    return DailyWeather(
      dailyTemp: json['temp']['day'],
      condition: json['weather'][0]['main'],
      date: DateTime.fromMillisecondsSinceEpoch(json['dt'] * 1000, isUtc: true),
      sunrise: DateTime.fromMillisecondsSinceEpoch(json['city']['sunrise'] * 1000),
      sunset: DateTime.fromMillisecondsSinceEpoch(json['city']['sunset'] * 1000),
    );
  }

  static DailyWeather fromDailyJson(dynamic json) {
    return DailyWeather(
      dailyTemp: json['temp']['day'],
      condition: json['weather'][0]['main'],
      date: DateTime.fromMillisecondsSinceEpoch(json['dt'] * 1000, isUtc: true),
    );
  }

  static DailyWeather fromHourlyJson(dynamic json) {
    return DailyWeather(
      dailyTemp: json['temp'],
      condition: json['weather'][0]['main'],
      date: DateTime.fromMillisecondsSinceEpoch(json['dt'] * 1000),
    );
  }
}
