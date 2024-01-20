/*
 * @Author: cjw 1294511002@qq.com
 * @Date: 2024-01-13 21:50:09
 * @LastEditors: cjw 1294511002@qq.com
 * @LastEditTime: 2024-01-20 21:19:12
 * @FilePath: \my_bili_app\lib\main.dart
 * @Description: 这是默认设置,请设置`customMade`, 打开koroFileHeader查看配置 进行设置: https://github.com/OBKoro1/koro1FileHeader/wiki/%E9%85%8D%E7%BD%AE
 */
import  'dart:convert';

import 'package:flutter/material.dart';
import 'package:my_bili_app/http/core/hi_cache.dart';
import 'package:my_bili_app/http/core/hi_error.dart';
import 'package:my_bili_app/http/core/hi_net.dart';
import 'package:my_bili_app/http/dao/login_dao.dart';
import 'package:my_bili_app/http/request/test_request.dart';
import 'package:my_bili_app/page/login_page.dart';
import 'package:my_bili_app/page/registration_page.dart';
import 'package:my_bili_app/util/color.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    HiCache.prefsInit();
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: white,
      ),
      home: Builder(builder: (context){
        return RegistrationPage(onJumpToLogin: (){
        onJumpToLogin(context);
      });
      },)
      // home: LoginPage(onJumpToRegistry: (){
      //     onJumpToRegistry(context);

      //   },)
    );
  }

  void onJumpToRegistry(context) {
    print('welcome to registry');
    Navigator.push(context, 
    MaterialPageRoute(builder:(context) => RegistrationPage(onJumpToLogin: () {
      onJumpToLogin(context);
    }),)
    );
  }

  void onJumpToLogin(context) {
    print('onJumpToLogin');
     Navigator.push(context, 
    MaterialPageRoute(builder:(context) => LoginPage(onJumpToRegistry: () {
      onJumpToRegistry(context);
    }),)
    );
  }
}
