import 'package:clim_assist/constants.dart';
import 'package:clim_assist/provider/weather_provider.dart';
import 'package:clim_assist/screens/favorites_screen.dart';
import 'package:clim_assist/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HourlyForecast extends StatelessWidget {
  Widget hourlyWidget(dynamic weather, BuildContext context) {
    final currentTime = weather.date.toString();
    final hours = currentTime.toString();
    return Container(
      height: 175,
      width: 100,
      padding: const EdgeInsets.all(5.0),
      child: Material(
        elevation: 5,
        borderRadius: BorderRadius.circular(15),
        color: ColorConstants.primaryColor,
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    hours,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      color: ColorConstants.fontColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  MapString.mapStringToIcon(
                    context,
                    '${weather.condition}',
                    50,
                  ),
                  SizedBox(
                    width: 80,
                    child: Text(
                      "${weather.dailyTemp.toStringAsFixed(1)}°C",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                        color: ColorConstants.fontColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Next 3 Hours',
                style: TextStyle(
                  fontSize: 17,
                  color: ColorConstants.fontColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorConstants.secondaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'View Favorites',
                  style: TextStyle(color: Colors.black),
                ),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => FavoritesScreen()));
                },
              ),
            ],
          ),
        ),
        const SizedBox(height: 5),
        Consumer<WeatherProvider>(
          builder: (context, weatherProv, _) {
            return Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: weatherProv.hourlyWeather.map((item) => hourlyWidget(item, context)).toList());
          },
        ),
      ],
    );
  }
}
