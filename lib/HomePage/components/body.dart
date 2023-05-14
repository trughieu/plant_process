import 'dart:convert';

import 'package:flutter/material.dart';
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

  Future<void> _getWeatherData() async {
    setState(() {
      _isLoading = true;
    });

    final response = await http.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?q=Hanoi,vn&appid=$apiKey'));

    setState(() {
      _isLoading = false;
      if (response.statusCode == 200) {
        print(response.body);
        final weatherJson = json.decode(response.body);
        _weatherData =
            '${weatherJson['weather'][0]['main']}, ${weatherJson['weather'][0]['description']}';
      } else {
        print(response.statusCode);

        _weatherData = 'Error: ${response.statusCode}';
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _getWeatherData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
      height: 300,
      decoration: BoxDecoration(
        color: Color(0x30FFFFFF),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Center(
        child: _isLoading
            ? CircularProgressIndicator()
            : Text(
                _weatherData,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
      ),
    ));
  }
}
//
