/*
 * @Author: cjw 1294511002@qq.com
 * @Date: 2024-01-16 22:25:26
 * @LastEditors: cjw 1294511002@qq.com
 * @LastEditTime: 2024-01-17 21:31:55
 * @FilePath: \my_bili_app\lib\http\dao\login_dao.dart
 * @Description: 这是默认设置,请设置`customMade`, 打开koroFileHeader查看配置 进行设置: https://github.com/OBKoro1/koro1FileHeader/wiki/%E9%85%8D%E7%BD%AE
 */

import 'package:my_bili_app/http/core/hi_cache.dart';
import 'package:my_bili_app/http/core/hi_net.dart';
import 'package:my_bili_app/http/request/base_request.dart';
import 'package:my_bili_app/http/request/login_request.dart';
import 'package:my_bili_app/http/request/registration_request.dart';

class LoginDao {
  static const BOARDING_PASS = "boarding-pass";

  static login(String userName, String password) {
    return _send(userName, password);
  }

  static registration(
      String userName, String password, String imoocId, String orderId) {
    return _send(userName, password, imoocId: imoocId, orderId: orderId);
  }

  static _send(String userName, String password, {imoocId, orderId}) async {
    BaseRequest request;
    if (imoocId != null && orderId != null) {
      request = RegistrationRequest();
    } else {
      request = LoginRequest();
    }
    request
        .add("userName", userName)
        .add("password", password)
        .add("imoocId", imoocId)
        .add("orderId", orderId);
    var result = await HiNet.getInstance().fire(request, 'login');
    if (result['code'] == 0 && result['data'] != null) {
      //保存登录令牌
      HiCache.getInstance().setString(BOARDING_PASS, result['data']);
    }
    return result;
  }

  static getBoardingPass() {
    return HiCache.getInstance().get(BOARDING_PASS);
  }
}
