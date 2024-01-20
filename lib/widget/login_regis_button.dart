import 'package:flutter/material.dart';
import 'package:my_bili_app/util/color.dart';

class LoginRegisButton extends StatelessWidget {
  const LoginRegisButton(this.title,
      {Key? key, this.enable = true, required this.onPressed})
      : super(key: key);
  final String title;
  final bool enable;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 1,
      child: MaterialButton(
        onPressed: enable ? onPressed : null,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        height: 45,
        disabledColor: Colors.grey,
        color: Colors.lightBlue,
        child: Text(
          title,
          style: TextStyle(color: white, fontSize: 16),
        ),
      ),
    );
  }
}
