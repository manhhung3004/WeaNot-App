import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:weather_app/models/constants.dart';
import 'package:weather_app/models/city.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/widgets/weather_item.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}
class _HomeState extends State<Home> {
  Constants myContants = Constants();

  int temperature = 0;
  int maxTemp = 0;
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
    id = result["id"]?? 0;
    });
  }
  void fetchWeatherData() async {
    http.Response weatherResult = await http.get(Uri.parse('https://api.openweathermap.org/data/2.5/forecast?id=$id&appid=$keyurl'));
    var result = json.decode(weatherResult.body);
    var consolidatedWeather = result["list"];

    setState(() {
    if (consolidatedWeather.isNotEmpty) {
      for (int i = 0; i < 4; i++) {
        consolidatedWeather.add(consolidatedWeather[int.parse("0")][i]); //this takes the consolidated weather for the next six days for the location searched
      }
    }
      //Lấy dữ liệu cụ thể của hôm nay
      temperature = (result["list"][int.parse("0")]["main"]["temp"]).round() ?? 0;
      weatherStateName = (result["list"][int.parse("0")]["weather"][int.parse("0")]["main"]) ?? 0;
      humidity = (result["list"][int.parse("0")]["main"]["humidity"]).round() ?? 0;
      windSpeed = (result["list"][int.parse("0")]["wind"]["speed"]).round() ?? 0;
      maxTemp = (result["list"][int.parse("0")]["main"]['temp_max']).round() ?? 0;
      //Định dạng hiển thị ngày
      var myDate = DateTime.parse((result["list"][int.parse("0")]["dt_txt"]).toString());
      currentDate = DateFormat('EEEE, d MMMM').format(myDate);
      //gán giá trị cho image url
      consolidataWeatherList = consolidatedWeather;
      imageUrl = weatherStateName.replaceAll(' ', '').toLowerCase();
      consolidatedWeather = Set.from(result.values).toList();
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
        backgroundColor: Colors.white,
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
              //Show out profile images
              ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(18)),
                child: Image.asset('assets/profile.png',width: 40,height: 40,),
              ),
              // Show out locatoion dropdown
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset('assets/pin.png',width: 20,),
                  const SizedBox(width: 4,),
                  DropdownButton(
                    value: location,
                    icon: const Icon(Icons.keyboard_arrow_down),
                    items: cities.map((String location) {
                        return DropdownMenuItem(
                          value:  location,
                          child: Text(location));
                    }).toList(), onChanged: (String? newValue) {
                      location = newValue!;
                      fetchLocation(location);
                      fetchWeatherData();
                      },
                      )
                    ],
                  )
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
              fontSize: 16.8
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
                    left: 20,
                    child: Text(weatherStateName,style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
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
                              fontSize: 80,
                              fontWeight: FontWeight.bold,
                              foreground: Paint()..shader = linearGradient,
                            ),),),
                            Text('o', style:  TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                              foreground: Paint()..shader = linearGradient,
                            ),)
                        ],
                      )
                      ),
                ],
              ),
            ),
            const SizedBox( height: 50,),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  weatheritem(text: 'Wind',value: windSpeed, unit: 'km/h', imageUrl: 'assets/windspeed.png',),
                  weatheritem(text: 'Humidity',value: humidity, unit: '', imageUrl: 'assets/humidity.png',),
                  weatheritem(text: 'Temp',value: maxTemp, unit: 'C', imageUrl: 'assets/max-temp.png',)
                ],
              ) ,
            ),
            const SizedBox(height: 50,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text('Today',style:  TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),),
                Text('Next 7 Days',style:  TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 24,
                  color: myContants.primaryColor
                ),)
              ],
            ),
            //Set forecast
            const SizedBox(height: 20,),
            Expanded(child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: consolidataWeatherList.length,
              itemBuilder: (BuildContext context, int index){
                String today = DateTime.now().toString().substring(0,10);
                var selectedDay = consolidataWeatherList[index]['applicable_data'];
                var futurWeatherName = consolidataWeatherList[index]['weather_state_name'];
                var parsedDate = DateTime.parse(consolidataWeatherList[index]['applicable_data']);
                var newDate = DateFormat('EEEE').format(parsedDate).substring(0,3);

                return GestureDetector(
                  child: Container(
                    padding:  const EdgeInsets.symmetric(vertical: 20),
                    margin: const EdgeInsets.only(right: 20 , bottom: 10 , top: 10),
                    width: 80,
                    height: 20,
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
                        Text("${consolidataWeatherList[index]['the_temo'].round()}C", style: TextStyle(
                          fontSize: 17,
                          color:  selectedDay == today ? Colors.white : myContants.primaryColor,
                          fontWeight:  FontWeight.w500
                        ),),
                        // ignore: prefer_interpolation_to_compose_strings
                        Image.asset('${'assets/'+ futurWeatherName}.png', width: 30,),
                        Text(newDate,style: TextStyle(
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
