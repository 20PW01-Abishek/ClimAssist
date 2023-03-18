import 'package:clim_assist/provider/weather_provider.dart';
import 'package:clim_assist/widgets/sun_animation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../utils/utils.dart';
import '../constants.dart';

class MainWeather extends StatelessWidget {
  final TextStyle _style1 = TextStyle(
    color: ColorConstants.fontColor,
    fontWeight: FontWeight.w500,
    fontSize: 20,
  );
  final TextStyle _style2 = TextStyle(
    color: ColorConstants.fontColor,
    fontWeight: FontWeight.w400,
    // color: Colors.grey[700],
    fontSize: 16,
  );

  MainWeather({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<WeatherProvider>(builder: (context, weatherProv, _) {
      return Container(
        padding: const EdgeInsets.fromLTRB(25, 15, 25, 5),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.location_on_outlined,
                  color: ColorConstants.secondaryColor,
                  size: 35,
                ),
                Text(weatherProv.weather.cityName, style: _style1),
              ],
            ),
            const SizedBox(height: 5.0),
            Text(
              DateFormat.yMMMEd().add_jm().format(DateTime.now()),
              style: _style2,
            ),
            const SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MapString.mapStringToIcon(
                  context,
                  weatherProv.weather.currently,
                  55,
                ),
                const SizedBox(width: 16.0),
                Text(
                  '${weatherProv.weather.temp.toStringAsFixed(0)}°C',
                  style: TextStyle(
                    fontSize: 55,
                    fontWeight: FontWeight.w600,
                    color: ColorConstants.fontColor,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10.0),
            Text(
              '${weatherProv.weather.tempMax.toStringAsFixed(0)}°/ ${weatherProv.weather.tempMin.toStringAsFixed(0)}° Feels like ${weatherProv.weather.feelsLike.toStringAsFixed(0)}°',
              style: _style1.copyWith(fontSize: 19),
            ),
            const SizedBox(height: 5.0),
            Text(
              toBeginningOfSentenceCase(weatherProv.weather.description) ?? '',
              style: _style1.copyWith(fontSize: 19),
            ),
          ],
        ),
      );
    });
  }
}
