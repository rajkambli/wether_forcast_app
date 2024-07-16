import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wether/utility.dart';
import 'package:wether/wether_provider.dart';


class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
    Provider.of<WeatherProvider>(context, listen: false).loadCities();
  }


  @override
  Widget build(BuildContext context) {
    final weatherProvider = Provider.of<WeatherProvider>(context);

    return Scaffold(
      backgroundColor: Utility.getHexColor("302F34"),
      appBar: AppBar(
        backgroundColor: Utility.getHexColor("7C6C93"),
        title: const Text('Weather Forecast',style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold,color: Colors.white),),
      ),
      body: weatherProvider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.92,
            crossAxisSpacing: 6,
            mainAxisSpacing: 4,
          ),
          itemCount: weatherProvider.cities.length,
          itemBuilder: (context, index) {
            final city = weatherProvider.cities[index];
            final weather = weatherProvider.weatherData[city.name];
            final icon = weatherProvider.weatherData[city.name]?.icon ?? "";
            return Card(
              color: Colors.black12,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${city.name}, ${city.countryCode}',
                                style: Utility.headline1,
                              ),
                              if (weather != null) ...[
                                Text(
                                  '${weather.temperature.toStringAsFixed(1)}°C',
                                  style: Utility.headline1,
                                ),
                                Text(weather.description, style : Utility.headline2),
                              ]else const SizedBox.shrink()
                            ],
                          ),
                        ),
                        icon.isNotEmpty ? Image.network(
                          'http://openweathermap.org/img/wn/${icon}@2x.png',
                          width: 50,
                          height: 50,
                        ) : const SizedBox.shrink(),
                      ],
                    ),
                    const SizedBox(height: 5,),
                    if (weather != null) ...[
                      RowText(label:"Humidity",value: "${weather.humidity}%",
                      ),
                      const SizedBox(height: 2,),
                      RowText(label:"Wind",value: "${weather.windSpeed}%",),
                      const SizedBox(height: 2,),
                      RowText(label:"High",value: "${weather.maxTemperature.toStringAsFixed(1)}%",),
                      const SizedBox(height: 2,),
                      RowText(label:"Low",value: "${weather.minTemperature.toStringAsFixed(1)}%",)
                    ] else
                      const Center(child: Text('No data availabe',style: Utility.headline2,)),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}


class RowText extends StatelessWidget {
  final String label;
  final String value;
  const RowText({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label,
          style: Utility.labelText),
        Text(value,
          style: Utility.labelText),
      ],
    );
  }
}
