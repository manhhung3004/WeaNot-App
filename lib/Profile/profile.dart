import 'dart:math';
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
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String? userMail = FirebaseAuth.instance.currentUser?.email.toString();
  Constants myContants = Constants();
  String name = "";
  String phone = "";
  String email = "";
  String address = "";
  String image = "";
  @override
  void initState() {
    Get_Random_User_With_Matching_Email(userMail!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: myContants.primaryColor,
        title: const Text("Your Profile"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Expanded(
              child: FutureBuilder<QuerySnapshot>(
                future: FirebaseFirestore.instance
                    .collection("user")
                    .where("username", isEqualTo: userMail)
                    .get(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
                    int randomIndex =
                        Random().nextInt(snapshot.data!.docs.length);
                    DocumentSnapshot randomDoc =
                        snapshot.data!.docs[randomIndex];
                    Object? userData = randomDoc.data();
                    if (userData != null) {
                      Map<String, dynamic> userDataMap =
                          userData as Map<String, dynamic>;
                      String name = userDataMap["name"];
                      String phone = userDataMap["phone"];
                      String email = userDataMap["username"];
                      String address = userDataMap["address"];
                      //  String image = userDataMap["image"];
                      String image = "";
                      if (userDataMap["image"] == null) {
                        image = 'assets/profile.png';
                      } else {
                        image = userDataMap["image"];
                      }
                      return Column(
                        children: [
                          image == "assets/profile.png"
                              ? CircleAvatar(
                                  backgroundColor: myContants.secondaryColor
                                      .withOpacity(0.2),
                                  radius: 70,
                                  backgroundImage:
                                      const AssetImage('assets/profile.png'),
                                )
                              : CircleAvatar(
                                  backgroundColor: myContants.secondaryColor
                                      .withOpacity(0.2),
                                  radius: 70,
                                  backgroundImage: NetworkImage(image),
                                ),
                          const SizedBox(
                            height: 30,
                          ),
                          itemProfile(
                              "Name", name, CupertinoIcons.person, image),
                          const SizedBox(
                            height: 20,
                          ),
                          itemProfile(
                              "Phone", phone, CupertinoIcons.phone, image),
                          const SizedBox(
                            height: 20,
                          ),
                          itemProfile("Address", address,
                              CupertinoIcons.location, image),
                          const SizedBox(
                            height: 20,
                          ),
                          itemProfile(
                              "Email", email, CupertinoIcons.mail, image),
                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      );
                    } else {
                      return const Text("Dữ liệu người dùng không tồn tại.");
                    }
                  } else {
                    return const Text("Không tìm thấy tài liệu phù hợp.");
                  }
                },
              ),
            ),
            ElevatedButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return CupertinoAlertDialog(
                        title: const Text('Do you want to exit the app?'),
                        content: const Text('Please confirm'),
                        actions: <Widget>[
                          TextButton(
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (context) => const LoginPage()),
                                );
                              },
                              child: const Text('Yes')),
                          TextButton(
                              onPressed: () {
                                _dismissDialog();
                              },
                              child: const Text('No'))
                        ],
                      );
                    });
              },
              child: const Text('Log out'),
            ),
          ],
        ),
      ),
    );
  }

  itemProfile(String title, subtitle, IconData icondata, String image) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                offset: const Offset(0, 5),
                color: myContants.secondaryColor.withOpacity(.2),
                spreadRadius: 5,
                blurRadius: 10)
          ]),
      child: ListTile(
        title: Text(title),
        subtitle: Text(subtitle),
        leading: Icon(icondata),
        trailing: GestureDetector(
          onTap: () {
            if (image == "assets/profile.png") {
              image = "";
            }
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => EditProfile(
                  Name: name,
                  Email: email,
                  Phone: phone,
                  Address: address,
                  ImageGet: image,
                ),
              ),
              (route) => true,
            );
          },
          child: const Icon(Icons.arrow_forward, color: Colors.grey),
        ),
        tileColor: Colors.white,
      ),
    );
  }

  _dismissDialog() {
    Navigator.pop(context);
  }

  // ignore: non_constant_identifier_names
  void Get_Random_User_With_Matching_Email(String userMail) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection("user")
        .where("username", isEqualTo: userMail)
        .get();
    if (querySnapshot.docs.isNotEmpty) {
      int randomIndex = Random().nextInt(querySnapshot.docs.length);
      DocumentSnapshot randomDoc = querySnapshot.docs[randomIndex];
      // print(randomDoc.data());
      Object? userData = randomDoc.data();
      if (userData != null) {
        // Ép kiểu thành Map<String, dynamic>
        Map<String, dynamic> userDataMap = userData as Map<String, dynamic>;
        name = userDataMap["name"];
        phone = userDataMap["phone"];
        email = userDataMap["username"];
        address = userDataMap["address"];
        // image = userDataMap["image"];
        if (userDataMap["image"] == null) {
          image = "";
        } else {
          image = userDataMap["image"];
        }
      } else {
        // print("Dữ liệu người dùng không tồn tại.");
      }
    } else {
      //  print("Không tìm thấy tài liệu phù hợp.");
    }
  }
}
