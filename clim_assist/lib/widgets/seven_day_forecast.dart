import 'package:clim_assist/constants.dart';
import 'package:clim_assist/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../provider/weather_provider.dart';

class sevenDayForecast extends StatelessWidget {
  const sevenDayForecast({super.key});

  Widget dayWidget(dynamic weather, BuildContext context) {
    final dayOfWeek = DateFormat('').format(weather.date);
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 7),
      child: Column(
        children: [
          FittedBox(
            child: Text(
              dayOfWeek,
              style: TextStyle(
                color: ColorConstants.fontColor,
                fontSize: 20,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(5, 5, 5, 20),
            child: MapString.mapStringToIcon(
              context,
              '${weather.condition}',
              35,
            ),
          ),
          Text(
            '${weather.condition}',
            style: TextStyle(color: ColorConstants.fontColor),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            top: 15,
            left: 20,
          ),
          child: Text(
            'Next 7 days',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w400,
              color: ColorConstants.fontColor,
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.all(15),
          child: Material(
            elevation: 5,
            borderRadius: BorderRadius.circular(15),
            color: ColorConstants.primaryColor,
            child: ListView(
              padding: const EdgeInsets.all(25),
              shrinkWrap: true,
              children: [
                Consumer<WeatherProvider>(
                  builder: (context, weatherProv, _) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                          Text('Today',
                              style: TextStyle(
                                color: ColorConstants.fontColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              )),
                          Text(
                            '${weatherProv.weather.temp.toStringAsFixed(1)}°C',
                            style: const TextStyle(
                              fontSize: 30,
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          MapString.mapInputToWeather(
                            context,
                            weatherProv.weather.currently,
                          )
                        ]),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: MapString.mapStringToIcon(context, weatherProv.weather.currently, 45),
                        )
                      ],
                    );
                  },
                ),
                const SizedBox(height: 15),
                Consumer<WeatherProvider>(
                  builder: (context, weatherProv, _) {
                    return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: weatherProv.sevenDayWeather.map((item) => dayWidget(item, context)).toList(),
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
