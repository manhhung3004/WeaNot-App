import 'package:flutter/material.dart';
import 'package:weather_app/Profile/profile.dart';
import 'package:weather_app/calender/calender.dart';
import 'package:weather_app/Note/notepage.dart';
import 'package:weather_app/models/constants.dart';
import 'package:weather_app/ui/welcome.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);
  @override
  State<Dashboard> createState() => _Dashboard();
}
class _Dashboard extends State<Dashboard> {
  Constants myContants = Constants();
  // ignore: prefer_typing_uninitialized_variables
  var height, width ;
  List imgData = [
    "assets/weather-app.png",
    "assets/take-note.png",
    "assets/schedule.png",
  ];

  List titles = [
    "Weather",
    "Note",
    "Schedule",
  ];
  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width= MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: myContants.primaryColor,
          width: width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: myContants.secondaryColor,
                ),
                height: height * 0.25,
                width: width,
                margin:const EdgeInsets.all(15),
                child: Column(
                  children: [
                    Padding(
                      padding : const EdgeInsets.only( top: 40, left: 15, right: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) =>  const Profile()));
                            },
                          child: Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: Colors.white,
                              image: const DecorationImage(image: AssetImage("assets/profile.png")),
                            ),
                          )),
                        ],
                      ),
                    ),
                    const Padding(
                      padding : EdgeInsets.only( top: 20, left: 15, right: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Dashboard",
                            style: TextStyle(
                              fontSize: 30,color: Colors.white,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 1,
                            ),
                          ),
                          SizedBox( height: 10,),
                          Text(
                            "Last Update: .../.../...",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white54,
                              letterSpacing: 1,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              SingleChildScrollView(
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    )
                  ),
                  height: height * 0.8,
                  width: width,
                  padding: const EdgeInsets.only(bottom: 20),
                  child: GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 1.1,
                      mainAxisSpacing: 25,
                      ),
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: imgData.length,
                    itemBuilder: (context,index){
                      return InkWell(
                        onTap: () {
                          switch(titles[index]){
                            case "Note": Navigator.push(context, MaterialPageRoute(builder: (context) =>  const NotePage()));
                            case "Weather": Navigator.push(context, MaterialPageRoute(builder: (context) =>  const Welcome()));
                            case "Schedule": Navigator.push(context, MaterialPageRoute(builder: (context) =>  const Calender()));
                          }
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 20,),
                          decoration: BoxDecoration(
                            color: myContants.secondaryColor,
                            boxShadow: const[
                              BoxShadow(
                                color:  Colors.black26,
                                spreadRadius: 1,
                                blurRadius: 6,
                              )
                            ]
                          ),
                          child : Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Image.asset(imgData[index], width: 100,),
                              Text(titles[index],
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white
                              ),)
                            ],
                          )
                        ),
                      );
                    },
                  )
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
  void tranferPage(){
    Navigator.push(context, MaterialPageRoute(builder: (context) =>  const Profile()));
  }
}