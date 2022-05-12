import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';
import 'Application.dart';
import 'router_handler.dart';

class Routes {

  static String homepage = "/homepage";  //定义路由
  static String myInfo = "/myInfo";  //我的信息
  static String login = "/addDynamic";  //登录
  static String selectLocation = "/selectLocation";  //选择位置

  static void configureRoutes(FluroRouter router) { //处理未匹配到路由时展示的页面
    router.notFoundHandler = Handler(
        handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
          //return NotFoundPage();
        });

    //注册路由并指向所对应的handler(Handler对应的是界面)
    router.define(homepage, handler: indexPageHandler);
    router.define(myInfo, handler: myInfoHandler);
    router.define(login, handler: loginHandler);
    router.define(selectLocation, handler: selectLocationHandler);

  }

  //自定义的参数跳转
  // 对参数进行encode，解决参数中有特殊字符，影响fluro路由匹配
  static Future navigateTo(
      BuildContext context,
      String path,
      {Map<String, dynamic>? params,
        TransitionType transition = TransitionType.native
      }) {
    String query =  "";
    if (params != null) {
      int index = 0;
      for (var key in params.keys) {
        var value = Uri.encodeComponent(params[key]);
        if (index == 0) {
          query = "?";
        } else {
          query = query + "\&";
        }
        query += "$key=$value";
        index++;
      }
    }
    print('我是navigateTo传递的参数：$query');
    path = path + query;
    return Application.router.navigateTo(context, path, transition:transition);
  }
}
