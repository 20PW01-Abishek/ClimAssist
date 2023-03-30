import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/weather_provider.dart';
import '../constants.dart';

class FavoritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorites'),
        backgroundColor: ColorConstants.primaryColor,
      ),
      body: Consumer<WeatherProvider>(
        builder: (context, weatherProv, _) {
          // Get the list of favorite locations
          final favoriteLocations = weatherProv.favoriteLocations;

          // Check if there are any favorite locations
          if (favoriteLocations.isEmpty) {
            // Display a message if there are no favorite locations
            return Center(
              child: Text(
                'You have no favorite locations',
                style: TextStyle(
                  color: ColorConstants.fontColor,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            );
          } else {
            // Display the list of favorite locations
            return ListView.builder(
              itemCount: favoriteLocations.length,
              itemBuilder: (context, index) {
                // Get the current location
                final location = favoriteLocations[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 5,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: ListTile(
                      title: Text(
                        location,
                        style: TextStyle(
                          color: ColorConstants.fontColor,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      trailing: IconButton(
                        icon: Icon(
                          Icons.favorite,
                          color: ColorConstants.secondaryColor,
                        ),
                        onPressed: () {
                          weatherProv.toggleFavoriteLocation(location);
                        },
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context);
        },
        backgroundColor: ColorConstants.primaryColor,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
    );
  }
}
