import 'dart:convert';
import 'package:http/http.dart' as http;

import 'models.dart';


class WeatherService {
  static const String apiKey = '2091953ce6ab36724ab3ff0c928fb2d0';

  Future<List<City>> fetchCities() async {
    final response = await http.get(Uri.parse('https://a944ede2-133d-45fa-82e1-0fb951492eda.mock.pstmn.io/cities'));
    if (response.statusCode == 200) {
      final List<dynamic> cityList = json.decode(response.body)['cities'];
      return cityList.map((city) => City.fromJson(city)).toList();
    } else {
      throw Exception('Failed to load cities');
    }
  }

  Future<Weather> fetchWeather(String city, String countryCode) async {
    final response = await http.get(Uri.parse('https://api.openweathermap.org/data/2.5/weather?q=$city,$countryCode&APPID=$apiKey'));
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return Weather.fromJson(json);
    } else {
      throw Exception('Failed to load weather');
    }
  }
}