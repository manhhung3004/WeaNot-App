import 'package:flutter/material.dart';
import 'package:weather_app/models/constants.dart';
import 'package:weather_app/models/city.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Constants myContants = Constants();

  int temperature = 0;
  int maxTemp = 0;
  String weatherSateName = 'Loading..';
  int humidity = 0;
  int windSpeed = 0;

  var currentDate = 'Loading..';
  String imageUrl = '';
  int id = 2643743;
  String location = 'London';

  var selectedCities = City.getSelectedCities();
  List<String> cities = ['London'];

  List consolidatedWeatherList = [];

  String apiKey = 'c6c8f0c895e485477d2629dea429ecf4';
  String apiUrl =
      'https://api.openweathermap.org/data/2.5/weather?q=&appid=&units=';

  Future<void> fetchWeatherData(String location) async {
    var weatherUri = Uri.parse(apiUrl).replace(queryParameters: {
      'q': location,
      'appid': apiKey,
      'units': 'metric',
    });
    var weatherResult = await http.get(weatherUri);
    var result = json.decode(weatherResult.body);
  }

  @override
  void initState() {
    fetchWeatherData(location);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // ignore: prefer_const_constructors
        title: Text('Home Page'),
      ),
    );
  }
}
