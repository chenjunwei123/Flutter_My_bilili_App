/*
 * @Author: cjw 1294511002@qq.com
 * @Date: 2024-01-21 13:18:56
 * @LastEditors: cjw 1294511002@qq.com
 * @LastEditTime: 2024-01-21 20:37:04
 * @FilePath: \my_bili_app\lib\page\vedio_page_detail.dart
 * @Description: 这是默认设置,请设置`customMade`, 打开koroFileHeader查看配置 进行设置: https://github.com/OBKoro1/koro1FileHeader/wiki/%E9%85%8D%E7%BD%AEf
 */

import 'package:flutter/material.dart';
import 'package:my_bili_app/model/vedio_model.dart';
import 'package:my_bili_app/widget/appbar.dart';

class VedioPageDetail extends StatefulWidget {
  const VedioPageDetail({Key? key, this.vedioModel}) : super(key: key);
  final VedioModel? vedioModel;
  @override
  _VedioPageDetailState createState() => _VedioPageDetailState();
}

class _VedioPageDetailState extends State<VedioPageDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar('', '', () { }),
      body: Center(
        child: Text("视频详情页，vid:${widget.vedioModel?.vid}", style: TextStyle(fontSize: 18, color: Colors.blue),),
      ),
    );
  }
}
