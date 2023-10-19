import 'package:flutter/material.dart';
import 'package:weather_app/models/constants.dart';
import 'package:weather_app/models/city.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

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

    //Lấy dữ liệu của 6 ngày tiếp theo
    setState(() {
      for (int i = 0; i < 7; i++) {
        result.add(result[i]);
      }

      //Lấy dữ liệu cụ thể của hôm nay
      temperature = (result['main']['temp']).round();
      weatherSateName = result['weather'][0]['main'];
      humidity = result['main']['humidity'].round();
      windSpeed = result['wind']['speed'].round();
      maxTemp = result['main']['temp_max'].round();

      //Định dạng hiển thị ngày
      var myDate = DateTime.parse((result['dt']).toString());
      currentDate = DateFormat('EEEE, d MMMM').format(myDate);

      //gán giá trị cho image url
      imageUrl = weatherSateName.replaceAll(' ', '').toLowerCase();

      //Xóa trùng lặp
      consolidatedWeatherList = result.toSet().toList();
    });
    print(result);
  }

  @override
  void initState() {
    fetchWeatherData(location);

    //Thêm các địa điểm
    for (int i = 0; i < selectedCities.length; i++) {
      cities.add(selectedCities[i].city);
    }

    super.initState();
  }

  //Tạo linear grandient
  final Shader linearGradient =
      const LinearGradient(colors: <Color>[Color(0xffABCFF), Color(0xff9AC6F3)])
          .createShader(const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));

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
