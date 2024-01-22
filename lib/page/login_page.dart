import 'package:flutter/material.dart';
import 'package:my_bili_app/http/core/hi_error.dart';
import 'package:my_bili_app/http/dao/login_dao.dart';
import 'package:my_bili_app/navigitor/hi_navigator.dart';
import 'package:my_bili_app/util/color.dart';
// import 'package:my_bili_app/util/toast.dart';
import 'package:my_bili_app/widget/appbar.dart';
import 'package:my_bili_app/widget/login_effect.dart';
import 'package:my_bili_app/widget/login_input.dart';
import 'package:my_bili_app/widget/login_regis_button.dart';
import 'package:my_bili_app/widget/message_tip.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key, this.onSuccess}) : super(key: key);

  final VoidCallback? onSuccess;
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool protect = false;
  late String userName;
  late String password;
  bool loginEnable = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar("登录", "注册", () {
         HiNavigator.getInstance().onJumpTo(RouteStatus.registration);
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
              lineStrech: true,
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
            Padding(
              padding: EdgeInsets.only(top: 20, left: 10, right: 10),
              child: _loginButton(),
            )
          ],
        ),
      ),
    );
  }

  void checkInput() {
    // return userName != null && password != null && repa
    bool enable = false;
    if (userName.isNotEmpty && password.isNotEmpty) {
      enable = true;
    }
    setState(() {
      loginEnable = enable;
    });
  }


  _loginButton() {
    return LoginRegisButton("登录", enable: loginEnable, onPressed: login_callback);
  }

  void login_callback() {
    if (loginEnable) {
      send();
    } else {
      showMessageTipDialog(context, "用户名或密码为空，登陆失败！");
      // showWarningToast('用户名或密码为空，登陆失败！');
    }
  }

  void send() async {
    try {
      var result = await LoginDao.login(userName, password);
      if (result['code'] == '0') {
        // await showMessageTipDialog(context, '登录成功');
        // showToast('登录成功');
        if (widget.onSuccess != null) {
          print('success');
          widget.onSuccess!();
        }
      } else {
        print(111);
        await showMessageTipDialog(context, '${result['msg']}');
          // showWarningToast('${result['msg']}');
      }
    } on NeedAuth catch (e) {
      print(e);
    } on HiNetError catch (e) {
      print(e);
    }
  }
}
