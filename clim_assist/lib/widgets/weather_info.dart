import 'package:clim_assist/constants.dart';
import 'package:clim_assist/widgets/sun_animation.dart';
import 'package:flutter/material.dart';
import '../provider/weather_provider.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class WeatherInfo extends StatelessWidget {
  const WeatherInfo({super.key});

  Widget _weatherInfoBuilder({
    required String header,
    required String body,
    required Widget svgPicture
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        svgPicture,
        const SizedBox(width: 16.0),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FittedBox(
              child: Text(
                header,
                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 15,color:ColorConstants.fontColor),
              ),
            ),
            FittedBox(
              child: Text(
                body,
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15,color:ColorConstants.fontColor),
              ),
            ),
          ],
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<WeatherProvider>(builder: (context, weatherProv, _) {
      DateTime now = DateTime.now();
      // DateTime sunriseTime = DateTime(now.year, now.month, now.day, 6, 30);
      // DateTime sunsetTime = DateTime(now.year, now.month, now.day, 18, 0);
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
        child: Material(
          elevation: 5,
          borderRadius: BorderRadius.circular(15),
          color: ColorConstants.primaryColor,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _weatherInfoBuilder(
                header: 'Sunrise',
                body: '${weatherProv.currentWeather.sunrise}',
                svgPicture: const SunAnimation(svgloc: 'assets/images/sunn.svg',)
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 5.0),
                height: 65.0,
                child: VerticalDivider(
                  color: ColorConstants.fontColor,
                  indent: 10.0,
                  endIndent: 10.0,
                ),
              ),
              _weatherInfoBuilder(
                header: 'Sunset',
                body: '${weatherProv.currentWeather.sunset}',
                svgPicture: const SunAnimation(svgloc: 'assets/images/moonn.svg',)
              ),
            ],
          ),
        ),
      );
    });
  }
}
