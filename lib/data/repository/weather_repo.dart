import 'dart:convert';

import 'package:weather_app/data/models/weather_model.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/presentation/constants/app_string.dart';

class WeatherRepo {
  Future<WeatherModel> getWeather(String city) async {
   final result = await http.get(Uri.parse(weatherBaseUrl));
   if (result.statusCode != 200) {
     throw Exception();
   }
   final response = json.decode(result.body);
   return WeatherModel.fromJson(response);
 }

 Future<WeatherModel> fetchWeather(double latitude, double longitude) async {
    final response = await http.get(
      Uri.parse('$weatherBaseUrl?latitude=$latitude&longitude=$longitude&current=temperature_2m,wind_speed_10m&hourly=temperature_2m,relative_humidity_2m,wind_speed_10m'),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      return WeatherModel.fromJson(data);
    } else {
      throw Exception('Failed to load weather data');
    }
  }
}