import 'package:clim_assist/constants.dart';
import 'package:flutter/material.dart';
import '../provider/weatherProvider.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../screens/hourlyWeather.dart';
import '../utils/utils.dart';

class HourlyForecast extends StatelessWidget {
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
                  fontWeight: FontWeight.bold,
                ),
              ),
              ElevatedButton(
                child: Text(
                  'See More',
                  style: TextStyle(color: Colors.blue),
                ),
                onPressed: () {
                  Navigator.of(context).pushNamed(hourlyWeather.routeName);
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
