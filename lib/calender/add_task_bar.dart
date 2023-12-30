import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/calender/input_field.dart';
import 'package:weather_app/calender/task.dart';
import 'package:weather_app/calender/task_controller.dart';
import 'package:weather_app/models/constants.dart';

import 'Button.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({super.key});

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final TaskController _taskController = Get.put(TaskController());
  DateTime _selectedDate = DateTime.now();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  String _startTime = DateFormat("hh:mm a").format(DateTime.now()).toString();
  String _endTime = "9:30 PM";
  int _selectedRemind = 5;
  int _selectedColor = 0;
  String _selectedRepeat = "None";
  List<int> remindList = [5, 10, 15, 20, 25];
  List<String> repeatList = ["none", "Daily", "Weekly", "Monthly"];
  @override
  Widget build(BuildContext context) {
    Constants myContants = Constants();
    return Scaffold(

      backgroundColor: myContants.primaryColor,
      appBar: _appBar(context),
      body: Container(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
            "Add Task",
          style: GoogleFonts.lato(
            textStyle: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Get.isDarkMode? Colors.white : Colors.black
            ),
          )
          ),
             MyInputField(title: "Title", hint: "Enter your title", controller: _titleController,),
             MyInputField(title: "Note", hint: "Enter your note", controller: _noteController,),
            MyInputField(title: "Date", hint: DateFormat.yMd().format(_selectedDate),
            widget: IconButton(
              icon: Icon(Icons.calendar_today_outlined),
              color: Colors.grey,
              onPressed: () {
                _getDateFromUser();
              },

            ),
            ),
            Row(
              children: [
                Expanded(
                    child: MyInputField(
                      title: "Start Time",
                      hint: _startTime,
                      widget: IconButton(
                        onPressed: () async {
                          _getTimeFromUser(isStartTime: true);

                        },
                        icon: Icon(Icons.access_time_rounded),
                        color: Colors.grey,
                    )),
                    ),
                SizedBox(width: 12,),
                Expanded(
                  child: MyInputField(
                      title: "End Time",
                      hint: _endTime,
                      widget: IconButton(
                        onPressed: () async {
                          _getTimeFromUser(isStartTime: false);

                        },
                        icon: Icon(Icons.access_time_rounded),
                        color: Colors.grey,
                      )),
                ),
              ],
            ),
            MyInputField(
              title: "Remind",
              hint: "$_selectedRemind minutes early",
              widget: DropdownButton(
                icon: Icon(Icons.keyboard_arrow_down,
                  color: Colors.grey,
                ),

                iconSize: 30,
                elevation: 4,
                style: GoogleFonts.lato(
                  textStyle: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Get.isDarkMode? Colors.grey[100] : Colors.grey[700]
                  ),
                ),
                underline: Container(
                  height: 0,
                ),
                onChanged: (String? newValue){
                  setState(() {
                    _selectedRemind = int.parse(newValue!);
                  });
                },
                items: remindList.map<DropdownMenuItem<String>>((int value){
                  return DropdownMenuItem<String>(
                    value: value.toString(),
                    child: Text("$value minutes early"),
                  );
                }).toList(),
              ),
            ),
            MyInputField(
              title: "Repeat",
              hint: "$_selectedRepeat",
              widget: DropdownButton(
                icon: Icon(Icons.keyboard_arrow_down,
                  color: Colors.grey,
                ),

                iconSize: 30,
                elevation: 4,
                style: GoogleFonts.lato(
                  textStyle: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Get.isDarkMode? Colors.grey[100] : Colors.grey[700]
                  ),
                ),
                underline: Container(
                  height: 0,
                ),
                onChanged: (String? newValue){
                  setState(() {
                    _selectedRepeat = newValue!;
                  });
                },
                items: repeatList.map<DropdownMenuItem<String>>((String? value){
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value!, style:TextStyle(
                        color: Colors.grey)
                    ),
                  );
                }).toList(),
              ),
            ),
            SizedBox(height: 18,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _colorPallete(),
                MyButton(label: "Create Task", onTap: ()=>_validateDate())
              ],
            )
          ],
          ),
        ),
      ),
    );
  }
  _colorPallete(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Color",
          style: GoogleFonts.lato(
            textStyle: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Get.isDarkMode? Colors.grey[100] : Colors.grey[700]
            ),
          ),
        ),
        SizedBox(height: 8,),
        Wrap(
          children: List<Widget>.generate(3, (int index){
            return GestureDetector(
              onTap: (){
                setState(() {
                  _selectedColor = index;
                  print("$index");
                });

              },
              child:Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: CircleAvatar(
                    radius: 14,
                    backgroundColor: index == 0 ? Colors.blue : index == 1 ? Colors.red : Colors.green,
                    child: _selectedColor==index?Icon(Icons.done, color: Colors.white, size: 16
                    ):Container(),

                  )


              ),
            );

          }),
        )
      ],
    );
  }
  _validateDate(){
    if(_titleController.text.isNotEmpty && _noteController.text.isNotEmpty){
      _addTasktoDb();
      Get.back();
    }
    else if(_titleController.text.isEmpty || _noteController.text.isEmpty)
      Get.snackbar("Required", "All fields are required",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.white,
        colorText: Colors.black,
        icon: Icon(Icons.warning_amber_rounded, color: Colors.red,),
      );
  }
  _appBar(BuildContext context){
    Constants myContants = Constants();
    return AppBar(
      elevation: 0,
      backgroundColor: myContants.primaryColor,
      leading: GestureDetector(
        onTap:(){
            Get.back();
        },
        child: Icon(Icons.arrow_back_ios,
          size: 20,
          color: Get.isDarkMode ? Colors.white : Colors.black
      ),
    ),
    actions: const [
      CircleAvatar(
    backgroundImage: AssetImage(
      "assets/images/profile.png"
      ),
    ),
    SizedBox(width: 20,)
    ],
    );
  }
  _getDateFromUser() async {
    DateTime? _pickerDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1990),
        lastDate: DateTime(2100)
    );
    if (_pickerDate != null) {
      setState(() {
        _selectedDate = _pickerDate;
        print(_selectedDate);
      });
    }
  }
  _addTasktoDb()async{
    int value = await _taskController.addTask(
    task:Task(
      note: _noteController.text,
      title: _titleController.text,
      date: DateFormat.yMd().format(_selectedDate),
      startTime: _startTime,
      endTime: _endTime,
      remind: _selectedRemind,
      repeat: _selectedRepeat,
      color: _selectedColor,
      isComplete: 0,
    )
    );
    print("My id is " + "$value");
  }
  _getTimeFromUser({required bool isStartTime}){
    var pickedTime =  _showTimePicker();
    String _formatedTime = pickedTime.format(context);
    if(pickedTime == null){
        print("Time canceled");
      } else if(isStartTime ==true ){
      setState(() {
        _startTime= _formatedTime;
      });

    }
    else if(isStartTime ==false ){
      setState(() {
        _endTime= _formatedTime;
      });
    }
  }
  _showTimePicker(){
    return showTimePicker(
      initialEntryMode: TimePickerEntryMode.input,
      context: context,
      initialTime: TimeOfDay(
        hour: int.parse(_startTime.split(":")[0]),
        minute: int.parse(_startTime.split(":")[1].split(" ")[0]
        )
      )
    );
  }
}
