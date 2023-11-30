import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:weather_app/models/constants.dart';
class Calender extends StatefulWidget {
  const Calender ({super.key});
  @override
  State<Calender> createState() => _CalenderState();
}

class _CalenderState extends State<Calender> {
  @override
  void initState(){
    super.initState();
  }
  DateTime today = DateTime.now();
  void _onDaySelected(DateTime day, DateTime focusedDay){
    setState(() {
      today = day;
    });
  }
  @override
  Widget build(BuildContext context) {
    Constants myContants = Constants();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: myContants.primaryColor,
        title: const Text("Calender"),
        ),
      body: content(),
    );
  }
  Widget content(){
    return Padding(
      padding: const EdgeInsets.all(0),
      child: Column(
        children: [
          const SizedBox(height: 10,),
          Text("Today ${DateFormat('dd/MM/yyyy').format(today)}"),
          Container(
            padding:const EdgeInsets.only(bottom: 10),
            child: TableCalendar(
              locale: "en_US",
              rowHeight: 43,
              headerStyle: const HeaderStyle(formatButtonVisible: false,titleCentered: true),
              availableGestures: AvailableGestures.all ,
              selectedDayPredicate: (day)=>isSameDay(day,today),
              focusedDay: today,
              firstDay: DateTime.utc(2010, 10, 16),
              lastDay: DateTime.utc(2030, 3, 14),
              onDaySelected: _onDaySelected,
            ),
          ),
          // Tast list
          Container(
            padding:const EdgeInsets.only(left: 30),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height*0.419,
            decoration:const BoxDecoration(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(50), topRight:  Radius.circular(50)),
              color: Color(0xff30384C),
            ),
            child: Stack(
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Padding( padding: EdgeInsets.only(top: 50),
                    child:  Text("Today" , style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold
                    ),),),
                    Container(
                      padding:const EdgeInsets.only(top: 20),
                      child: Row(
                        children: [
                          const Icon(
                            CupertinoIcons.check_mark_circled_solid,
                            color: Color(0xff00cf8d),
                            size: 30,
                          ),
                          Container(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            width: MediaQuery.of(context).size.width*0.8,
                            child:  Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                const Text("Title", style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white
                                ),),
                                const SizedBox(height: 10,),
                                Text("Description", style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.white.withOpacity(0.6)
                                ),),
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
