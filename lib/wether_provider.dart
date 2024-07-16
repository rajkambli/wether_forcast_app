import 'package:flutter/material.dart';
import 'package:wether/services.dart';
import 'models.dart';

class WeatherProvider with ChangeNotifier {
  final WeatherService weatherService;
  List<City> _cities = [];
  Map<String, Weather> _weatherData = {};
  bool _isLoading = true;

  WeatherProvider(this.weatherService);

  List<City> get cities => _cities;
  Map<String, Weather> get weatherData => _weatherData;
  bool get isLoading => _isLoading;

  Future<void> loadCities() async {
    _isLoading = true;
    notifyListeners();
    try {
      _cities = await weatherService.fetchCities();
      for (var city in _cities) {
        _weatherData[city.name] = await weatherService.fetchWeather(city.name, city.countryCode);
      }
    } catch (e) {
      // Handle error
    }
    _isLoading = false;
    notifyListeners();
  }
}
