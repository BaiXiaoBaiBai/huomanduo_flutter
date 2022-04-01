import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:huomanduo_owner/pages/index_page.dart';
import 'package:huomanduo_owner/routers/Application.dart';
import 'package:huomanduo_owner/routers/routers.dart';

void main() {

  WidgetsFlutterBinding.ensureInitialized();
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

    // return  MaterialApp(
    //   debugShowCheckedModeBanner: false,
    //   title: "货满多货主",
    //   //theme: ThemeData(primaryColor: Colors.white),
    //   //debugShowCheckedModeBanner: false,
    //   //darkTheme: ThemeData.light(),
    //   theme: ThemeData(
    //       primarySwatch: Colors.green,
    //       splashColor: Colors.transparent,
    //       highlightColor: Colors.transparent
    //   ),
    //   onGenerateRoute: Application.router.generator, //全局注册
    //   home: IndexPage(),
    // );

    return ScreenUtilInit(
      splitScreenMode: true,
        // designSize: Size(750, 1334),
        designSize: Size(375, 667),
        builder: ()=>MaterialApp(
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
        )
    );

  }
}

/*

ScreenUtil().setWidth(540)  (sdk>=2.6 : 540.w)   //根据屏幕宽度适配尺寸
    ScreenUtil().setHeight(200) (sdk>=2.6 : 200.h)   //根据屏幕高度适配尺寸(一般根据宽度适配即可)
    ScreenUtil().radius(200)    (sdk>=2.6 : 200.r)   //根据宽度或高度中的较小者进行调整
    ScreenUtil().setSp(24)      (sdk>=2.6 : 24.sp)   //适配字体

    ScreenUtil.pixelRatio       //设备的像素密度
    ScreenUtil.screenWidth   (sdk>=2.6 : 1.sw)   //设备宽度
    ScreenUtil.screenHeight  (sdk>=2.6 : 1.sh)   //设备高度
    ScreenUtil.bottomBarHeight  //底部安全区距离，适用于全面屏下面有按键的
    ScreenUtil.statusBarHeight  //状态栏高度 刘海屏会更高
    ScreenUtil.textScaleFactor //系统字体缩放比例

    ScreenUtil().scaleWidth  // 实际宽度设计稿宽度的比例
    ScreenUtil().scaleHeight // 实际高度与设计稿高度度的比例

    ScreenUtil().orientation  //屏幕方向

    0.2.sw  //屏幕宽度的0.2倍
    0.5.sh  //屏幕高度的50%

 */
