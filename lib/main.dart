import 'package:flutter/material.dart';

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
    
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container (
        width: size.width,
        height: size.height,
        color: Colors.red,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,

            children: [
              Image.asset('assets/get-started.png'),
              const SizedBox(height: 30,),
              Container(
                height: 58,
                width: size.width * 0.7,
                decoration: const BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.all(Radius.circular(18)),
                ),
                child: const Center(
                  child: Text('Get Started', style: TextStyle(color: Colors.white , fontSize: 18) )
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

