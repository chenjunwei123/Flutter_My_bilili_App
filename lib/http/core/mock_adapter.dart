/*
 * @Author: error: error: git config user.name & please set dead value or install git && error: git config user.email & please set dead value or install git & please set dead value or install git
 * @Date: 2024-01-14 15:18:21
 * @LastEditors: error: error: git config user.name & please set dead value or install git && error: git config user.email & please set dead value or install git & please set dead value or install git
 * @LastEditTime: 2024-01-14 18:19:22
 * @FilePath: \my_bili_app\lib\http\core\mock_adapter.dart
 * @Description: 这是默认设置,请设置`customMade`, 打开koroFileHeader查看配置 进行设置: https://github.com/OBKoro1/koro1FileHeader/wiki/%E9%85%8D%E7%BD%AE
 */ 
import 'package:my_bili_app/http/core/hi_net_adapter.dart';
import 'package:my_bili_app/http/request/base_request.dart';

///测试适配器，mock数据
class MockAdapter extends HiNetAdapter {
  @override
  Future<HiNetResponse<T>> send<T>(BaseRequest? request) {
    return Future<HiNetResponse<T>>.delayed(Duration(milliseconds: 1000), () {
      return HiNetResponse(
          data: {"code":0, "message": 'success'} as T, statusCode: 401);
    });
  }
}
