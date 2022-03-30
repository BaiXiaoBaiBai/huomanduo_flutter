import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import '../pages/index_page.dart';


var indexPageHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
      return IndexPage();
    }
);

// var addArticleHandler = Handler(
//     handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
//       return AddArticle();
//     }
// );
//
// var addDynamicHandler = Handler(
//     handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
//       return AddDynamic();
//     }
// );

