/*
 * @Author: cjw 1294511002@qq.com
 * @Date: 2024-01-21 14:21:47
 * @LastEditors: cjw 1294511002@qq.com
 * @LastEditTime: 2024-01-23 22:01:45
 * @FilePath: \my_bili_app\lib\navigitor\hi_navigator.dart
 * @Description: 这是默认设置,请设置`customMade`, 打开koroFileHeader查看配置 进行设置: https://github.com/OBKoro1/koro1FileHeader/wiki/%E9%85%8D%E7%BD%AE
 */
//创建页面
import 'package:flutter/material.dart';
import 'package:my_bili_app/page/home_page.dart';
import 'package:my_bili_app/page/login_page.dart';
import 'package:my_bili_app/page/registration_page.dart';
import 'package:my_bili_app/page/vedio_page_detail.dart';

typedef RouteChangeListener = void Function (RouteStatusInfo current, RouteStatusInfo pre);

pageWrap(Widget child) {
  return MaterialPage(key: ValueKey(child.hashCode), child: child);
}

//通过routeStatus获取在页面栈中的位置
int getPageIndex(List<MaterialPage> pages, RouteStatus routeStatus) {
  for (int i = 0; i < pages.length; i++) {
    MaterialPage page = pages[i];
    if (getStatus(page) == routeStatus) {
      return i;
    }
  }
  return -1;
}

// 自定义封装路由，状态
enum RouteStatus { login, registration, home, detail, unKnow }

// 获取page对应的RouteStatus
RouteStatus getStatus(MaterialPage page) {
  if (page.child is LoginPage) {
    return RouteStatus.login;
  } else if (page.child is RegistrationPage) {
    return RouteStatus.registration;
  } else if (page.child is HomePage) {
    return RouteStatus.home;
  } else if (page.child is VedioPageDetail) {
    return RouteStatus.detail;
  } else {
    return RouteStatus.unKnow;
  }
}

class RouteStatusInfo {
  final RouteStatus routeStatus;
  final Widget page;

  RouteStatusInfo({required this.routeStatus, required this.page});
}

// 监听路由页面跳转
// 感知当前页面是否压后台

class HiNavigator extends _RouteJumpListener {
  static HiNavigator? _instance;

  RouteJumpListener? _routeJump;

  RouteStatusInfo? _current;
  List<RouteChangeListener> _listener = [];


  HiNavigator._();
  static HiNavigator getInstance() {
    if (_instance == null) {
      _instance = HiNavigator._();
    }
    return _instance!;
  }

  // 注册路由跳转逻辑
  void registerRouteJump(RouteJumpListener routeJumpListener) {
    this._routeJump = routeJumpListener;
  }
  // 监听路由跳转
  void addListener(RouteChangeListener listener) {
    if(!_listener.contains(listener)) {
      _listener.add(listener);
    }
  }
  // 移除监听
  void removeListener(RouteChangeListener listener) {
    if(_listener.contains(listener)) {
      _listener.remove(listener);
    }
  }
  //通知路由页面变化
  void notify(List<MaterialPage> currentPages, List<MaterialPage> prePages) {
    if(currentPages == prePages) return;
    var current = RouteStatusInfo(routeStatus: getStatus(currentPages.last), page: currentPages.last.child);
    //通知路由页面变化
    _notify(current);
  }

  void _notify(RouteStatusInfo current) {
    // 当前页面
    print('navigator-current: ${current.page}');
    // 打开过的页面
    print('navigator-current: ${_current?.page}');

    _listener.forEach((element) {
      element(current, _current!);
    });

    _current = current;
  }

  

  @override
  void onJumpTo(RouteStatus routeStatus, {Map? args}) {
    _routeJump?.onJumpTo!(routeStatus, args: args);
  }
  
}

// 抽象类供HiNavigator实现
abstract class _RouteJumpListener {
  void onJumpTo(RouteStatus routeStatus, {Map? args});
}

typedef OnJumpTo = void Function(RouteStatus routeStatus, {Map? args});

//定义路由跳转逻辑要实现的功能
class RouteJumpListener {
  final OnJumpTo? onJumpTo;

  RouteJumpListener({this.onJumpTo});
}
