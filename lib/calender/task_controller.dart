import 'package:get/get.dart';
import 'package:weather_app/calender/db_helper.dart';
import 'package:weather_app/calender/task.dart';

class TaskController extends GetxController{
  @override
  void onReady(){
    super.onReady();
  }
  Future<int>addTask({Task? task}) async{
    return await DBHelper.insert(task);
  }
}