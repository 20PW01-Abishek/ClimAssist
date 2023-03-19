import 'package:clim_assist/constants.dart';
import 'package:clim_assist/widgets/sun_animation.dart';
import 'package:flutter/material.dart';
import '../provider/weather_provider.dart';
import 'package:provider/provider.dart';

class WeatherInfo extends StatelessWidget {
  const WeatherInfo({super.key});

  Widget _weatherInfoBuilder({required String header, required String body, required Widget svgPicture}) {
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
                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 15, color: ColorConstants.fontColor),
              ),
            ),
            FittedBox(
              child: Text(
                body,
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15, color: ColorConstants.fontColor),
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
      return Container();
    });
  }
}
