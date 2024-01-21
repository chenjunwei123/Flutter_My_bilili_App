//创建页面
import 'package:flutter/material.dart';
import 'package:my_bili_app/page/home_page.dart';
import 'package:my_bili_app/page/login_page.dart';
import 'package:my_bili_app/page/registration_page.dart';
import 'package:my_bili_app/page/vedio_page_detail.dart';

pageWrap(Widget child) {
  return MaterialPage(key: ValueKey(child.hashCode), child: child);
}

//通过routeStatus获取在页面栈中的位置
int getPageIndex(List<MaterialPage> pages, RouteStatus routeStatus) {
  for(int i = 0; i < pages.length; i++) {
    MaterialPage page = pages[i];
    if(getStatus(page) == routeStatus) {
      return i;
    }
  }
  return -1;
}

// 自定义封装路由，状态
enum RouteStatus {
  login, registration, home, detail, unKnow
}


// 获取page对应的RouteStatus
RouteStatus getStatus (MaterialPage page) {
  if(page.child is LoginPage) {
    return RouteStatus.login;
  }else if(page.child is RegistrationPage) {
    return RouteStatus.registration;
  }else if(page.child is HomePage) {
    return RouteStatus.home;
  }else if(page.child is VedioPageDetail) {
    return RouteStatus.detail;
  }else {
    return RouteStatus.unKnow;
  }
}

class RouteStatusInfo {
  final RouteStatus routeStatus;
  final Widget page;

  RouteStatusInfo({required this.routeStatus, required this.page});
  
}