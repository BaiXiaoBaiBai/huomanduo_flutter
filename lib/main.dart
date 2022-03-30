import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:huomanduo_owner/pages/index_page.dart';
import 'package:huomanduo_owner/routers/Application.dart';
import 'package:huomanduo_owner/routers/routers.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    super.initState();
    final router = FluroRouter();
    Application.router = router; //一定要先写这行
    Routes.configureRoutes(router); //再写这一行，因为我们在application中为给router初始值，如果先使用它肯定报错，所以要先赋值再使用
  }

  @override
  Widget build(BuildContext context) {
    // ScreenUtil.init(
    //   BoxConstraints(
    //     maxWidth: MediaQuery.of(context).size.width,
    //     maxHeight: MediaQuery.of(context).size.height
    //   ),
    //   designSize: Size(750, 1334),
    //   context: context,
    //   minTextAdapt: true,
    //   orientation: Orientation.portrait
    // );
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "货满多货主",
      //theme: ThemeData(primaryColor: Colors.white),
      //debugShowCheckedModeBanner: false,
      //darkTheme: ThemeData.light(),
      theme: ThemeData(
          primarySwatch: Colors.green,
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent
      ),
      onGenerateRoute: Application.router.generator, //全局注册
      home: IndexPage(),
    );
  }

}