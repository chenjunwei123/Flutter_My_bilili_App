/*
 * @Author: cjw 1294511002@qq.com
 * @Date: 2024-01-13 21:50:09
 * @LastEditors: cjw 1294511002@qq.com
 * @LastEditTime: 2024-01-21 18:40:15
 * @FilePath: \my_bili_app\lib\main.dart
 * @Description: 这是默认设置,请设置`customMade`, 打开koroFileHeader查看配置 进行设置: https://github.com/OBKoro1/koro1FileHeader/wiki/%E9%85%8D%E7%BD%AE
 */
import 'dart:convert';

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

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    HiCache.prefsInit();
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: white,
        ),
        home: Builder(
          builder: (context) {
            return RegistrationPage(onJumpToLogin: () {
              onJumpToLogin(context);
            });
          },
        )
        // home: LoginPage(onJumpToRegistry: (){
        //     onJumpToRegistry(context);

        //   },)
        );
  }

  void onJumpToRegistry(context) {
    print('welcome to registry');
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => RegistrationPage(onJumpToLogin: () {
            onJumpToLogin(context);
          }),
        ));
  }

  void onJumpToLogin(context) {
    print('onJumpToLogin');
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => LoginPage(onJumpToRegistry: () {
            onJumpToRegistry(context);
          }),
        ));
  }
}

class BiliRouteDelegate extends RouterDelegate<BiliRoutePath>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<BiliRoutePath> {
  final GlobalKey<NavigatorState> navigatorKey;
  RouteStatus _routeStatus = RouteStatus.home;
  BiliRouteDelegate() : navigatorKey = GlobalKey<NavigatorState>();
  List<MaterialPage> pages = [];
  VedioModel? vedioModel;


  @override
  Widget build(BuildContext context) {
    //路由堆栈管理
    var index = getPageIndex(pages, _routeStatus);
    List<MaterialPage> tempPages = pages;
    if(index != -1) {
      tempPages = tempPages.sublist(0, index);
    }
    var page;
    if(routeStatus == RouteStatus.home) {
      pages.clear();
      page = pageWrap(HomePage(
        onJumpToDetail: (videoMoel) {
          this.vedioModel = videoMoel;
          notifyListeners();
        },
      ));
    }else if(routeStatus == RouteStatus.detail){
      page = pageWrap(VedioPageDetail(vedioModel: vedioModel));
    }else if(routeStatus == RouteStatus.registration){
      page = pageWrap(RegistrationPage(onJumpToLogin: (){
        _routeStatus = RouteStatus.login;
        notifyListeners();
      }));
    }else if(routeStatus == RouteStatus.login){
      page = pageWrap(LoginPage(onJumpToRegistry: (){
        _routeStatus = RouteStatus.home;
        notifyListeners();
      }));
    }

  tempPages = [...tempPages, page];
  pages = tempPages;
    return Navigator(
      key: navigatorKey,
      pages: pages,
      onPopPage: (route, result) {
        if (!route.didPop(result)) {
          return false;
        }
        return true;
      },
    );
  }


  RouteStatus get routeStatus {
    //如果不是登录页面且未登录，则返回登录页面
    if(_routeStatus != RouteStatus.registration && !hasLogin) {
       _routeStatus = RouteStatus.login;
    }else if(vedioModel != null) {
       _routeStatus = RouteStatus.detail;
    }
    return _routeStatus;
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

// class BiliRouterInfomationParser extends RouteInformationParser<BiliRoutePath> {
//   @override
//   Future<BiliRoutePath> parseRouteInformation(
//       RouteInformation routeInformation) async {
//     final uri = Uri.parse(routeInformation.location);
//     if (uri.pathSegments.length == 0) {
//       return BiliRoutePath.home();
//     }
//     return BiliRoutePath.detail();
//   }
// }

// 定义路由数据， path
class BiliRoutePath {
  final String location;
  BiliRoutePath.home() : location = '/';
  BiliRoutePath.detail() : location = '/detail';
}

//创建页面
pageWrap(Widget child) {
  return MaterialPage(key: ValueKey(child.hashCode), child: child);
}
