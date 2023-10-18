import 'package:flutter/material.dart';
import 'package:weather_app/models/constants.dart';
import 'package:weather_app/models/city.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Constants myContants = Constants();

  //initiatilization
  int temperature = 0;
  int maxTemp = 0;
  String weatherSateName = 'Loading..';
  int humidity = 0;
  int windSpeed = 0;

  var currentDate = 'Loading..';
  String imageUrl = '';
  int woeid = 44418; // Địa chỉ mặc định của app
  String location = 'London'; //Thành phố mặc định

  //chọn thành phố và dữ liệu của thành phố
  var selectedCities = City.getSelectedCities();
  List<String> cities = ['London']; //Danh sách để chọn thành phố

  List consolidatedWeatherList =
      []; //Lưu trữ thông tin thời tiết của thành phố khi gọi api

  //Gọi api
  String searchWeatherList =
      'https://api.openweathermap.org/data/2.5/weather?q=lodon&appid=c6c8f0c895e485477d2629dea429ecf4';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
    );
  }
}
