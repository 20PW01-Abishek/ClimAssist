import 'package:clim_assist/constants.dart';
import 'package:clim_assist/provider/weather_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

class WeatherDetail extends StatelessWidget {
  const WeatherDetail({super.key});

  Widget _gridWeatherBuilder(String header, String body, IconData icon) {
    return Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(15),
      color: ColorConstants.primaryColor,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(
              icon,
              color: ColorConstants.secondaryColor,
              size: 35,
            ),
            const SizedBox(width: 15.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FittedBox(
                  child: Text(
                    header,
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: ColorConstants.fontColor,
                      fontSize: 18,
                    ),
                  ),
                ),
                FittedBox(
                  child: Text(
                    body,
                    style: TextStyle(fontWeight: FontWeight.w400, fontSize: 15, color: ColorConstants.fontColor),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<WeatherProvider>(builder: (context, weatherProv, _) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Text(
              'Today Details',
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: ColorConstants.fontColor),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height / 3,
            width: MediaQuery.of(context).size.width,
            child: GridView(
              padding: const EdgeInsets.all(15),
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 250,
                childAspectRatio: 2 / 1,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              children: [
                _gridWeatherBuilder(
                  '${weatherProv.weather.humidity}%',
                  'Humidity',
                  MdiIcons.waterPercent,
                ),
                _gridWeatherBuilder(
                  '${weatherProv.weather.windSpeed} km/h',
                  'Wind',
                  MdiIcons.weatherWindy,
                ),
                _gridWeatherBuilder(
                  '${weatherProv.weather.feelsLike.toStringAsFixed(1)}°C',
                  'Feels Like',
                  MdiIcons.temperatureCelsius,
                ),
                _gridWeatherBuilder(
                  '${weatherProv.weather.pressure} hPa',
                  'Pressure',
                  MdiIcons.arrowDownCircle,
                ),
                _gridWeatherBuilder(
                  DateFormat('hh:mm a').format(DateTime.fromMillisecondsSinceEpoch(weatherProv.weather.sunRise * 1000)).toString(),
                  'Sunrise',
                  MdiIcons.weatherSunsetUp,
                ),
                _gridWeatherBuilder(
                  DateFormat('hh:mm a').format(DateTime.fromMillisecondsSinceEpoch(weatherProv.weather.sunSet * 1000)).toString(),
                  'Sunset',
                  MdiIcons.weatherSunsetDown,
                ),
              ],
            ),
          ),
        ],
      );
    });
  }
}
