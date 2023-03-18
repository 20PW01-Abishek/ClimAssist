import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
import 'package:dio/dio.dart';
import '../models/daily_weather.dart';
import '../models/weather.dart';

class WeatherProvider with ChangeNotifier {

  String apiKey = '4aaf3f194039c2eae46d6693c587b8d8';
  LatLng? currentLocation;
  late Weather weather;
  DailyWeather currentWeather = DailyWeather();
  List<DailyWeather> hourlyWeather = [];
  List<DailyWeather> hourly24Weather = [];
  List<DailyWeather> fiveDayWeather = [];
  List<DailyWeather> sevenDayWeather = [];
  bool isLoading = false;
  bool isRequestError = false;
  bool isLocationError = false;

  Future<void> getWeatherData({bool isRefresh = false}) async {
    isLoading = true;
    isRequestError = false;
    isLocationError = false;
    if (isRefresh) notifyListeners();
    await Location().requestService().then(
      (value) async {
        if (value) {
          final locData = await Location().getLocation();
          currentLocation = LatLng(locData.latitude!, locData.longitude!);
          await getCurrentWeather(currentLocation!);
          await getDailyWeather(currentLocation!);
        } else {
          isLoading = false;
          isLocationError = true;
          notifyListeners();
        }
      },
    );
  }

  List<String> _favoriteLocations = [];

  // Getter for favorite locations
  List<String> get favoriteLocations => _favoriteLocations;

  // Add a location to favorites
  void addFavoriteLocation(String location) {
    if (!_favoriteLocations.contains(location)) {
      _favoriteLocations.add(location);
      notifyListeners();
    }
  }

  // Remove a location from favorites
  void removeFavoriteLocation(String location) {
    if (_favoriteLocations.contains(location)) {
      _favoriteLocations.remove(location);
      notifyListeners();
    }
  }

  // Check if a location is a favorite
  bool isFavoriteLocation(String location) {
    return _favoriteLocations.contains(location);
  }

  // Toggle a location's favorite status
  void toggleFavoriteLocation(String location) {
    if (isFavoriteLocation(location)) {
      removeFavoriteLocation(location);
    } else {
      addFavoriteLocation(location);
    }
  }
  

  Future<void> getCurrentWeather(LatLng location) async {
    Uri url = Uri.parse(
      'https://api.openweathermap.org/data/2.5/weather?lat=${location.latitude}&lon=${location.longitude}&units=metric&appid=$apiKey',
    );
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      weather = Weather.fromJson(extractedData);
    } catch (error) {
      print(error);
      this.isRequestError = true;
      throw error;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> getDailyWeather(LatLng location) async {
    isLoading = true;
    notifyListeners();

    Uri dailyUrl = Uri.parse(
      'https://api.openweathermap.org/data/2.5/onecall?lat=${location.latitude}&lon=${location.longitude}&units=metric&exclude=minutely,current&appid=$apiKey',
    );
    try {
      final response = await http.get(dailyUrl);
      inspect(response.body);
      final dailyData = json.decode(response.body) as Map<String, dynamic>;
      currentWeather = DailyWeather.fromJson(dailyData);
      List<DailyWeather> tempHourly = [];
      List<DailyWeather> temp24Hour = [];
      List<DailyWeather> tempSevenDay = [];
      List items = dailyData['daily'];
      List itemsHourly = dailyData['hourly'];
      tempHourly = itemsHourly
          .map((item) => DailyWeather.fromHourlyJson(item))
          .toList()
          .skip(1)
          .take(3)
          .toList();
        

      temp24Hour = itemsHourly
          .map((item) => DailyWeather.fromHourlyJson(item))
          .toList()
          .skip(1)
          .take(24)
          .toList();
      tempSevenDay = items
          .map((item) => DailyWeather.fromDailyJson(item))
          .toList()
          .skip(1)
          .take(7)
          .toList();
      hourlyWeather = tempHourly;
      hourly24Weather = temp24Hour;
      sevenDayWeather = tempSevenDay;
    } catch (error) {
      print(error);
      this.isRequestError = true;
      throw error;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> searchWeatherWithLocation(String location) async {
    Uri url = Uri.parse(
      'https://api.openweathermap.org/data/2.5/weather?q=$location&units=metric&appid=$apiKey',
    );
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      weather = Weather.fromJson(extractedData);
    } catch (error) {
      this.isRequestError = true;
      throw error;
    }
  }

  Future<void> searchWeather({required String location}) async {
    isLoading = true;
    isRequestError = false;
    isLocationError = false;
    double latitude = weather.lat;
    double longitude = weather.long;
    await searchWeatherWithLocation(location);
    await getDailyWeather(LatLng(latitude, longitude));
  }

  Future<List<String>> searchLocations({required String query}) async {
    try {
      final response = await Dio().get(
        "https://api.openweathermap.org/geo/1.0/direct",
        queryParameters: {
          "q": query,
          "limit": 5,
          "appid": apiKey,
        },
      );
      final List<String> locations = [];
      response.data.forEach((location) {
        locations.add(location['name']);
      });
      return locations;
    } catch (e) {
      print(e);
      return [];
    }
  }
}
