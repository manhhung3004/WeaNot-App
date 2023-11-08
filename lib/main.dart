import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/login/login.dart';
import 'package:weather_app/models/constants.dart';
import 'package:weather_app/ui/welcome.dart';
import 'package:weather_app/ui/notepage.dart';
import 'package:weather_app/calender/calender.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      //use MaterialApp() widget like this
      home: Home(), //create new widget class for this 'home' to
      // escape 'No MediaQuery widget found' error
      debugShowCheckedModeBanner: false,
    );
  }
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    Constants myconstants = Constants();
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        width: size.width,
        height: size.height,
        color: myconstants.primaryColor.withOpacity(.5),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset('assets/get-started.png'),
              const SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Welcome()),
                  );
                },
                child: Container(
                  height: 58,
                  width: size.width * 0.7,
                  decoration: BoxDecoration(
                    color: myconstants.primaryColor,
                    borderRadius: const BorderRadius.all(Radius.circular(18)),
                  ),
                  child: const Center(
                    child: Text(
                      'Good Weather',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                ),
              ),
              // Write Notes
              const SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const NotePage()),
                  );
                },
                child: Container(
                  height: 58,
                  width: size.width * 0.7,
                  decoration: BoxDecoration(
                    color: myconstants.primaryColor,
                    borderRadius: const BorderRadius.all(Radius.circular(18)),
                  ),
                  child: const Center(
                    child: Text(
                      'Write Notes',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                ),
              ),

              // Calender
              const SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Calender()),
                  );
                },
                child: Container(
                  height: 58,
                  width: size.width * 0.7,
                  decoration: BoxDecoration(
                    color: myconstants.primaryColor,
                    borderRadius: const BorderRadius.all(Radius.circular(18)),
                  ),
                  child: const Center(
                    child: Text(
                      'Calender',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                ),
              ),

             // login
            const SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                  );
                },
                child: Container(
                  height: 58,
                  width: size.width * 0.7,
                  decoration: BoxDecoration(
                    color: myconstants.primaryColor,
                    borderRadius: const BorderRadius.all(Radius.circular(18)),
                  ),
                  child: const Center(
                    child: Text(
                      'login check',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
