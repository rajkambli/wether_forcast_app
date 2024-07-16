class City {
  final String name;
  final String countryCode;

  City({required this.name, required this.countryCode});

  factory City.fromJson(String cityStr) {
    final parts = cityStr.split(',');
    return City(
      name: parts[0],
      countryCode: parts[1],
    );
  }
}

class Weather {
  final String description;
  final double temperature;
  final double feelsLike;
  final double minTemperature;
  final double maxTemperature;
  final int pressure;
  final int humidity;
  final double windSpeed;
  final String country;
  final int sunrise;
  final int sunset;
  final String icon;

  Weather({
    required this.description,
    required this.temperature,
    required this.feelsLike,
    required this.minTemperature,
    required this.maxTemperature,
    required this.pressure,
    required this.humidity,
    required this.windSpeed,
    required this.country,
    required this.sunrise,
    required this.sunset,
    required this.icon,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    final weatherInfo = json['weather'][0];
    final mainInfo = json['main'];
    final windInfo = json['wind'];
    final sysInfo = json['sys'];
    return Weather(
      description: weatherInfo['description'],
      temperature: mainInfo['temp'] - 273.15,
      feelsLike: mainInfo['feels_like'] - 273.15,
      minTemperature: mainInfo['temp_min'] - 273.15,
      maxTemperature: mainInfo['temp_max'] - 273.15,
      pressure: mainInfo['pressure'],
      humidity: mainInfo['humidity'],
      windSpeed: windInfo['speed'],
      country: sysInfo['country'],
      sunrise: sysInfo['sunrise'],
      sunset: sysInfo['sunset'],
      icon: weatherInfo['icon'],
    );
  }
}