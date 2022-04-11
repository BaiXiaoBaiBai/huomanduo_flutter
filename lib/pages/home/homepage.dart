

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:huomanduo_owner/common/base_app_bar.dart';
import 'package:huomanduo_owner/utils/screen_fit.dart';

import '../../utils/hex_color.dart';

class HomePage extends StatefulWidget {
  @override
  _MineState createState() => _MineState();
}

class _MineState extends State<HomePage>
    with SingleTickerProviderStateMixin {

  List<String> _tabValues = ['小面包车', '中面包车', '小货车', '4.2米', '6.8米', '7.6米', '9.6米', '13米', '17.5米'];
  CarouselController _carouselCtrl = CarouselController();
  List<Tab> _tabList = [];
  late TabController _controller;

  @override
  void initState() {
    ScreenFit.initialize();

    //_carouselCtrl.jumpToPage(3);
    _tabValues.forEach((data) {
      Tab tab = new Tab(
        text: data,
      );
      _tabList.add(tab);
    });
    _controller = new TabController(
      length: _tabValues.length, //Tab页数量
      vsync: this, //动画效果的异步处理
    );
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
          Stack(
            children: [
              Container(
                height: 35.w,
                alignment: Alignment.center,
                child: TabBar(
                  isScrollable: true,
                  indicatorColor: HexColor('#DCDCDC'),
                  labelColor: Color(0xffff3700),
                  unselectedLabelColor: Color(0xff666666),
                  labelStyle: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w500),
                  unselectedLabelStyle: TextStyle(fontSize: 15.sp),
                  indicatorSize: TabBarIndicatorSize.label,
                  controller: _controller,
                  tabs: _tabList,
                  onTap: (index) {
                    //_carouselCtrl.jumpToPage(index);
                    _carouselCtrl.animateToPage(index);
                  },
                ),
              )
            ],
          ),
          SizedBox(height: 7,),
          CarouselSlider(
            carouselController: _carouselCtrl,
            options: CarouselOptions(
              height: 130.w,
              enableInfiniteScroll: false, //是否循环滚动
              onPageChanged: (index, reason){
                  _controller.animateTo(index);
              },
            ),
            items: _tabValues.map((i) {
              return Builder(
                builder: (BuildContext context) {
                  return Container(
                      width: 1.sw,
                      color: Colors.white,
                      margin: EdgeInsets.symmetric(horizontal: 15.w),
                      // decoration: BoxDecoration(
                      //     color: Colors.green
                      // ),
                      child: Text('$i', style: TextStyle(fontSize: 16.0),)
                  );
                },
              );
            }).toList(),
          ),
          SizedBox(height: 10,),
          Container(
            width: 345.w,
            height: 130.w,
            // decoration: BoxDecoration(
            //   borderRadius: BorderRadius.all(Radius.circular(5))
            // ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5.w)),
              color: HexColor(HexColor.HMD_White),
            ),
            //color: HexColor(HexColor.HMD_White),
            child: Stack(
              children: [



              ],
            ),
          )


        ],
      ),

    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}