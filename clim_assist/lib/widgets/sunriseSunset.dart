import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../constants.dart';

class sunriseSunset extends StatelessWidget {
  final DateTime sunrise;
  final DateTime sunset;

  sunriseSunset({required this.sunrise, required this.sunset});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
      decoration: BoxDecoration(
        color: ColorConstants.primaryColor,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Sunrise & Sunset',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              color: ColorConstants.fontColor,
            ),
          ),
          SizedBox(height: 16.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(
                Icons.wb_sunny,
                size: 36.0,
                color: Colors.yellow[700],
              ),
              SizedBox(width: 16.0),
              Text(
                '${_formatDateTime(sunrise)}',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.grey[800],
                ),
              ),
            ],
          ),
          SizedBox(height: 16.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(
                Icons.nightlight_round,
                size: 36.0,
                color: Colors.blueGrey[900],
              ),
              SizedBox(width: 16.0),
              Text(
                '${_formatDateTime(sunset)}',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.grey[800],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _formatDateTime(DateTime dateTime) {
    final timeFormat = DateFormat('h:mm a');
    return timeFormat.format(dateTime);
  }
}
