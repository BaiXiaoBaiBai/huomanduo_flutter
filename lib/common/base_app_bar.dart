

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:huomanduo_owner/utils/hex_color.dart';
import 'package:huomanduo_owner/utils/screen_fit.dart';

import '../gen_a/A.dart';
import '../routers/Application.dart';

class BaseAppBar extends AppBar {

  static Color defaultBgColor = HexColor(HexColor.HMD_White);
  BaseAppBar({
    //required BuildContext context,
    required String titleStr,
    Color? bgColor,
    double? titleFontSize,
    Color? titleColor,
    Widget? leading,
    bool automaticallyImplyLeading = false,
    List<Widget>? actions,
  }) : super(
      elevation: 0, //去掉底部的阴影
      title: Text(
          titleStr,
          style: TextStyle(
            fontSize: titleFontSize??17.sp,
            color: titleColor??HexColor(HexColor.HMD_333333),
          ),
      ),
      backgroundColor:bgColor??HexColor(HexColor.HMD_White),
      centerTitle: true, //设置标题居中显示
      // leading: IconButton(
      //     icon: Image.asset(A.assets_images_appBar_back),
      //     onPressed: (){
      //
      //     }
      // ),
      // iconTheme: IconThemeData(
      //   color: Colors.black
      // )
      // leading: BackButton(
      //   color: Colors.black,
      // )
      leading: leading??BackButton(
        color: Colors.black,
      ),
      actions: actions,
      automaticallyImplyLeading: false,
      /*
      actions: [
        IconButton(
          icon: Icon(Icons.search),
          tooltip: "Search",
          onPressed: (){
            print("Search Pressed");
          },
        ),
        IconButton(
          icon: Icon(Icons.more_horiz),
          tooltip: "more_horiz",
          onPressed: (){
            print("more_horiz Pressed");
          },
        )
      ]
     */

  );

  // BaseAppBar({required PreferredSizeWidget bottom, required Widget title,required Color backGroundColor})
  //     : super(
  //     bottom: PreferredSize(
  //         child: Container(
  //           color: Colors.red,
  //           width: double.infinity,
  //           height: 5,
  //         ),
  //         preferredSize: Size.fromHeight(10)),
  //     title: title,
  //     backgroundColor:Colors.brown
  // );
}
