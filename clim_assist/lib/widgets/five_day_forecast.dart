import 'package:clim_assist/constants.dart';
import 'package:clim_assist/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/weather_provider.dart';

class FiveDayForecast extends StatelessWidget {
  Widget dayWidget(dynamic weather, BuildContext context) {
    final dayOfWeek = weather.date.toString();
    final temp = '${weather.dailyTemp}°C';
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              dayOfWeek,
              style: TextStyle(
                color: ColorConstants.fontColor,
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
            Text(
              temp,
              style: TextStyle(
                fontSize: 30,
                color: Colors.white,
                fontWeight: FontWeight.w400,
              ),
            ),
            Text(
              '${weather.condition}',
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
            const SizedBox(
              height: 20,
              width: 100,
            ),
          ],
        ),
        const SizedBox(
          height: 15,
          width: 145,
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: MapString.mapStringToIcon(
            context,
            '${weather.condition}',
            45,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(
            top: 15,
            left: 20,
          ),
          child: Text(
            'Next 5 days',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w400,
              color: ColorConstants.fontColor,
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.all(10),
          child: Material(
            elevation: 5,
            borderRadius: BorderRadius.circular(15),
            color: ColorConstants.primaryColor,
            child: ListView(
              padding: EdgeInsets.all(25),
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              children: [
                Consumer<WeatherProvider>(
                  builder: (context, weatherProv, _) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Today",
                              style: TextStyle(
                                color: ColorConstants.fontColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Text(
                              '${weatherProv.weather.temp.toStringAsFixed(1)}°C',
                              style: TextStyle(
                                fontSize: 30,
                                color: Colors.white,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            MapString.mapInputToWeather(
                              context,
                              weatherProv.weather.currently,
                            )
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 20),
                          child: MapString.mapStringToIcon(context, weatherProv.weather.currently, 45),
                        )
                      ],
                    );
                  },
                ),
                SizedBox(height: 15),
                Consumer<WeatherProvider>(
                  builder: (context, weatherProv, _) {
                    return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Column(
                        children: weatherProv.fiveDayWeather.map((item) => dayWidget(item, context)).toList(),
                      ),
                    );
                  },
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
