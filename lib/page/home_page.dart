import 'package:flutter/material.dart';
import 'package:my_bili_app/model/vedio_model.dart';
import 'package:my_bili_app/widget/appbar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, this.onJumpToDetail}) : super(key: key);
  final ValueChanged<VedioModel>? onJumpToDetail;
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("首页"),
      ),
      // body: Container(
      //   child: Column(children: [
      //     Text("首页"),
      //     MaterialButton(
      //       onPressed: ,
      //       child: ,
      //     )
      //   ]),
      // ),
      body: Center(child: 
        ElevatedButton(onPressed: () => widget.onJumpToDetail!(VedioModel(vid:111)), child: Text("详情"))
      ,)
      
    );
  }
}
