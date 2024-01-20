/*
 * @Author: cjw 1294511002@qq.com
 * @Date: 2024-01-20 13:13:50
 * @LastEditors: cjw 1294511002@qq.com
 * @LastEditTime: 2024-01-20 14:28:42
 * @FilePath: \my_bili_app\lib\widget\login_input.dart
 * @Description: 这是默认设置,请设置`customMade`, 打开koroFileHeader查看配置 进行设置: https://github.com/OBKoro1/koro1FileHeader/wiki/%E9%85%8D%E7%BD%AE
 */

import 'package:flutter/material.dart';
import 'package:my_bili_app/util/color.dart';
import 'package:my_bili_app/widget/login_effect.dart';

class LoginInput extends StatefulWidget {
  const LoginInput(this.title, this.hint,
      {Key? key,
      this.onChanged,
      this.focusChanged,
      this.lineStrech = false,
      this.obscureText = false,
      required this.keboardType})
      : super(key: key);
  final String title; // labe
  final String? hint; // 提示文本
  final ValueChanged<String>? onChanged; //文本框变化
  final ValueChanged<bool>? focusChanged; //密码框聚焦
  final bool lineStrech;
  final bool obscureText; // 密码是否遮掩
  final TextInputType keboardType;
  @override
  _LoginInputState createState() => _LoginInputState();
}

class _LoginInputState extends State<LoginInput> {
  final _focusNode = FocusNode();
  @override
  void initState() {
    _focusNode.addListener(() {
      if (widget.focusChanged != null) {
        widget.focusChanged!(_focusNode.hasFocus);
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double dividePadding = !widget.lineStrech ? 20 : 0;
    return Column(
      children: <Widget>[
        Row(
          children: [
            Container(
              padding: EdgeInsets.only(left: 15),
              width: 100,
              child: Text(
                widget.title,
                style: TextStyle(fontSize: 16),
              ),
            ),
            _input()
          ],
        ),
        Padding(
            padding: EdgeInsets.only(left: dividePadding, right: dividePadding),
            child: Divider(color: Colors.grey, height: 5, thickness: .5,),)
      ],
    );
  }

  _input() {
    return Expanded(
        child: TextField(
      focusNode: _focusNode,
      onChanged: widget.onChanged,
      obscureText: widget.obscureText,
      keyboardType: widget.keboardType,
      autofocus: !widget.obscureText,
      cursorColor: primary,
      style: TextStyle(
          fontSize: 16, color: Colors.black, fontWeight: FontWeight.w300),
      decoration: InputDecoration(
          contentPadding: EdgeInsets.only(left: 20, right: 20),
          border: InputBorder.none,
          hintText: widget.hint ?? '',
          hintStyle: TextStyle(fontSize: 15, color: Colors.grey)),
    ));
  }
}
