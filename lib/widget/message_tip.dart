/*
 * @Author: cjw 1294511002@qq.com
 * @Date: 2024-01-20 18:58:51
 * @LastEditors: cjw 1294511002@qq.com
 * @LastEditTime: 2024-01-20 19:02:58
 * @FilePath: \my_bili_app\lib\widget\message_tip.dart
 * @Description: 这是默认设置,请设置`customMade`, 打开koroFileHeader查看配置 进行设置: https://github.com/OBKoro1/koro1FileHeader/wiki/%E9%85%8D%E7%BD%AE
 */
import 'package:flutter/material.dart';

Future<bool?> showMessageTipDialog(BuildContext context, tip){  
    return showDialog<bool>(  
        context: context,  
      builder: (BuildContext context){  
          return AlertDialog(  
            title: Text("提示"),  
            content: Text(tip),  
            actions: [  
              TextButton(  
                  onPressed: () {  
                    Navigator.of(context).pop(true);  
                  },  
                  child: Text("确认", style: TextStyle(fontSize: 16, color: Colors.blue),)  
              )  
            ],  
          );  
      }  
    );  
  }