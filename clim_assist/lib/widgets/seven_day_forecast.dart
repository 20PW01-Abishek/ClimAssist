  import 'package:clim_assist/constants.dart';
  import 'package:clim_assist/utils/utils.dart';
  import 'package:flutter/material.dart';
  import 'package:intl/intl.dart';
  import 'package:provider/provider.dart';
  import '../provider/weather_provider.dart';

  class sevenDayForecast extends StatelessWidget {
    // dynamic weather;
    Widget dayWidget(dynamic weather, BuildContext context) {
      final dayOfWeek = DateFormat('').format(weather.date);
      return Container(
          margin: EdgeInsets.symmetric(horizontal: 7),
          child: Column(
            children: [
              FittedBox(
                  child: Text(dayOfWeek,
                      style: TextStyle(
                        color: ColorConstants.fontColor,
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                      ))),
              Padding(
                padding: const EdgeInsets.fromLTRB(5, 5, 5, 20),
                child: MapString.mapStringToIcon(
                    context, '${weather.condition}', 35),
              ),
              Text('${weather.condition}',
                  style: TextStyle(color: ColorConstants.fontColor)),
            ],
          ));
    }

    // const sevenDayForecast({super.key});

    @override
    Widget build(BuildContext context) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
              padding: EdgeInsets.only(top: 15, left: 20),
              child: Text('Next 7 days',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      color: ColorConstants.fontColor))),
          Container(
              margin: EdgeInsets.all(15),
              child: Material(
                  elevation: 5,
                  borderRadius: BorderRadius.circular(15),
                  color: ColorConstants.primaryColor,
                  child: ListView(
                    padding: EdgeInsets.all(25),
                    shrinkWrap: true,
                    children: [
                      Consumer<WeatherProvider>(
                          builder: (context, weatherProv, _) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Today',
                                      style: TextStyle(
                                        color: ColorConstants.fontColor,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                      )),
                                  Text(
                                      '${weatherProv.weather.temp.toStringAsFixed(1)}°C',
                                      style: TextStyle(
                                          fontSize: 30,
                                          color: ColorConstants.fontColor,
                                          fontWeight: FontWeight.w400)),
                                  MapString.mapInputToWeather(
                                      context, '${weatherProv.weather.currently}')
                                ]),
                            Padding(
                              padding: EdgeInsets.only(bottom: 20),
                              child: MapString.mapStringToIcon(context,
                                  '${weatherProv.weather.currently}', 45),
                            )
                          ],
                        );
                      }),
                      SizedBox(height: 15),
                      Consumer<WeatherProvider>(
                          builder: (context, weatherProv, _) {
                        return SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: weatherProv.sevenDayWeather
                                .map((item) => dayWidget(item, context))
                                .toList(),
                          ),
                        );
                      })
                    ],
                  )))
        ],
      );
    }
  }
