import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  String _weatherData = '';
  bool _isLoading = false;
  final String apiKey = 'be278ac7971af44c5bb9adb744d60fd3';

  Future<Map<String, dynamic>> getWeatherData(
      String apiKey, double lat, double lon) async {
    try {
      final response = await http.get(Uri.parse(
          'https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=$apiKey'));

      if (response.statusCode == 200) {
        final weatherData = jsonDecode(response.body);
        return weatherData;
      } else {
        throw Exception('Failed to load weather data');
      }
    } catch (e) {
      throw Exception('Failed to load weather data');
    }
  }
  Future<void> _checkLocationPermission() async {
    final permissionStatus = await Geolocator.checkPermission();
    if (permissionStatus == LocationPermission.denied) {
      await Geolocator.requestPermission();
    }
  }
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 200,
      child:
      // FutureBuilder(
      //     future: _checkLocationPermission().then((_) => Geolocator.getCurrentPosition(
      //       desiredAccuracy: LocationAccuracy.high,
      //     )),
      //     builder: (BuildContext context, AsyncSnapshot<Position> snapshot) {
      //       if (snapshot.hasData) {
      //         Position position = snapshot.data!;
      //         double latitude = 10.8230989;
      //         double longitude = 106.6296638;
      //         print(latitude);
      //         print(longitude);
      //
      //         // Truyền giá trị latitude và longitude vào hàm getWeatherData
      //         return
    FutureBuilder<Map<String, dynamic>>(
                  future: getWeatherData(apiKey, 10.8230989, 106.6296638),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final weatherData = snapshot.data!;
                      final temperature = weatherData['main']['temp'];
                      final weatherDescription =
                          weatherData['weather'][0]['description'];
                      final windSpeed = weatherData['wind']['speed'];
                      final cloudiness = weatherData['clouds']['all'];

                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '${(temperature - 273.15).toStringAsFixed(1)}°C',
                            style: TextStyle(fontSize: 24),
                          ),
                          Text(
                            weatherDescription,
                            style: TextStyle(fontSize: 18),
                          ),
                          Text(
                            'Gió: $windSpeed m/s',
                            style: TextStyle(fontSize: 18),
                          ),
                          Text(
                            'Mây: $cloudiness%',
                            style: TextStyle(fontSize: 18),
                          ),
                        ],
                      );
                    } else if (snapshot.hasError) {
                      return Text('${snapshot.error}');
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  })
            // } else {
            //   return Center(
            //     child: CircularProgressIndicator(),
            //   );
            // }
          // }),
    );
  }
}