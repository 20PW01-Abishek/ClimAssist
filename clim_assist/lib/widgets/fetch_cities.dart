import 'package:flutter/services.dart' show rootBundle;
import 'package:csv/csv.dart';

class Cities {
  Future<List<String>> getCities() async {
  List<List<dynamic>> csvTable = [];
  String csvData = await rootBundle.loadString('assets/worldcities.csv');
  csvTable = const CsvToListConverter().convert(csvData);
  List<String> cities = [];
  for (List<dynamic> row in csvTable) {
    cities.add(row[0].toString());
  }
  return cities;
}


  Future<List<String>> getSuggestions(String query) async {
    List<String> matches = [];
    List<String> cities = await getCities();
    matches.addAll(cities);
    matches.retainWhere((s) => s.toLowerCase().contains(query.toLowerCase()));
    return matches;
  }
}

Cities mySuggestions = Cities();

// Call the getSuggestions method on the instance
Future<List<String>> suggestions = mySuggestions.getSuggestions("query");
