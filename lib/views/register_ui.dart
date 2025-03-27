import 'dart:io';

import 'package:festival_diary_app/service/user_api.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class RegisterUi extends StatefulWidget {
  const RegisterUi({super.key});

  @override
  State<RegisterUi> createState() => _RegisterUiState();
}

class _RegisterUiState extends State<RegisterUi> {
  //ควบคุม textfiled
  TextEditingController userFullnameCtrl = TextEditingController();
  TextEditingController userNameCtrl = TextEditingController();
  TextEditingController userPasswordCtrl = TextEditingController();

  //สร้างตัวแปรควบคุมการเปิด ปิดตา
  bool invisible = true;

  //ตัวแปรเก็บรูปที่ถ่าย
  File? userFile;

  //
  Future<void> openCamera() async {
    final image = await ImagePicker().pickImage(source: ImageSource.camera);
    if (image != null) return;

    setState(() {
      userFile = File(image!.path);
    });
  }

  //เตือน snacbar
  showWanningSnacbar(String message) {
    SnackBar(
      content: Align(alignment: Alignment.center, child: Text(message)),
      backgroundColor: Colors.red,
      duration: Duration(seconds: 1),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        title: Text(
          'Festival Diary',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
              left: 40.0,
              right: 40.0,
            ),
            child: Center(
              child: Column(
                children: [
                  SizedBox(
                    height: 40.0,
                  ),
                  Text(
                    'ลงทะเบียน',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 40.0,
                  ),
                  InkWell(
                    onTap: () async {
                      await openCamera();
                    },
                    child: userFile == null
                        ? Icon(
                            Icons.person_add_alt,
                            size: 100,
                            color: Colors.cyan,
                          )
                        : Image.file(
                            userFile!,
                            width: 100,
                            height: 100,
                          ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'ชื่อ-นามสกุล',
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  TextField(
                    controller: userFullnameCtrl,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(
                        Icons.person,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'ชื่อผู้ใช้',
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  TextField(
                    controller: userNameCtrl,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(
                        Icons.person,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'รหัสผ่าน',
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  TextField(
                    controller: userPasswordCtrl,
                    obscureText: invisible,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(
                        Icons.lock,
                      ),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            invisible = !invisible;
                          });
                        },
                        icon: Icon(
                          invisible == true
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40.0,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      ///ส่งข้อมูลไปบันทึกที่ database ผ่าน api
                      //validate UI
                      if (userFullnameCtrl.text.trim().isEmpty) {
                        showWanningSnacbar('กรุณากรอกชื่อ-นามสกุล');
                      } else if (userNameCtrl.text.trim().isEmpty) {
                        showWanningSnacbar('กรุณากรอกชื่อผู้ใช้');
                      } else if (userPasswordCtrl.text.trim().isEmpty) {
                        showWanningSnacbar('กรุณากรอกรหัสผ่าน');
                      } else {
                        //ส่งข้อมูลไปบันทึกที่ database ผ่าน api
                        User user = User(
                          userFullname: userFullnameCtrl.text.trim(),
                          userName: userNameCtrl.text.trim(),
                          userPassword: userPasswordCtrl.text.trim(),
                        );
                        await UserApi()
                            .RegisterUser(user, userFile!)
                            .then((value) {});
                      }
                    },
                    child: Text(
                      'ลงทะเบียน',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.cyan,
                        fixedSize: Size(
                          MediaQuery.of(context).size.width,
                          50.0,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            5.0,
                          ),
                        )),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
