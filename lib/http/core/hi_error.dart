/*
 * @Author: error: error: git config user.name & please set dead value or install git && error: git config user.email & please set dead value or install git & please set dead value or install git
 * @Date: 2024-01-14 14:03:29
 * @LastEditors: error: error: git config user.name & please set dead value or install git && error: git config user.email & please set dead value or install git & please set dead value or install git
 * @LastEditTime: 2024-01-14 14:10:09
 * @FilePath: \my_bili_app\lib\http\core\hi_error.dart
 * @Description: 这是默认设置,请设置`customMade`, 打开koroFileHeader查看配置 进行设置: https://github.com/OBKoro1/koro1FileHeader/wiki/%E9%85%8D%E7%BD%AE
 */

// 登陆异常
class NeedLogin extends HiNetError {
  NeedLogin({int code = 401, String message = '请先登录'}) :super(code,message);
}


// 登陆异常
class NeedAuth extends HiNetError {
  NeedAuth(String message, {int code = 403, dynamic data}) :super(code,message,data: data);
}




// 网络异常统一格式类
class HiNetError implements Exception {
  final int code;
  final String message;
  final dynamic data;
  HiNetError(this.code, this.message, {this.data});
  
}