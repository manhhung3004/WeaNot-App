
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_app/CollecData/model_Data.dart';

class Repository extends GetxController {
  static Repository get instance => Get.find();

  final _db = FirebaseFirestore.instance;
  createUser (Usermodel user) async{
    await _db.collection("users").add(user.toJon()).whenComplete(() => Get.snackbar("Success", "You account has been created",
    snackPosition: SnackPosition.BOTTOM,
    backgroundColor: Colors.green.withOpacity(0.1),
    colorText: Colors.green),
    ).catchError((error,StackTrace) {
      Get.snackbar("Error", "Something went wrong. Try again",
      snackPosition: SnackPosition.BOTTOM,
    backgroundColor: Colors.red.withOpacity(0.1),
    colorText: Colors.red,
    );
    });
  }
}