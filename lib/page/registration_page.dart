// ignore_for_file: prefer_const_constructors, unused_local_variable

/*
 * @Author: cjw 1294511002@qq.com
 * @Date: 2024-01-20 14:04:34
 * @LastEditors: cjw 1294511002@qq.com
 * @LastEditTime: 2024-01-20 21:41:41
 * @FilePath: \my_bili_app\lib\page\registration_page.dart
 * @Description: 这是默认设置,请设置`customMade`, 打开koroFileHeader查看配置 进行设置: https://github.com/OBKoro1/koro1FileHeader/wiki/%E9%85%8D%E7%BD%AE
 */

import 'package:flutter/material.dart';
import 'package:my_bili_app/http/core/hi_cache.dart';
import 'package:my_bili_app/http/core/hi_error.dart';
import 'package:my_bili_app/http/dao/login_dao.dart';
import 'package:my_bili_app/navigitor/hi_navigator.dart';
import 'package:my_bili_app/util/color.dart';
// import 'package:my_bili_app/util/toast.dart';
import 'package:my_bili_app/widget/appbar.dart';
import 'package:my_bili_app/widget/login_effect.dart';
import 'package:my_bili_app/widget/login_input.dart';
import 'package:my_bili_app/widget/message_tip.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({Key? key})
      : super(key: key);
  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  bool protect = false;
  bool registryEnable = false;
  late String userName;
  late String password;
  late String rePassword;
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar("注册", "登录", () {
        HiNavigator.getInstance().onJumpTo(RouteStatus.login);
      }),
      body: Container(
        child: ListView(
          children: [
            LoginEffect(
              protect: protect,
            ),
            LoginInput(
              "用户名",
              "请输入用户名",
              keboardType: TextInputType.text,
              lineStrech: false,
              onChanged: (value) {
                userName = value;
                checkInput();
              },
            ),
            LoginInput(
              "密码",
              "请输入密码",
              keboardType: TextInputType.text,
              lineStrech: false,
              obscureText: true,
              onChanged: (value) {
                password = value;
                checkInput();
              },
              focusChanged: (hasFocus) {
                setState(() {
                  protect = hasFocus;
                });
              },
            ),
            LoginInput(
              "确认密码",
              "请输入密码",
              keboardType: TextInputType.text,
              lineStrech: true,
              obscureText: true,
              onChanged: (value) {
                rePassword = value;
                checkInput();
              },
              focusChanged: (hasFocus) {
                setState(() {
                  protect = hasFocus;
                });
              },
            ),
            Padding(
              padding: EdgeInsets.only(top: 20),
              child: _registryButton(),
            )
          ],
        ),
      ),
    );
  }

  void checkInput() {
    // return userName != null && password != null && repa
    bool enable = false;
    if (userName.isNotEmpty && password.isNotEmpty && rePassword.isNotEmpty) {
      enable = true;
    }
    setState(() {
      registryEnable = enable;
    });
  }

  _registryButton() {
    return InkWell(
      onTap: () {
        if (registryEnable) {
          checkParams();
        } else {
          print(' registry is enable');
        }
      },
      child: Container(
        alignment: Alignment.center,
        color: registryEnable ? Colors.lightBlue : Colors.grey,
        padding: EdgeInsets.all(10),
        child: Text(
          "注 册",
          style: TextStyle(fontSize: 16, color: white),
        ),
      ),
    );
  }

  void send() async {
    try {
      var result = await LoginDao.registration(userName, password, rePassword);
      print('result: $result');
      if (result['code'] == '0') {
        await showMessageTipDialog(context, '注册成功');
        // showToast('注册成功');

        HiNavigator.getInstance().onJumpTo(RouteStatus.login);
      } else {
        await showMessageTipDialog(context, '注册失败:${result['msg']}');
        // showWarningToast('注册失败:${result['msg']}');
      }
    } on NeedAuth catch (e) {
      print(e);
    } on HiNetError catch (e) {
      print(e);
    }
  }

  void checkParams() async{
    String? tip;
    if (password != rePassword) {
      tip = "两次密码不一致";
    }
    if (tip != null) {
      // print('注册：${tip}');
      await showMessageTipDialog(context, tip);
      // showWarningToast(tip);
      return;
    }
    send();
  }
}
