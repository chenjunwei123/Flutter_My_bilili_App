/*
 * @Author: cjw 1294511002@qq.com
 * @Date: 2024-01-21 13:12:04
 * @LastEditors: cjw 1294511002@qq.com
 * @LastEditTime: 2024-01-23 22:19:09
 * @FilePath: \my_bili_app\lib\page\home_page.dart
 * @Description: 这是默认设置,请设置`customMade`, 打开koroFileHeader查看配置 进行设置: https://github.com/OBKoro1/koro1FileHeader/wiki/%E9%85%8D%E7%BD%AE
 */
import 'package:flutter/material.dart';
import 'package:my_bili_app/model/vedio_model.dart';
import 'package:my_bili_app/navigitor/hi_navigator.dart';
import 'package:my_bili_app/widget/appbar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var listener;
  @override
  void initState() {
    HiNavigator.getInstance().addListener(this.listener = (current, pre) {
      print('current: ${current.page}');
      print('pre: ${pre.page}');
      if(widget == current.page || current.page is HomePage) {
        print('打开了首页 首页onResume');
      }else if(widget == pre?.page || pre?.page is HomePage) {
        print('首页被压后台 首页onPause');
      }
    });
    super.initState();
  }
  @override
  void dispose() {
      HiNavigator.getInstance().removeListener(this.listener);
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("首页"),
      ),
      body: Center(child: 
        ElevatedButton(onPressed: () {
          HiNavigator.getInstance().onJumpTo(RouteStatus.detail,args: {'vedioMo':VedioModel(vid: 111)});
        }, child: Text("详情"))
      ,)
      
    );
  }
}
