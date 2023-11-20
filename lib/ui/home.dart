import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:weather_app/models/constants.dart';
import 'package:weather_app/models/city.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/ui/detail_page.dart';
import 'package:weather_app/ui/weather_item.dart';
import 'package:http/http.dart' as http;
import 'dart:core';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);
  @override
  State<Home> createState() => _HomeState();
}
class _HomeState extends State<Home> {
  Constants myContants = Constants();
  int selected = 0;
  int temperature = 0;
  int temperatureF= 0;
  int maxTemp = 0;
  int maxTempF = 0;
  String weatherStateName = 'Loading..';
  int humidity = 0;
  int windSpeed = 0;
  var currentDate = 'Loading..';
  String imageUrl = '';
  int id = 2643743;
  String location = 'London';
  String keyurl = 'f4caf17f2341a501329e41a567e34b7b';
  var selectedCities = City.getSelectedCities();
  List<String> cities = ['London'];
  List consolidataWeatherList = [];
  // get location into api
    void fetchLocation(String location) async {
    http.Response searchResult = await http.get(Uri.parse('https://api.openweathermap.org/data/2.5/weather?q=$location&appid=$keyurl'));
    var result = json.decode(searchResult.body);
    setState(() {
    id = result["id"];
    });
  }
  void fetchWeatherData() async {
    http.Response weatherResult = await http.get(Uri.parse('https://api.openweathermap.org/data/2.5/forecast?id=$id&appid=$keyurl'));
    var result = json.decode(weatherResult.body);
    var consolidatedWeather = result["list"];
    setState(() {
      //Lấy dữ liệu cụ thể của hôm nay
      for (int i = 0 ; i < 40; i ++){
        consolidatedWeather.add(consolidatedWeather[i]);
      }
      temperatureF = (consolidatedWeather[0]["main"]["temp"]).round();
      weatherStateName = (consolidatedWeather[0]["weather"][0]["main"]);
      humidity = (consolidatedWeather[0]["main"]["humidity"]).round() ;
      windSpeed = (consolidatedWeather[0]["wind"]["speed"]).round() ;
      maxTempF = (consolidatedWeather[0]["main"]['temp_max']).round() ;
      //Định dạng hiển thị ngày
      var myDate = DateTime.parse((consolidatedWeather[0]["dt_txt"]).toString());
      currentDate = DateFormat('EEEE, d MMMM').format(myDate);
      //Chuyển từ đội K sang độ C
      temperature =  temperatureF - 273 ;
      maxTemp =  maxTempF - 273;
      imageUrl = weatherStateName.replaceAll(' ', '').toLowerCase();
      consolidataWeatherList = consolidatedWeather.toSet().toList();
    });
  }
  @override
  void initState() {
    fetchLocation(cities[0]);
    fetchWeatherData();
    for (int i = 0; i < selectedCities.length; i++) {
      cities.add(selectedCities[i].city);
    }
    super.initState();
  }
  //Tạo linear grandient
  final Shader linearGradient =
      const LinearGradient(colors: <Color>[Color(0x0ffabcff), Color(0xff9AC6F3)])
          .createShader(const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: myContants.secondaryColor,
        centerTitle: true,
        automaticallyImplyLeading: false,
        titleSpacing: 0,
        // ignore: prefer_const_constructors
        title: Container (
          padding:  const EdgeInsets.symmetric(horizontal: 20),
          width: size.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                width: 40,
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset('assets/pin.png',width: 10,),
                  const SizedBox(width: 5,),
                  DropdownButton<String>(
                    value: location,
                    icon: const Icon(Icons.keyboard_arrow_down),
                    items: cities.map((String location) => DropdownMenuItem(value: location, child: Text(location))).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        location = newValue!;
                        fetchLocation(location);
                        fetchWeatherData();},
                        );
                      },
                    ),
                  ],
                ),
              ],
              ),
            )
          ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(location, style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 30.0
              ),),
            Text(currentDate, style:  const TextStyle(
              color: Colors.grey,
              fontSize: 17
            ),),
            const SizedBox(
              height: 50,
            ),
            Container(
              width: size.width,
              height: 200,
              decoration: BoxDecoration(
                color: myContants.primaryColor,
                borderRadius: BorderRadius.circular(15),
                boxShadow:[
                  BoxShadow(
                    color: myContants.primaryColor.withOpacity(.5),
                    offset: const Offset(0,25),
                    blurRadius: 10,
                    spreadRadius: -12,
                  )
                ]
              ),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Positioned(
                    top: -40,
                    left:  20,
                    child: imageUrl == '' ? const Text(''):Image.asset('assets/$imageUrl.png',width: 150,),
                  ),
                  Positioned(
                    bottom: 30,
                    left: 30,
                    child: Text(weatherStateName,style: const TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      ),)
                    ),
                    Positioned(
                      top: 20,
                      right: 20,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 4.0),
                            child: Text(temperature.toString(), style:  TextStyle(
                              fontSize:90,
                              fontWeight: FontWeight.bold,
                              foreground: Paint()..shader = linearGradient,
                            ),),),
                            Text('o', style:  TextStyle(
                              fontSize: 50,
                              fontWeight: FontWeight.bold,
                              foreground: Paint()..shader = linearGradient,
                            ),)
                        ],
                      )
                      ),
                ],
              ),
            ),
            const SizedBox( height: 20,),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  weatheritem(text: 'Wind Speed',value: windSpeed, unit: 'km/h', imageUrl: 'assets/windspeed.png',),
                  weatheritem(text: 'Humidity',value: humidity, unit: '', imageUrl: 'assets/humidity.png',),
                  weatheritem(text: 'Temp Max',value: maxTemp, unit: 'C', imageUrl: 'assets/max-temp.png',)
                ],
              ) ,
            ),
            const SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text('Today',style:  TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),),
                Text('Next 5 Days',style:  TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 24,
                  color: myContants.primaryColor
                ),)
              ],
            ),
            //Set forecast
            const SizedBox(height: 1,),
            Expanded(
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: consolidataWeatherList.length,
                itemBuilder: (BuildContext context, int index){
                  String today = DateTime.now().toString().substring(0,10);
                  var selectedDay = consolidataWeatherList[index]["dt_txt"];
                  var futurWeatherName = consolidataWeatherList[index]["weather"][0]["main"];
                  var weatherUrl = futurWeatherName.replaceAll('','').toLowerCase();
                  var parsedDate = DateTime.parse((consolidataWeatherList[index]["dt_txt"]).toString());
                // ignore: non_constant_identifier_names
                  var SlipStringDate = DateFormat('HH,EEEE').format(parsedDate).substring(0,6);
                return GestureDetector(
                  onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => DetailPage(consolidatedWeatherList: consolidataWeatherList, selectedId: index, location: location,)));
                        },
                  child: Container(
                    padding:  const EdgeInsets.symmetric(vertical: 1),
                    margin: const EdgeInsets.only(right: 20 , bottom: 10 , top: 10),
                    width: 80,
                    decoration: BoxDecoration(
                      color: selectedDay == today ? myContants.primaryColor : Colors.white,
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      boxShadow: [
                        BoxShadow(
                          offset: const Offset(0,1),
                          blurRadius: 5,
                          color: selectedDay == today ? myContants.primaryColor : Colors.black54.withOpacity(.2),
                        )
                      ]
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("${(consolidataWeatherList[index]["main"]["temp"]-273).round()}C", style: TextStyle(
                          fontSize: 17,
                          color:  selectedDay == today ? Colors.white : myContants.primaryColor,
                          fontWeight:  FontWeight.w500
                        ),),
                        // ignore: prefer_interpolation_to_compose_strings
                        Image.asset('${'assets/'+ weatherUrl}.png', width: 40,alignment: Alignment.bottomCenter),
                        Text(SlipStringDate,style: TextStyle(
                          fontSize: 17,
                          color: selectedDay == today ? Colors.white: myContants.primaryColor,
                          fontWeight: FontWeight.w500,
                        ),)
                      ],
                    ),
                  ),
                );
              }
            ))
          ],
        ),
      ),
    );
  }
}