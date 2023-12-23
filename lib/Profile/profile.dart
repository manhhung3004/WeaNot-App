
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/Profile/edit_profile.dart';
import 'package:weather_app/login/login.dart';
import 'package:weather_app/models/constants.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});
  @override
  State<Profile> createState() => _Profile();
}

class _Profile extends State<Profile> {
  String? userMail = FirebaseAuth.instance.currentUser?.email.toString();
  Constants myContants = Constants();
  @override
  Widget build(BuildContext context) {
    String name;
    String phone;
    String email;
    String address;
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
            ElevatedButton(
              onPressed: () {
                showDialog(context: context,
                  builder: (BuildContext context){
                      return CupertinoAlertDialog(
                        title: const Text('Do you want to edit your profile?'),
                        content: const Text('Please confirm'),
                        actions: <Widget>[
                          TextButton(
                              onPressed: () {
                                Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const EditProfile()),(route) => false,);
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
              child: const Text('Edit profile'),
            ),
            Get_Information_User(name,email,phone,address,userMail!),
            const SizedBox(height: 20,),
            itemProfile("Name", name, CupertinoIcons.person),
            const SizedBox(height: 20,),
            itemProfile("Phone", phone, CupertinoIcons.phone),
            const SizedBox(height: 20,),
            itemProfile("Address", address, CupertinoIcons.location),
            const SizedBox(height: 20,),
            itemProfile("Email", email, CupertinoIcons.mail),
            const SizedBox(height: 20,),
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


// ignore: non_constant_identifier_names
Get_Information_User(String name,String email,String phone,String address, String userMail){
  FirebaseFirestore.instance.collection("user").where("email", isEqualTo: userMail).get().then(
  (querySnapshot) {
    print("Successfully completed");
    for (var docSnapshot in querySnapshot.docs) {
      Map<String, dynamic> data = docSnapshot.data();
      name = data['name'];
      email = data['email'];
      phone = data['phone'];
      address = data['address'];
      // Lưu các giá trị khác vào các biến tương ứng
    }
    print("Retrive information of user");
  },
  onError: (e) => print("Error completing: $e"),
);
}