import 'package:clim_assist/constants.dart';
import 'package:flutter/material.dart';
import '../provider/weather_provider.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../screens/hourly_weather.dart';
import '../utils/utils.dart';

class HourlyForecast extends StatelessWidget {
  const HourlyForecast({super.key});

  Widget hourlyWidget(dynamic weather, BuildContext context) {
    final currentTime = weather.date;
    final hours = DateFormat.Hm().format(currentTime);
    return Container(
      height: 175,
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
                  Container(
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
                  primary: ColorConstants.secondaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'See More',
                  style: TextStyle(color: Colors.black),
                ),
                onPressed: () {
                  Navigator.of(context).pushNamed(HourlyWeather.routeName);
                },
              ),
            ],
          ),
        ),
        SizedBox(height: 5),
        Consumer<WeatherProvider> (builder: (context, weatherProv,_) {
          return Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: weatherProv.hourlyWeather
                  .map((item) => hourlyWidget(item, context))
                  .toList());
        }),
      ],
    );
  }
}
