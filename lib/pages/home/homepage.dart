

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:huomanduo_owner/common/base_app_bar.dart';
import 'package:huomanduo_owner/utils/screen_fit.dart';

class HomePage extends StatefulWidget {
  @override
  _MineState createState() => _MineState();
}

class _MineState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {

  @override
  void initState() {
    ScreenFit.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        titleStr: "首页",
        bgColor: Colors.amber,
        leading: Text(""),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 10.w,
          ),
          CarouselSlider(
            options: CarouselOptions(
                height: 130.w
            ),
            items: [1,2,3,4,5].map((i) {
              return Builder(
                builder: (BuildContext context) {
                  return Container(
                      width: 1.sw,
                      margin: EdgeInsets.symmetric(horizontal: 15.w),
                      decoration: BoxDecoration(
                          color: Colors.green
                      ),
                      child: Text('text $i', style: TextStyle(fontSize: 16.0),)
                  );
                },
              );
            }).toList(),
          )
          ],
      ),

    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}