
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/login/login.dart';
import 'package:weather_app/models/constants.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);
  @override
  State<Profile> createState() => _Profile();
}
class _Profile extends State<Profile> {
  Constants myContants = Constants();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 20,),
            CircleAvatar(
              backgroundColor: myContants.secondaryColor.withOpacity(0.2),
              radius: 70,
              backgroundImage:const AssetImage('assets/profile.png'),
            ),
            const SizedBox(height: 20,),
            itemProfile("Name", "Mạnh Hùng", CupertinoIcons.person),
            const SizedBox(height: 20,),
            itemProfile("Phone", "123456789", CupertinoIcons.phone),
            const SizedBox(height: 20,),
            itemProfile("Address", "Hồ Chí Minh", CupertinoIcons.location),
            const SizedBox(height: 20,),
            itemProfile("Email", "21522122@gm.uit.edu.vn", CupertinoIcons.mail),
            const SizedBox(height: 40,),
            ElevatedButton(
              onPressed: () {
                showDialog(context: context,
                  builder: (BuildContext context){
                      return CupertinoAlertDialog(
                        title: const Text('Do you want to exit the app?'),
                        content: const Text('Please confirm'),
                        actions: <Widget>[
                          TextButton(
                              onPressed: () {
                                Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const LoginPage()),(route) => false,);
                              },
                              child: const Text('Yes')),
                          TextButton(
                              onPressed: () {
                                _dismissDialog();
                              },
                              child: const Text('No'))
                        ],
                      );
                  }
                );
              },
              child: const Text('Log out'),
            ),
          ],
        ),
      ),
    );
  }

  itemProfile (String title, subtitle, IconData icondata){
    return
      Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 5),
              color: myContants.secondaryColor.withOpacity(.2),
              spreadRadius: 5,
              blurRadius: 10
            )
          ]
        ),
        child: ListTile (
          title: Text(title),
          subtitle: Text(subtitle),
          leading: Icon(icondata),
          trailing: const Icon(Icons.arrow_forward, color: Colors.grey),
          tileColor: Colors.white,
        ),
      );
  }
  _dismissDialog() {
    Navigator.pop(context);
  }
}
