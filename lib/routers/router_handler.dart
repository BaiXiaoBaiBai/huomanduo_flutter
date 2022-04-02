import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:huomanduo_owner/pages/Login/controller/login_page.dart';
import 'package:huomanduo_owner/pages/mine/controller/my_info.dart';
import '../pages/index_page.dart';


var indexPageHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
      return IndexPage();
    }
);

var myInfoHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
      return MyInfoPage();
    }
);

var loginHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
      return LoginPage();
    }
);


