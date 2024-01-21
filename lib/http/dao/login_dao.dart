/*
 * @Author: cjw 1294511002@qq.com
 * @Date: 2024-01-16 22:25:26
 * @LastEditors: cjw 1294511002@qq.com
 * @LastEditTime: 2024-01-21 19:57:47
 * @FilePath: \my_bili_app\lib\http\dao\login_dao.dart
 * @Description: 这是默认设置,请设置`customMade`, 打开koroFileHeader查看配置 进行设置: https://github.com/OBKoro1/koro1FileHeader/wiki/%E9%85%8D%E7%BD%AE
 */

import 'dart:math';

import 'package:my_bili_app/http/core/hi_cache.dart';
import 'package:my_bili_app/http/core/hi_net.dart';
import 'package:my_bili_app/http/request/base_request.dart';
import 'package:my_bili_app/http/request/login_request.dart';
import 'package:my_bili_app/http/request/registration_request.dart';

class LoginDao {
  static const LOGIN_PASS = "login-pass";
  static const REGISTRY_PASS = "registry-pass";
  static login(String userName, String password) {
    return _send(userName, password);
  }

  static registration(String userName, String password, rePassword) {
    return _send(userName, password, rePassword: rePassword);
  }

  static _send(String userName, String password, {rePassword}) async {
    BaseRequest request;
    if (rePassword != null) {
      request = RegistrationRequest();
      request
          .add("userName", userName)
          .add("password", password)
          .add("repassword", rePassword);
    } else {
      request = LoginRequest();
      request.add("userName", userName).add("password", password);
    }
    print(1111);
    var result = await HiNet.getInstance()
        .fire(request, rePassword == null ? 'login' : 'registry');
        print('result: $result');
    if (result['code'] == '0' && result['data'] != null) {
      if (rePassword == null) {
        HiCache.getInstance().setString(LOGIN_PASS, result['data']);
      } else {
        HiCache.getInstance().setString(REGISTRY_PASS, result['data']);
        print('regis: ${HiCache.getInstance().get(REGISTRY_PASS)}');
      }
    }
    return result;
  }

  static getBoardingPass() {
    print('HiCache.getInstance().get(LOGIN_PASS): ${HiCache.getInstance().get(LOGIN_PASS)}');
    return HiCache.getInstance().get(LOGIN_PASS);
  }

  static getRegistryPass() {
    return HiCache.getInstance().get(REGISTRY_PASS);
  }
}
