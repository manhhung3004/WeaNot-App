import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/Profile/button_editProfile.dart';
import 'package:weather_app/login/text_fill.dart';

class EditProfile extends StatefulWidget {
  // const EditProfile({super.key});
  final String Name;
  final String Phone;
  final String Email;
  final String Address;

  const EditProfile(
      {super.key,
      required this.Name,
      required this.Phone,
      required this.Address,
      required this.Email});
  @override
  State<EditProfile> createState() => _SignUpState();
}

class _SignUpState extends State<EditProfile> {
  String? userMail = FirebaseAuth.instance.currentUser?.email.toString();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    super.initState();
    _emailController.text = widget.Email;
    _nameController.text = widget.Name;
    _phoneController.text = widget.Phone;
    _addressController.text = widget.Address;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 50),
            Text(
              'Edit your profile',
              style: TextStyle(
                color: Colors.grey[700],
                fontSize: 20,
              ),
              textAlign: TextAlign.left,
            ),
            const SizedBox(height: 25),
            Text(
              'Create your profile to start',
              style: TextStyle(
                color: Colors.grey[700],
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 25),
            //Name
            MyTextField(
              controller: _nameController,
              hintText: 'Your name',
              obscureText: false,
              decoration: const InputDecoration(
                labelText: 'Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            // email textfield
            MyTextField(
              controller: _emailController,
              hintText: 'E-Mail',
              obscureText: false,
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            MyTextField(
              controller: _phoneController,
              hintText: 'Phone',
              obscureText: false,
              decoration: const InputDecoration(
                labelText: 'Phone',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            //address
            MyTextField(
              controller: _addressController,
              hintText: 'Address',
              obscureText: false,
              decoration: const InputDecoration(
                labelText: 'Address',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            const SizedBox(height: 10),
            button_editprofile(onTap: _editprofile),
            const SizedBox(height: 50),
          ],
        )),
      ),
    );
  }

  void _editprofile() async {
  // Lấy email của người dùng hiện tại
  String userMail = FirebaseAuth.instance.currentUser!.email.toString();

  // Tạo đối tượng Map chứa các giá trị cần cập nhật
  Map<String, dynamic> updatedData = {
    "name": _nameController.text,
    "phone": _phoneController.text,
    "address": _addressController.text,
  };
  // Gọi hàm để cập nhật dữ liệu lên Firestore
  try {
    await updateUserData(userMail, updatedData);
    // Thông báo cập nhật thành công
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Cập nhật thông tin thành công!"),
        backgroundColor: Colors.green,
      ),
    );
    Navigator.of(context).pop();
  } catch (error) {
    // Thông báo lỗi cập nhật nếu có
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Lỗi cập nhật thông tin: $error"),
        backgroundColor: Colors.red,
      ),
    );
  }
}

Future<void> updateUserData(
  String userMail, Map<String, dynamic> updatedData) async {
  try {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection("user")
        .where("username", isEqualTo: userMail)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      DocumentSnapshot randomDoc = querySnapshot.docs[0]; // Cập nhật tài liệu đầu tiên

      // Cập nhật các giá trị từ controllers
      updatedData["name"] = _nameController.text;
      updatedData["phone"] = _phoneController.text;
      updatedData["address"] = _addressController.text;

      await randomDoc.reference.update(updatedData);
     // print("Đã cập nhật dữ liệu thành công!");
    } else {
//print("Không tìm thấy tài liệu phù hợp để cập nhật.");
    }
  } catch (error) {
   // print("Lỗi cập nhật dữ liệu: $error");
  }
}
}
