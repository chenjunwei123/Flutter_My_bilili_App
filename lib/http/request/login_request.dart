/*
 * @Author: cjw 1294511002@qq.com
 * @Date: 2024-01-16 22:14:13
 * @LastEditors: cjw 1294511002@qq.com
 * @LastEditTime: 2024-01-16 22:14:20
 * @FilePath: \my_bili_app\lib\http\request\login_request.dart
 * @Description: 这是默认设置,请设置`customMade`, 打开koroFileHeader查看配置 进行设置: https://github.com/OBKoro1/koro1FileHeader/wiki/%E9%85%8D%E7%BD%AE
 */

import "base_request.dart";

class LoginRequest extends BaseRequest {
  @override
  HttpMethod httpMethod() {
    return HttpMethod.POST;

  }

  @override
  bool needLogin() {
    return false;
  }

  @override
  String path() {
    return 'uapi/user/login';
  }

}