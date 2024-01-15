/*
 * @Author: error: error: git config user.name & please set dead value or install git && error: git config user.email & please set dead value or install git & please set dead value or install git
 * @Date: 2024-01-14 14:45:37
 * @LastEditors: error: error: git config user.name & please set dead value or install git && error: git config user.email & please set dead value or install git & please set dead value or install git
 * @LastEditTime: 2024-01-14 15:49:46
 * @FilePath: \my_bili_app\lib\http\core\hi_net_adapter.dart
 * @Description: 这是默认设置,请设置`customMade`, 打开koroFileHeader查看配置 进行设置: https://github.com/OBKoro1/koro1FileHeader/wiki/%E9%85%8D%E7%BD%AE
 */
import 'dart:convert';

import 'package:my_bili_app/http/request/base_request.dart';
import 'package:my_bili_app/http/request/test_request.dart';

///网络请求抽象类
abstract class HiNetAdapter {

  Future<HiNetResponse<T>> send<T>(BaseRequest request);
  
}

/// 统一网络层返回格式
class HiNetResponse<T> {
  HiNetResponse({
    required this.data,
    this.request,
    required this.statusCode,
    this.statusMessage,
    this.extra,
  });

  /// Response body. may have been transformed, please refer to [ResponseType].
  T data;

  /// The corresponding request info.
  BaseRequest? request;

  /// Http status code.
  int statusCode;

  /// Returns the reason phrase associated with the status code.
  /// The reason phrase must be set before the body is written
  /// to. Setting the reason phrase after writing to the body.
  String? statusMessage;

  /// Custom field that you can retrieve it later in `then`.
  dynamic extra;

  /// We are more concerned about `data` field.
  @override
  String toString() {
    if (data is Map) {
      return json.encode(data);
    }
    return data.toString();
  }
}
