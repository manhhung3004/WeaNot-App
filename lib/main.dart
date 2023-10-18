import 'package:flutter/material.dart';
import 'package:weather_app/models/constants.dart';
import 'package:weather_app/ui/welcome.dart';

void main() => runApp( const MyApp());

class MyApp extends StatelessWidget{
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp( //use MaterialApp() widget like this
      home: Home(), //create new widget class for this 'home' to 
                   // escape 'No MediaQuery widget found' error
      debugShowCheckedModeBanner: false,
    );
  }
}


class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context){ 
    Constants myconstants = Constants();
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container (
        width: size.width,
        height: size.height,
        color: myconstants.primaryColor.withOpacity(.5),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,

            children: [
              Image.asset('assets/get-started.png'),
              const SizedBox(height: 30,),
              GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const Welcome()));
                },
                
                child: Container(
                  height: 58,
                  width: size.width * 0.7,
                  decoration: BoxDecoration(
                    color: myconstants.primaryColor,
                    borderRadius: const BorderRadius.all(Radius.circular(18)),
                  ),
                  child: const Center(
                    child: Text('Get Started', style: TextStyle(color: Colors.white , fontSize: 18) )
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

