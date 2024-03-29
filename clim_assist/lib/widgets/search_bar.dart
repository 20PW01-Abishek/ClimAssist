import 'package:clim_assist/constants.dart';
import 'package:clim_assist/widgets/fetch_cities.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:provider/provider.dart';
import '../provider/weather_provider.dart';

class SearchBar extends StatefulWidget {

  @override
  SearchBarState createState() => SearchBarState();
}

class SearchBarState extends State<SearchBar> {
  final _textController = TextEditingController();
  bool _validate = false;
  String? userSelected;

  @override
  void dispose() {
    super.dispose();
    _textController.dispose();
  }

  bool isStarred = false;

  @override
  Widget build(BuildContext context) {
    return Consumer<WeatherProvider>(
      builder: (context, weatherProv, _) {
        return SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.symmetric(
              vertical: 25,
              horizontal: MediaQuery.of(context).size.width * .05,
            ),
            child: Material(
              elevation: 10,
              borderRadius: BorderRadius.circular(15),
              color: ColorConstants.primaryColor,
              child: Row(
                children: [
                  Expanded(
                    child: TypeAheadField<String>(
                      suggestionsBoxDecoration: SuggestionsBoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      suggestionsCallback: (value) {
                        return mySuggestions.getSuggestions(value);
                      },
                      itemBuilder: (context, String suggestion) {
                        final isFavorite = Provider.of<WeatherProvider>(context, listen: false).isFavorite(suggestion);
                        return Row(
                          children: [
                            IconButton(
                              icon: isFavorite
                                  ? const Icon(
                                      Icons.favorite,
                                      color: Colors.red,
                                    )
                                  : const Icon(
                                      Icons.favorite_border,
                                      color: Colors.grey,
                                    ),
                              onPressed: () {
                                setState(() {
                                  if (isFavorite) {
                                    Provider.of<WeatherProvider>(context, listen: false).removeFromFavorites(suggestion);
                                  } else {
                                    Provider.of<WeatherProvider>(context, listen: false).addToFavorites(suggestion);
                                  }
                                });
                              },
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            const Icon(
                              Icons.refresh,
                              color: Colors.grey,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Flexible(
                              child: Padding(
                                padding: const EdgeInsets.all(6.0),
                                child: Text(
                                  suggestion,
                                  maxLines: 1,
                                  // style: TextStyle(color: Colors.red),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            )
                          ],
                        );
                      },
                      onSuggestionSelected: (String suggestion) {
                        userSelected = suggestion;
                        Provider.of<WeatherProvider>(context, listen: false).searchWeather(location: suggestion);
                      },
                      textFieldConfiguration: TextFieldConfiguration(
                        enabled: !weatherProv.isLoading,
                        style: TextStyle(color: ColorConstants.fontColor),
                        maxLines: 1,
                        controller: _textController,
                        decoration: InputDecoration(
                          hintStyle: const TextStyle(color: Colors.grey),
                          errorText: _validate ? null : null,
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          icon: Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Icon(
                              Icons.search,
                              color: ColorConstants.secondaryColor,
                            ),
                          ),
                          contentPadding: const EdgeInsets.only(
                            left: 0,
                            bottom: 11,
                            top: 11,
                            right: 15,
                          ),
                          hintText: "Search Location",
                        ),
                        onSubmitted: (value) {
                          _textController.text.isEmpty
                              ? _validate = true
                              : Provider.of<WeatherProvider>(context, listen: false).searchWeather(location: value);
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
