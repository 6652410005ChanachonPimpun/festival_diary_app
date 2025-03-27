import 'dart:io';

import 'package:dio/dio.dart';

class UserApi {
  //สร้างออบเจกต์ dio 
  final Dio dio = Dio();

  //สร้างเมธอดสําหรับดึงข้อมูล
  Future<bool> RegisterUser(User user, File userfile) async {
    try{

      final formdata = FormData.fromMap({
        'userFullname': user.userFullname,
        'userName': user.userName,
        'userPassword': user.userPassword,
        if(userfile != null) 'userImage': await MultipartFile.fromFile(userfile.path,
        filename: userfile.path.split('/').last),
        ContentType: DioMediaType('image', userfile.path.split('.').last),
    }),
  }};

  }catch(e){
    print('Exception');
    return false;
  }
