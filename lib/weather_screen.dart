import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class WeatherScreen extends StatefulWidget {
  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  Map<String, dynamic> _weatherData = {};
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }

  Future<void> _fetchWeather() async {
    final response = await http.get(
      Uri.parse('http://api.weatherapi.com/v1/current.json?key=6e6fab020e654728be9235547243006&q=Santo%20Domingo'),
    );
    if (response.statusCode == 200) {
      setState(() {
        _weatherData = json.decode(response.body);
        _isLoading = false;
      });
    } else {
      throw Exception('Failed to load weather');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: _isLoading
          ? CircularProgressIndicator()
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Clima en Santo Domingo',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                Text(
                  'Clima de República Dominicana',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 16),
                if (_weatherData.isNotEmpty) ...[
                  Text(
                    '${_weatherData['current']['temp_c']}°C',
                    style: TextStyle(fontSize: 48),
                  ),
                  Text(
                    _weatherData['current']['condition']['text'],
                    style: TextStyle(fontSize: 24),
                  ),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Text('Humedad', style: TextStyle(fontSize: 18)),
                          Text('${_weatherData['current']['humidity']}%', style: TextStyle(fontSize: 18)),
                        ],
                      ),
                      SizedBox(width: 32),
                      Column(
                        children: [
                          Text('Viento', style: TextStyle(fontSize: 18)),
                          Text('${_weatherData['current']['wind_kph']} kph', style: TextStyle(fontSize: 18)),
                        ],
                      ),
                    ],
                  ),
                ],
              ],
            ),
    );
  }
}
