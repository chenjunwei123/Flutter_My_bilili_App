/*
 * @Author: cjw 1294511002@qq.com
 * @Date: 2024-01-13 21:50:09
 * @LastEditors: cjw 1294511002@qq.com
 * @LastEditTime: 2024-01-22 21:48:47
 * @FilePath: \my_bili_app\lib\main.dart
 * @Description: 这是默认设置,请设置`customMade`, 打开koroFileHeader查看配置 进行设置: https://github.com/OBKoro1/koro1FileHeader/wiki/%E9%85%8D%E7%BD%AE
 */
import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:my_bili_app/http/core/hi_cache.dart';
import 'package:my_bili_app/http/core/hi_error.dart';
import 'package:my_bili_app/http/core/hi_net.dart';
import 'package:my_bili_app/http/dao/login_dao.dart';
import 'package:my_bili_app/http/request/test_request.dart';
import 'package:my_bili_app/model/vedio_model.dart';
import 'package:my_bili_app/navigitor/hi_navigator.dart';
import 'package:my_bili_app/page/home_page.dart';
import 'package:my_bili_app/page/login_page.dart';
import 'package:my_bili_app/page/registration_page.dart';
import 'package:my_bili_app/page/vedio_page_detail.dart';
import 'package:my_bili_app/util/color.dart';
import 'package:my_bili_app/widget/message_tip.dart';

void main() {
  runApp(const BiliApp());
}

class BiliApp extends StatefulWidget {
  const BiliApp({super.key});

  @override
  State<BiliApp> createState() => _BiliAppState();
}

class _BiliAppState extends State<BiliApp> {
  BiliRouteDelegate _routeDelegate = BiliRouteDelegate();
  // BiliRouterInfomationParser _routerInfomationParser =
  //     BiliRouterInfomationParser();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<HiCache?>(
        future: HiCache.prefsInit(),
        builder: (BuildContext context, AsyncSnapshot<HiCache?> snapshot) {
          var widget = snapshot.connectionState == ConnectionState.done
              ? Router(
                  routerDelegate: _routeDelegate,
                  // routeInformationParser: _routerInfomationParser,
                  // routeInformationProvider: PlatformRouteInformationProvider(
                  //     initialRouteInformation: RouteInformation(location: '/')),
                )
              : Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
          return MaterialApp(
            home: widget,
            theme: ThemeData(
              primarySwatch: white,
            ),
          );
        });
  }
}

class BiliRouteDelegate extends RouterDelegate<BiliRoutePath>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<BiliRoutePath> {
  final GlobalKey<NavigatorState> navigatorKey;
  RouteStatus _routeStatus = RouteStatus.home;
  BiliRouteDelegate() : navigatorKey = GlobalKey<NavigatorState>() {
    //实现路由跳转逻辑
    HiNavigator.getInstance().registerRouteJump(
        RouteJumpListener(onJumpTo: (RouteStatus routeStatus, {Map? args}) {
          _routeStatus = routeStatus;
          if(routeStatus == RouteStatus.detail) {
            this.vedioModel = args!['vedioMo'];
          }
          notifyListeners();
        }));
  }
  List<MaterialPage> pages = [];
  VedioModel? vedioModel;

  @override
  Widget build(BuildContext context) {
    //路由堆栈管理
    var index = getPageIndex(pages, _routeStatus);
    List<MaterialPage> tempPages = pages;
    if (index != -1) {
      tempPages = tempPages.sublist(0, index);
    }
    var page;
    if (routeStatus == RouteStatus.home) {
      pages.clear();
      page = pageWrap(HomePage());
    } else if (routeStatus == RouteStatus.detail) {
      page = pageWrap(VedioPageDetail(vedioModel: vedioModel));
    } else if (routeStatus == RouteStatus.registration) {
      page = pageWrap(RegistrationPage());
    } else if (routeStatus == RouteStatus.login) {
      page = pageWrap(LoginPage(onSuccess: () {
        HiNavigator.getInstance().onJumpTo(RouteStatus.home);
      },));
    }

    tempPages = [...tempPages, page];
    pages = tempPages;

    return WillPopScope(
        child: Navigator(
          key: navigatorKey,
          pages: pages,
          onPopPage: (route, result) {
            if (route.settings is MaterialPage) {
              //登录页未登录返回拦截
              if ((route.settings as MaterialPage).child is LoginPage) {
                if (!hasLogin) {
                  showMessageTipDialog(context, "请先登录！");
                  return false; // 登录拦截
                }
              }
            }
            if (!route.didPop(result)) {
              return false;
            }
            pages.removeLast(); //去除
            return true;
          },
        ),
        // android 物理 返回
        onWillPop: () async => !await navigatorKey.currentState!.maybePop());
  }

  RouteStatus get routeStatus {
    print('_routeStatus:$_routeStatus');
    print('hasLogin:$hasLogin');
    if (!hasLogin) {
      if (_routeStatus != RouteStatus.registration) {
        _routeStatus = RouteStatus.login;
      }
      return _routeStatus;
    } else {
      //已经登录
      // if (vedioModel != null) {
      //   _routeStatus = RouteStatus.detail;
      // }
      print('_routeStatus:$_routeStatus');
      return _routeStatus;
    }
  }

  bool get hasLogin => LoginDao.getBoardingPass() != null;
  // @override
  // // TODO: implement navigatorKey
  // GlobalKey<NavigatorState>? get navigatorKey => throw UnimplementedError();

  @override
  Future<void> setNewRoutePath(BiliRoutePath path) async {
    // TODO: implement setNewRoutePath
    // this.path = path;
  }
}

// 定义路由数据， path
class BiliRoutePath {
  final String location;
  BiliRoutePath.home() : location = '/';
  BiliRoutePath.detail() : location = '/detail';
}
