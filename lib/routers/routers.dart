import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';
import 'router_handler.dart';

class Routes {

  static String homepage = "/homepage";  //定义路由
  static String addArticle = "/addArticle";  //添加文章
  static String addDynamic = "/addDynamic";  //添加动态

  static void configureRoutes(FluroRouter router) { //处理未匹配到路由时展示的页面
    router.notFoundHandler = Handler(
        handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
          //return NotFoundPage();
        });

    //注册路由并指向所对应的handler(Handler对应的是界面)
    router.define(homepage, handler: indexPageHandler);
    // router.define(addArticle, handler: addArticleHandler);
    // router.define(addDynamic, handler: addDynamicHandler);

  }

}
