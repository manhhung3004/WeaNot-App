// import 'package:flutter/material.dart';

// import 'package:provider/provider.dart';

// import 'package:weather_app/calender/meeting_provider.dart';
// import 'package:weather_app/firebase_auth/firebase_auth_service.dart';

// import 'package:weather_app/login/text_fill.dart';

// class AddMeeting extends StatefulWidget {
//   const AddMeeting({super.key});
//   @override
//   State<AddMeeting> createState() => _AddMeetingState();
// }

// class _AddMeetingState extends State<AddMeeting> {
//   DateTime selectedDate = DateTime.now();
//   final FirebaseAuthService _auth = FirebaseAuthService();
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//   final TextEditingController _nameController = TextEditingController();
//   Future<void> _selectDate(BuildContext context) async {
//     final DateTime? picked = await showDatePicker(
//         context: context,
//         initialDate: selectedDate,
//         firstDate: DateTime(2015, 8),
//         lastDate: DateTime(2101));
//     if (picked != null && picked != selectedDate) {
//       setState(() {
//         selectedDate = picked;
//       });
//     }
//   }

//   @override
//   void dispose() {
//     _emailController.dispose();
//     _passwordController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     bool? isChecked = false;
//     final provider = Provider.of<MeetingProvider>(context);
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       backgroundColor: Colors.white,
//       body: SingleChildScrollView(
//         child: Container(
//           padding: const EdgeInsets.only(left: 20, right: 20),
//           child: Column(
//             // mainAxisAlignment: MainAxisAlignment.start,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const SizedBox(height: 50),
//               Text(
//                 'Add Task',
//                 style: TextStyle(
//                   color: Colors.grey[700],
//                   fontSize: 20,
//                 ),
//               ),
//               const SizedBox(height: 25),
//               //Name
//               MyTextField(
//                 controller: _nameController,
//                 hintText: 'Your name',
//                 obscureText: false,
//                 decoration: const InputDecoration(
//                   labelText: 'Name',
//                   border: OutlineInputBorder(),
//                 ),
//               ),
//               const SizedBox(height: 10),
//               // email textfield
//               Row(
//                 children: [
//                   ElevatedButton(
//                     onPressed: () => _selectDate(context),
//                     child: const Text("testing"),
//                   ),
//                   const SizedBox(width: 10), // Add spacing between buttons
//                   ElevatedButton(
//                     onPressed: () =>
//                         _selectDate(context), // Replace with your desired action
//                     child: const Text('Do something else'),
//                   ),
//                 ],
//               ),
//           //     Checkbox(
//           //   value: isChecked,
//           //   onChanged: (value) {
//           //     setState(() {
//           //       isChecked = value;
//           //     });
//           //   },
//           // ),
//               const SizedBox(height: 10),
//               //address
//               ElevatedButton(
//                 style: ElevatedButton.styleFrom(
//                   padding: const EdgeInsets.all(15), // Ensure adequate padding
//                   shape: RoundedRectangleBorder(
//                     borderRadius:
//                         BorderRadius.circular(10), // Optional rounded corners
//                   ),
//                 ),
//                 onPressed: () {
//                   provider.addMeeting(context);
//                 },
//                 child: const Text(
//                   'Add events', // Replace with your desired text
//                   style: TextStyle(
//                     fontSize: 18, // Adjust font size as needed
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
