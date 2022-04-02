import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';
import 'router_handler.dart';

class Routes {

  static String homepage = "/homepage";  //定义路由
  static String myInfo = "/myInfo";  //我的信息
  static String login = "/addDynamic";  //登录

  static void configureRoutes(FluroRouter router) { //处理未匹配到路由时展示的页面
    router.notFoundHandler = Handler(
        handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
          //return NotFoundPage();
        });

    //注册路由并指向所对应的handler(Handler对应的是界面)
    router.define(homepage, handler: indexPageHandler);
    router.define(myInfo, handler: myInfoHandler);
    router.define(login, handler: loginHandler);

  }

}
