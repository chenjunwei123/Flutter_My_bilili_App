import 'dart:async';

import 'package:flutter/material.dart';

class LoginEffect extends StatefulWidget {
  const LoginEffect({Key? key, this.protect = false}) : super(key: key);
  final bool? protect;
  @override
  _LoginEffectState createState() => _LoginEffectState();
}

class _LoginEffectState extends State<LoginEffect> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
          color: Colors.grey[100],
          border: Border(bottom: BorderSide(color: Colors.grey))),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        _image(true),
        Image.asset(
          'images/logo.png',
          height: 90,
          width: 90,
        ),
        _image(false)
      ]),
    );
  }

  _image(bool left) {
    var headLeft = widget.protect!
        ? 'images/head_left_protect.png'
        : 'images/head_left.png';
    var headRight = widget.protect!
        ? 'images/head_right_protect.png'
        : 'images/head_right.png';
    return Image.asset(
      left ? headLeft : headRight,
      height: 90,
    );
  }
}
