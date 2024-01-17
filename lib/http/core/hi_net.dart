/*
 * @Author: error: error: git config user.name & please set dead value or install git && error: git config user.email & please set dead value or install git & please set dead value or install git
 * @Date: 2024-01-14 12:59:22
 * @LastEditors: cjw 1294511002@qq.com
 * @LastEditTime: 2024-01-17 21:32:57
 * @FilePath: \my_bili_app\lib\http\core\hi_net.dart
 * @Description: 这是默认设置,请设置`customMade`, 打开koroFileHeader查看配置 进行设置: https://github.com/OBKoro1/koro1FileHeader/wiki/%E9%85%8D%E7%BD%AE
 */

import 'package:flutter/material.dart';
import 'package:my_bili_app/http/core/dio_adapter.dart';
import 'package:my_bili_app/http/core/hi_error.dart';
import 'package:my_bili_app/http/core/hi_net_adapter.dart';
import 'package:my_bili_app/http/core/mock_adapter.dart';
import 'package:my_bili_app/http/request/base_request.dart';

class HiNet {
  HiNet._();
  static HiNet instance = HiNet._();
  static HiNet getInstance() {
    if (instance == null) {
      instance = HiNet._();
      return instance;
    }
    return instance;
  }

  Future fire(BaseRequest request, String type) async {
    HiNetResponse? response;
    var error;
    try {
      response = await send(request, type);
    } on HiNetError catch (e) {
      // HiNetError类型的错误
      error = e;
      response = e.data;
      print(e.message);
    } catch (e) {
      // 其他异常
      error = e;
      print(error);
    }

    if (response == null) {
      print(error);
    }
    var result = response?.data;

    var status = response?.statusCode;
    switch (status) {
      case 200:
        return result;
      case 401:
        print('throw NeedLogin()');
        throw NeedLogin();
      case 403:
        throw NeedAuth(result.toString(), data: result['data']);
      default:
        throw HiNetError(status!, result.toString(), data: result['data']);
    }
  }

  Future<dynamic> send<T>(BaseRequest request, String type) async {
    printLog('url:${request.url()}');
    // 使用Mock发送数据

    HiNetAdapter adapter = MockAdapter(type: type);
    return adapter.send<Map<String, Object>>(request);
    //使用Dio发送数据
    // HiNetAdapter adapter = DioAdapter();
    // return adapter.send(request);
    // print('aa:$aa');
    // return aa;
  }

  printLog(log) {
    print(log.toString());
  }
}
