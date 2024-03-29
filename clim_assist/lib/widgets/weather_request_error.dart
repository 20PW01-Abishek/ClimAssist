import 'package:clim_assist/constants.dart';
import 'package:flutter/material.dart';
import 'package:clim_assist/provider/weather_provider.dart';
import 'package:provider/provider.dart';

class RequestError extends StatelessWidget {
  // const RequestError({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 150),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.wrong_location_outlined,
            color: ColorConstants.secondaryColor,
            size: 100,
          ),
          const SizedBox(height: 10),
          Text(
            'No Search Result',
            style: TextStyle(
              color: ColorConstants.secondaryColor,
              fontSize: 30,
              fontWeight: FontWeight.w700,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 75, vertical: 10),
            child: Text(
              "Please make sure that you entered the correct location or check your device internet connection",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey[700],
                fontSize: 15,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.0),
              ),
            ),
            child: const Text('Return Home'),
            onPressed: () =>
                Provider.of<WeatherProvider>(context, listen: false)
                    .getWeatherData(isRefresh: true),
          ),
        ],
      ),
    );
  }
}
