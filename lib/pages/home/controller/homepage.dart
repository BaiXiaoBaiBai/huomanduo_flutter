
import 'package:carousel_slider/carousel_slider.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:huomanduo_owner/common/base_app_bar.dart';
import 'package:huomanduo_owner/pages/home/model/consignor_model.dart';
import 'package:huomanduo_owner/utils/screen_fit.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../http/base_model.dart';
import '../../../http/http_url.dart';
import '../../../routers/Application.dart';
import '../../../routers/routers.dart';
import '../../../utils/hex_color.dart';
import 'package:flutter_cupertino_datetime_picker/flutter_cupertino_datetime_picker.dart';
import 'package:date_format/date_format.dart';

import '../../../utils/toast_util.dart';
import '../view/input_done_view.dart';
import 'package:huomanduo_owner/http/http_request.dart';

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

  late ConsignorModel _faModel;
  late ConsignorModel _shouModel;
  late InlineSpan _faSpan;
  late InlineSpan _shouSpan;
  String _beginTime = "";
  String _endTime = "";
  String _submitBeginTime = "";
  String _submitEndTime = "";
  final TextEditingController _priceCtrl = TextEditingController();
  // late OverlayEntry overlayEntry;
  InputDoneView _inputDoneView = InputDoneView();
  FocusNode _hideFocusNode = FocusNode();

  // String beginTimeShow = "";
  // String endTimeShow = "";
  
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

    _faModel = new ConsignorModel(latitude: "", longitude: "", adress: "", name: "", mobile: "", detailAdress: "");
    _shouModel = new ConsignorModel(latitude: "", longitude: "", adress: "", name: "", mobile: "", detailAdress: "");
    _faSpan = TextSpan(text: '请选择发货地址',style: TextStyle(fontSize: 15.sp, color: HexColor(HexColor.HMD_999999)));
    _shouSpan = TextSpan(text: '请选择收货地址',style: TextStyle(fontSize: 15.sp, color: HexColor(HexColor.HMD_999999)));

    _hideFocusNode.addListener(() {
      if (_hideFocusNode.hasFocus) {
        //_showOverlay(context);
        _inputDoneView.showOverlay(context);
      } else {
        //_removeOverlay();
        _inputDoneView.removeOverlay();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //resizeToAvoidBottomInset: true,
      appBar: BaseAppBar(
        titleStr: "首页",
        bgColor: Colors.amber,
        leading: Text(""),
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
              child: Column(
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
                ],
              )
          ),
          SliverToBoxAdapter(
            child: Column (
              children: [
                Container(
                  width: 345.w,
                  height: 330.w,
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
                      Positioned(
                          width: 24.w,
                          height: 24.w,
                          left: 15.w,
                          top: 18.w,
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(12.w)),
                                color: Colors.green
                            ),
                            child: Center(
                              child: Text("发", style: TextStyle(fontSize: 13.sp, color: HexColor(HexColor.HMD_White)),),
                            ),
                          )
                      ),
                      Positioned(
                          left: 55.w,
                          top: 15.w,
                          right: 15.w,
                          child: GestureDetector(
                            child: RichText(
                              text: _faSpan,
                              maxLines: 3,
                            ),
                            onTap: (){
                              Application.router.navigateTo(context, Routes.selectLocation+"?type=1",transition: TransitionType.native).then((value)
                              {
                                _faModel = value;
                                _faSpan = TextSpan(text: _faModel.adress,style: TextStyle(fontSize: 15.sp, color: HexColor(HexColor.HMD_333333)),
                                    children: <TextSpan>[
                                      TextSpan(text: '\n'+_faModel.name+"    "+_faModel.mobile,style: TextStyle(fontSize: 13.sp, color: HexColor(HexColor.HMD_999999))),
                                    ]
                                );
                                setState(() {});
                              });
                            },
                          )
                      ),
                      Positioned(
                          left: 50.w,
                          top: 90.w,
                          right: 15.w,
                          child: Divider(
                            color: HexColor(HexColor.HMD_DCDCDC),
                            height: 1,
                          )
                      ),
                      Positioned(
                          width: 24.w,
                          height: 24.w,
                          left: 15.w,
                          top: 108.w,
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(12.w)),
                                color: Colors.red
                            ),
                            child: Center(
                              child: Text("收", style: TextStyle(fontSize: 13.sp, color: HexColor(HexColor.HMD_White)),),
                            ),
                          )
                      ),
                      Positioned(
                          left: 55.w,
                          top: 105.w,
                          right: 15.w,
                          child: GestureDetector(
                            child: RichText(
                              text: _shouSpan,
                              maxLines: 3,
                            ),
                            onTap: (){
                              Application.router.navigateTo(context, Routes.selectLocation+"?type=2",transition: TransitionType.native).then((value) {

                                _shouModel = value;
                                _shouSpan = TextSpan(text: _shouModel.adress,style: TextStyle(fontSize: 15.sp, color: HexColor(HexColor.HMD_333333)),
                                    children: <TextSpan>[
                                      TextSpan(text: '\n'+_shouModel.name+"    "+_shouModel.mobile,style: TextStyle(fontSize: 13.sp, color: HexColor(HexColor.HMD_999999))),
                                    ]
                                );
                                setState(() {});
                              });
                            },
                          )
                      ),
                      Positioned(
                          left: 15.w,
                          top: 180.w,
                          right: 15.w,
                          child: Divider(
                            color: HexColor(HexColor.HMD_DCDCDC),
                            height: 1,
                          )
                      ),
                      Positioned(
                          left: 15.w,
                          top: 200.w,
                          width: 100.w,
                          height: 30.h,
                          child: Center(
                            child: Text("装货起止时间:",style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold, color: HexColor(HexColor.HMD_333333)),),
                          )
                      ),
                      Positioned(
                          left: 120.w,
                          top: 200.w,
                          right: 5.w,
                          height: 30.h,
                          child: OutlinedButton(
                            style: ButtonStyle(side: MaterialStateProperty.all(BorderSide(color: Color(0xffffffff))), alignment: Alignment.centerLeft),
                            child:
                            // Align(
                            //   alignment: Alignment.centerLeft,
                            //   child: Text("请选择时间",
                            //     style: TextStyle(fontSize: 15.sp, color: HexColor(HexColor.HMD_666666)),
                            //     textAlign: TextAlign.left,
                            //   ),
                            // ),
                            Text( _beginTime.isEmpty&&_endTime.isEmpty ? "请选择时间":_beginTime + " ~ " + _endTime,
                              style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w400, color: HexColor(HexColor.HMD_666666))
                            ),
                            onPressed: (){
                              _showBeginDatePicker(DateTime.now());
                            },
                          )
                      ),
                      Positioned(
                          left: 15.w,
                          top: 250.w,
                          width: 100.w,
                          height: 30.h,
                          child: Center(
                            child: Text("运   单  价  格:",style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold, color: HexColor(HexColor.HMD_333333)),),
                          )
                      ),
                      Positioned(
                          left: 120.w,
                          top: 250.w,
                          width: 170.w,
                          height: 30.h,
                          child:
                          // KeyboardActions(
                          //   config: _buildConfig(context),
                          //   //tapOutsideBehavior: TapOutsideBehavior.translucentDismiss,
                          //   autoScroll: false,
                          //   keepFocusOnTappingNode: true,
                          //   child: TextField(
                          //     //textAlignVertical: TextAlignVertical.center,
                          //     focusNode: _nodeText1,
                          //     controller: _priceCtrl,
                          //     style: TextStyle(fontSize: 15.sp, color: HexColor(HexColor.HMD_333333)),
                          //     keyboardType: TextInputType.number,
                          //     textAlign: TextAlign.start,
                          //     decoration: InputDecoration(
                          //       contentPadding: EdgeInsets.only(left: 10, top: 0, right: 0, bottom: 0),
                          //       //contentPadding: EdgeInsets.all(0),
                          //       border:OutlineInputBorder(
                          //           borderSide: BorderSide(width: 1, color: HexColor(HexColor.HMD_F7F7F7)),
                          //           borderRadius: BorderRadius.all(Radius.circular(5.w))
                          //       ),
                          //       hintText: "请输入运单价格",
                          //     ),
                          //   ),
                          // )

                          TextField(
                            //textAlignVertical: TextAlignVertical.center,
                            controller: _priceCtrl,
                            style: TextStyle(fontSize: 15.sp, color: HexColor(HexColor.HMD_333333)),
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.start,
                            focusNode: _hideFocusNode,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(left: 10, top: 0, right: 0, bottom: 0),
                              //contentPadding: EdgeInsets.all(0),
                              border:OutlineInputBorder(
                                borderSide: BorderSide(width: 1, color: HexColor(HexColor.HMD_F7F7F7)),
                                borderRadius: BorderRadius.all(Radius.circular(5.w)),
                              ),
                              hintText: "请输入运单价格",
                            ),
                          )

                      ),

                    ],
                  ),
                ),
                SizedBox(
                  height: 30.h,
                ),
                Container(
                  height: 40.h,
                  width: 170.w,
                  child: ElevatedButton(
                    style: ButtonStyle(backgroundColor: MaterialStateProperty.all(HexColor(HexColor.HMD_1A70FB))),
                    child: Text("发货"),
                    onPressed: (){
                      _submitSendGoodsData();
                    },
                  ),
                )

              ],
            )
          ),
          SliverList(delegate: SliverChildBuilderDelegate((content,index){


          }))
        ],
      ),

    );
  }

  //DateTime _dateTime=DateTime.now();

  // 选择开始时间
  void _showBeginDatePicker(DateTime _dateTime){

    DateTime beginDateTime = _dateTime;
    DatePicker.showDatePicker(
      context,
      onMonthChangeStartWithFirstDate: true,

      // 如果报错提到 DateTimePickerTheme 有问题，点开这个类的原文件作如下修改。
      // 移除'with DiagnosticableMixin'或者将'DiagnosticableMixin'改成'Diagnosticable'.
      pickerTheme: DateTimePickerTheme(
          showTitle: true,
          confirm: Text('确认', style: TextStyle(color: Colors.red)),
          cancel: Text('取消',style:TextStyle(color:Colors.cyan)),
          //title: Text("开始时间",style: TextStyle(color: Colors.red)),
      ),

      //minDateTime: _dateTime,
      //maxDateTime: DateTime.parse("2050-1-1"),
      initialDateTime: _dateTime,
      dateFormat:'M月-d日 H时:m分',
      pickerMode: DateTimePickerMode.datetime,
      locale: DateTimePickerLocale.zh_cn,

      onConfirm: (dateTime, List<int> index) {
        beginDateTime = dateTime;
        _beginTime = formatDate(dateTime, [mm,".",dd," ",HH,":",nn]);
        _submitBeginTime = formatDate(dateTime, [yyyy,"-",mm,"-",dd," ",HH,":",nn,":",ss]);
        setState(() {});
      },
      onClose: () {
        _showEndDatePicker(beginDateTime);
      }
    );
  }

  // 选择结束时间
  void _showEndDatePicker(DateTime _dateTime){

    DatePicker.showDatePicker(
      context,
      onMonthChangeStartWithFirstDate: true,

      // 如果报错提到 DateTimePickerTheme 有问题，点开这个类的原文件作如下修改。
      // 移除'with DiagnosticableMixin'或者将'DiagnosticableMixin'改成'Diagnosticable'.
      pickerTheme: DateTimePickerTheme(
        showTitle: true,
        confirm: Text('确认', style: TextStyle(color: Colors.red)),
        cancel: Text('取消',style:TextStyle(color:Colors.cyan)),
        //title: Text("开始时间",style: TextStyle(color: Colors.red)),
      ),

      minDateTime: _dateTime,
      //maxDateTime: DateTime.parse("2050-1-1"),
      initialDateTime: _dateTime,
      dateFormat:'M月-d日 H时:m分',
      pickerMode: DateTimePickerMode.datetime,
      locale: DateTimePickerLocale.zh_cn,

      onConfirm: (dateTime, List<int> index) {
        _endTime = formatDate(dateTime, [mm,".",dd," ",HH,":",nn]);
        _submitEndTime = formatDate(dateTime, [yyyy,"-",mm,"-",dd," ",HH,":",nn,":",ss]);
        print(_endTime);
        setState(() {});
      },
    );
  }

  //提交发货数据
  Future _submitSendGoodsData() async{

    Map<String,dynamic> params = new Map();
    SharedPreferences shared = await SharedPreferences.getInstance();
    params["token"] = shared.getString("token");
    params["goods_name"] = "饮用水";
    params["order_price"] = _priceCtrl.text;
    params["loading_begin_time"] = _submitBeginTime;
    params["loading_end_time"] = _submitEndTime;

    params["send_latitude"] = _faModel.latitude;
    params["send_longitude"] = _faModel.longitude;
    params["send_address"] = _faModel.adress;
    params["send_name"] = _faModel.name;
    params["send_mobile"] = _faModel.mobile;
    params["send_doorplate"] = _faModel.detailAdress;

    params["receive_latitude"] = _shouModel.latitude;
    params["receive_longitude"] = _shouModel.longitude;
    params["receive_address"] = _shouModel.adress;
    params["receive_name"] = _shouModel.name;
    params["receive_mobile"] = _shouModel.mobile;
    params["receive_doorplate"] = _shouModel.detailAdress;

    final BaseModel baseModel = await HttpRequest().post(HttpUrl.submitSendGoods_URL, params: params);
    ToastUtil.show(baseModel.msg);
    if (baseModel.status == 200) {

    }

  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
