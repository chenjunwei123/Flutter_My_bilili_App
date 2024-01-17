/*
 * @Author: error: error: git config user.name & please set dead value or install git && error: git config user.email & please set dead value or install git & please set dead value or install git
 * @Date: 2024-01-14 15:18:21
 * @LastEditors: cjw 1294511002@qq.com
 * @LastEditTime: 2024-01-17 21:36:37
 * @FilePath: \my_bili_app\lib\http\core\mock_adapter.dart
 * @Description: 这是默认设置,请设置`customMade`, 打开koroFileHeader查看配置 进行设置: https://github.com/OBKoro1/koro1FileHeader/wiki/%E9%85%8D%E7%BD%AE
 */ 
import 'package:my_bili_app/http/core/hi_net_adapter.dart';
import 'package:my_bili_app/http/request/base_request.dart';

///测试适配器，mock数据
class MockAdapter extends HiNetAdapter {
  String type;
  MockAdapter({required this.type});
  @override
  Future<HiNetResponse<T>> send<T>(BaseRequest? request) {
    if(type == 'login') {
      return buildMockData({'code': 0, 'data': 'AFAFdsfsaaGHTXXdsvVSDasfd'});
    }
    
    return buildMockData({'code': 0, 'data': 'no mock data'});
 
  }
  
  Future<HiNetResponse<T>> buildMockData<T>(Object data) {
    return Future<HiNetResponse<T>>.delayed(Duration(milliseconds: 1000), () {
        return HiNetResponse(
            data: data as T, statusCode: 200);
      });
  }
}
