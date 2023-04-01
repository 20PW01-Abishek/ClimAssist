import 'dart:convert';
import 'package:clim_assist/models/weather.dart';
import 'package:clim_assist/models/daily_weather.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
import 'package:dio/dio.dart';

class WeatherProvider with ChangeNotifier {
  String apiKey = '4aaf3f194039c2eae46d6693c587b8d8';
  LatLng? currentLocation;
  late Weather weather;
  DailyWeather currentWeather = DailyWeather();
  List<DailyWeather> hourlyWeather = [];
  List<DailyWeather> hourly24Weather = [];
  List<DailyWeather> fiveDayWeather = [];
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
  List<String> get favoriteLocations => _favoriteLocations;

  // Add a location to favorites
  void addFavoriteLocation(String location) {
    if (!_favoriteLocations.contains(location)) {
      _favoriteLocations.add(location);
      notifyListeners();
    }
  }

  List<String> _favorites = [];

  void addToFavorites(String location) {
    _favorites.add(location);
  }

  void removeFromFavorites(String location) {
    _favorites.remove(location);
  }

  bool isFavorite(String location) {
    return _favorites.contains(location);
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
      isRequestError = true;
      rethrow;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> getDailyWeather(LatLng location) async {
    isLoading = true;
    notifyListeners();

    Uri forecast = Uri.parse(
      'https://api.openweathermap.org/data/2.5/forecast?lat=${location.latitude}&lon=${location.longitude}&units=metric&appid=$apiKey',
    );
    try {
      final res = await http.get(forecast);
      final dailyData = json.decode(res.body) as Map<String, dynamic>;

      hourlyWeather = [];
      for (int i = 1; i <= 3; i++) {
        Map<String, dynamic> hour = dailyData["list"][i];
        DailyWeather h = DailyWeather.fromHourlyJson(hour);
        hourlyWeather.add(h);
      }

      fiveDayWeather = [];
      for (int i = 1; i < 6; i++) {
        Map<String, dynamic> day = dailyData["list"][i * 8];
        DailyWeather d = DailyWeather.fromDailyJson(day);
        fiveDayWeather.add(d);
      }
    } catch (error) {
      isRequestError = true;
      rethrow;
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
      isRequestError = true;
      rethrow;
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
      return [];
    }
  }
}
