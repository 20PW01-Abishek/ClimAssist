import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import '../provider/weather_provider.dart';
import '../constants.dart';

class LocationError extends StatefulWidget {
  @override
  LocationErrorState createState() => LocationErrorState();
}

class LocationErrorState extends State<LocationError> {
  @override
  Widget build(BuildContext context) {
    Location location = Location();
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.location_off,
            color: ColorConstants.primaryColor,
            size: 75,
          ),
          const SizedBox(height: 10),
          Text(
            'Your Location is Disabled',
            style: TextStyle(
              color: ColorConstants.fontColor,
              fontSize: 25,
              fontWeight: FontWeight.w500,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 75, vertical: 10),
            child: Text(
              "Please turn on your location service and refresh the app",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: ColorConstants.fontColor,
                fontSize: 15,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).primaryColor,
              textStyle: const TextStyle(color: Colors.white),
              padding: const EdgeInsets.symmetric(horizontal: 50),
            ),
            child: const Text('Enable Location'),
            onPressed: () async {
              await location.requestService().then((value) async {
                if (value) {
                  await Provider.of<WeatherProvider>(context, listen: false).getWeatherData();
                } else {
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text('Cannot Get Your Location'),
                        content: SingleChildScrollView(
                          child: ListBody(
                            children: const <Widget>[
                              Text('This app uses your phone location to get your location accurate weather data'),
                            ],
                          ),
                        ),
                        actions: <Widget>[
                          ElevatedButton(
                            child: const Text('OK'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    },
                  );
                }
              });
            },
          ),
        ],
      ),
    );
  }
}
