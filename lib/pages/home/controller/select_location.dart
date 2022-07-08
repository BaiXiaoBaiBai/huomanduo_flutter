
import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:huomanduo_owner/pages/home/controller/amap_config.dart';
import 'package:huomanduo_owner/pages/home/model/consignor_model.dart';
import 'package:huomanduo_owner/routers/Application.dart';

import '../../../common/base_app_bar.dart';
import 'package:amap_flutter_map/amap_flutter_map.dart';
import 'package:amap_flutter_base/amap_flutter_base.dart';
import 'package:amap_flutter_location/amap_flutter_location.dart';
import 'package:amap_flutter_location/amap_location_option.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../gen_a/A.dart';
import '../../../utils/hex_color.dart';
import '../../../http/base_model.dart';
import '../../../http/http_request.dart';
import '../../../http/http_url.dart';
import '../../../utils/toast_util.dart';
import '../view/input_done_view.dart';

class SelectLocation extends StatefulWidget {

  SelectLocation({
    Key? key,
    this.type}
      ) : super(key: key);

  int? type;

  @override
  _SelectLocationState createState() => _SelectLocationState();
}

class _SelectLocationState extends State<SelectLocation>
    with SingleTickerProviderStateMixin {

  //LatLng _mapCenter = LatLng(39.909187, 116.397451);
  AMapFlutterLocation _locationPlugin = new AMapFlutterLocation();
  double _currentLat = 0.0;
  double _currentLng = 0.0;
  final TextEditingController _peopleCtrl = TextEditingController();
  final TextEditingController _mobileCtrl = TextEditingController();
  final TextEditingController _addressCtrl = TextEditingController();
  String _addressStr = "";
  late int _type;
  InputDoneView _inputDoneView = InputDoneView();
  FocusNode _peopleFocusNode = FocusNode();
  FocusNode _mobileFocusNode = FocusNode();
  FocusNode _addressFocusNode = FocusNode();

  @override
  void initState() {

    _type = widget.type!;
    AMapFlutterLocation.updatePrivacyShow(true, true);
    AMapFlutterLocation.updatePrivacyAgree(true);
    /// 动态申请定位权限
    requestPermission();

    AMapFlutterLocation.setApiKey(AmapConfig.androidKey, AmapConfig.iosKey);
    _setLocationOption();
    _locationPlugin.startLocation();

    _locationPlugin.onLocationChanged().listen((Map<String, Object>event) {

      print(event);
      _currentLat = double.parse(double.parse(event["latitude"].toString()).toStringAsFixed(6));
      _currentLng = double.parse(double.parse(event["longitude"].toString()).toStringAsFixed(6));
      _addressStr =  event["address"].toString();
      setState(() {});
      _toCurrentLocation(_currentLat, _currentLng);
    });

    _peopleFocusNode.addListener(() {
      if (_peopleFocusNode.hasFocus) {
        _inputDoneView.showOverlay(context);
      } else {
        _inputDoneView.removeOverlay();
      }
    });

    _mobileFocusNode.addListener(() {
      if (_mobileFocusNode.hasFocus) {
        _inputDoneView.showOverlay(context);
      } else {
        _inputDoneView.removeOverlay();
      }
    });

    _addressFocusNode.addListener(() {
      if (_addressFocusNode.hasFocus) {
        _inputDoneView.showOverlay(context);
      } else {
        _inputDoneView.removeOverlay();
      }
    });
  }

  void _toCurrentLocation(double lat, double lng) {

    _mapController.moveCamera(
        CameraUpdate.newCameraPosition(
            CameraPosition(
                target: LatLng(lat, lng),
                zoom: 17
            )
        ),
        animated: true
    );
  }

  ///设置定位参数
  void _setLocationOption() {
    if (null != _locationPlugin) {
      AMapLocationOption locationOption = new AMapLocationOption();

      ///是否单次定位
      locationOption.onceLocation = true;

      ///是否需要返回逆地理信息
      locationOption.needAddress = true;

      ///逆地理信息的语言类型
      locationOption.geoLanguage = GeoLanguage.DEFAULT;

      locationOption.desiredLocationAccuracyAuthorizationMode =
          AMapLocationAccuracyAuthorizationMode.ReduceAccuracy;

      locationOption.fullAccuracyPurposeKey = "AMapLocationScene";

      ///设置Android端连续定位的定位间隔
      locationOption.locationInterval = 2000;

      ///设置Android端的定位模式<br>
      ///可选值：<br>
      ///<li>[AMapLocationMode.Battery_Saving]</li>
      ///<li>[AMapLocationMode.Device_Sensors]</li>
      ///<li>[AMapLocationMode.Hight_Accuracy]</li>
      locationOption.locationMode = AMapLocationMode.Hight_Accuracy;

      ///设置iOS端的定位最小更新距离<br>
      locationOption.distanceFilter = -1;

      ///设置iOS端期望的定位精度
      /// 可选值：<br>
      /// <li>[DesiredAccuracy.Best] 最高精度</li>
      /// <li>[DesiredAccuracy.BestForNavigation] 适用于导航场景的高精度 </li>
      /// <li>[DesiredAccuracy.NearestTenMeters] 10米 </li>
      /// <li>[DesiredAccuracy.Kilometer] 1000米</li>
      /// <li>[DesiredAccuracy.ThreeKilometers] 3000米</li>
      locationOption.desiredAccuracy = DesiredAccuracy.Best;

      ///设置iOS端是否允许系统暂停定位
      locationOption.pausesLocationUpdatesAutomatically = false;

      ///将定位参数设置给定位插件
      _locationPlugin.setLocationOption(locationOption);
    }
  }

  @override
  Widget build(BuildContext context) {
//CameraPosition
    final AMapWidget map = AMapWidget(
      apiKey: AmapConfig.amapApiKeys,
      privacyStatement: AmapConfig.amapPrivacyStatement,
      onMapCreated: onMapCreated,
      scaleEnabled: false,
      myLocationStyleOptions: MyLocationStyleOptions(true),
      initialCameraPosition: const CameraPosition(target: LatLng(39.909187, 116.397451), zoom: 17),
      // onLocationChanged: (location) {
      //
      //   print("lat2 = " + location.latLng.latitude.toString());
      //   print("lng2 = " + location.latLng.longitude.toString());
      // },
      onCameraMoveEnd: (pos) {
        print("lat = " + pos.target.latitude.toString());
        print("lng = " + pos.target.longitude.toString());

        _currentLat = double.parse(pos.target.latitude.toStringAsFixed(6));
        _currentLng = double.parse(pos.target.longitude.toStringAsFixed(6));
        _requestRegeoGeocode();
        //_mapCenter = LatLng(pos.target.latitude, pos.target.longitude);
      },

    );

    return Scaffold(
      appBar: BaseAppBar(
        titleStr: _type==1?"发货人信息":"收货人信息",
        bgColor: Colors.amber,
        actions: [
          TextButton(
            child: Text("确定",style: TextStyle(fontSize: 15.sp, color: HexColor(HexColor.HMD_1A70FB)),),
            onPressed: (){

              if(_addressStr.isEmpty) {
                ToastUtil.show("请稍等，地址正在加载...");
                return;
              }
              if(_peopleCtrl.text.isEmpty) {
                if(_type == 1) {
                  ToastUtil.show("请填写发货人姓名");
                }
                else {
                  ToastUtil.show("请填写收货人姓名");
                }
                return;
              }
              if(_mobileCtrl.text.isEmpty) {
                if(_type == 1) {
                  ToastUtil.show("请填写发货人手机号");
                }
                else {
                  ToastUtil.show("请填写收货人手机号");
                }
                return;
              }

              ConsignorModel model = new ConsignorModel(
                  latitude: _currentLat.toString(),
                  longitude: _currentLng.toString(),
                  adress: _addressStr,
                  name: _peopleCtrl.text.toString(),
                  mobile: _mobileCtrl.text.toString(),
                  detailAdress: _addressCtrl.text.toString());

              Application.router.pop(context,model);
            },
          )
        ],
      ),
      resizeToAvoidBottomInset: false,
      body: ConstrainedBox(
        constraints: BoxConstraints.expand(),
        child: Column (
          children: [
            Flexible(
                child: Container(
                  height: 400.h,
                  child: Stack (
                    alignment: Alignment.center,
                    children: [
                      Positioned(
                        left: 0,
                        top: 0,
                        right: 0,
                        height: 400.h,
                        child: map,
                      ),
                      Positioned(
                        //width: 100.w,
                        //height: 100.w,
                          right: 10,
                          top: 300.h,
                          child: IconButton(
                            //icon: ImageIcon(AssetImage(A.assets_images_right_arrow)),
                            icon: Image.asset(A.assets_images_map_reset),
                            onPressed: (){

                              _toCurrentLocation(_currentLat, _currentLng);
                            },
                          )
                      ),
                      Positioned(
                          width: 60,
                          height: 60,
                          left: 0.5.sw-30,
                          top: 200.h-30,
                          child: Image.asset(A.assets_images_map_center)
                      ),
                    ],
                  ),
                ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Padding(
              padding:EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom
              ),
              child: Column(
                children: [
                  Container(
                    height: 50.h,
                    padding: EdgeInsets.fromLTRB(15.w, 0, 15.w, 0),
                    child: Text(_addressStr,style: TextStyle(fontSize: 17.sp,color: HexColor(HexColor.HMD_333333)),),
                  ),
                  Row(
                    children: [
                      Container (
                        width: 185.w,
                        height: 40.h,
                        padding: EdgeInsets.fromLTRB(15.w, 0, 10.w, 0),
                        child: TextField(
                          controller: _peopleCtrl,
                          style: TextStyle(fontSize: 15.sp, color: HexColor(HexColor.HMD_666666)),
                          keyboardType: TextInputType.text,
                          focusNode: _peopleFocusNode,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "联系人(必填)",
                            hintMaxLines:1,
                            enabledBorder: new UnderlineInputBorder( // 下划线不是焦点的时候颜色
                              borderSide: BorderSide(
                                  color: HexColor(HexColor.HMD_DCDCDC)
                              ),
                            ),
                            focusedBorder: new UnderlineInputBorder( // 下划线焦点集中的时候颜色
                              borderSide: BorderSide(
                                  color: HexColor(HexColor.HMD_1A70FB)
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container (
                        width: 185.w,
                        height: 40.h,
                        padding: EdgeInsets.fromLTRB(15.w, 0, 10.w, 0),
                        child: TextField(
                          controller: _mobileCtrl,
                          style: TextStyle(fontSize: 15.sp, color: HexColor(HexColor.HMD_666666)),
                          keyboardType: TextInputType.phone,
                          focusNode: _mobileFocusNode,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "手机号(必填)",
                            hintMaxLines:1,
                            enabledBorder: new UnderlineInputBorder( // 下划线不是焦点的时候颜色
                              borderSide: BorderSide(
                                  color: HexColor(HexColor.HMD_DCDCDC)
                              ),
                            ),
                            focusedBorder: new UnderlineInputBorder( // 下划线焦点集中的时候颜色
                              borderSide: BorderSide(
                                  color: HexColor(HexColor.HMD_1A70FB)
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  Container (
                    height: 40.h,
                    padding: EdgeInsets.fromLTRB(15.w, 0, 15.w, 0),
                    child: TextField(
                      controller: _addressCtrl,
                      style: TextStyle(fontSize: 15.sp, color: HexColor(HexColor.HMD_666666)),
                      keyboardType: TextInputType.text,
                      focusNode: _addressFocusNode,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "楼层和门牌号(选填)",
                        hintMaxLines:1,
                        enabledBorder: new UnderlineInputBorder( // 下划线不是焦点的时候颜色
                          borderSide: BorderSide(
                              color: HexColor(HexColor.HMD_DCDCDC)
                          ),
                        ),
                        focusedBorder: new UnderlineInputBorder( // 下划线焦点集中的时候颜色
                          borderSide: BorderSide(
                              color: HexColor(HexColor.HMD_1A70FB)
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )

          ],
        )
      ),
    );
  }

  late AMapController _mapController;
  void onMapCreated(AMapController controller) {
    setState(() {
      _mapController = controller;
      getApprovalNumber();
    });
  }

  List<Widget> _approvalNumberWidget = [];
  /// 获取审图号
  void getApprovalNumber() async {
    //普通地图审图号
    String? mapContentApprovalNumber =
    await _mapController?.getMapContentApprovalNumber();
    //卫星地图审图号
    String? satelliteImageApprovalNumber =
    await _mapController?.getSatelliteImageApprovalNumber();
    setState(() {
      if (null != mapContentApprovalNumber) {
        _approvalNumberWidget.add(Text(mapContentApprovalNumber));
      }
      if (null != satelliteImageApprovalNumber) {
        _approvalNumberWidget.add(Text(satelliteImageApprovalNumber));
      }
    });
    print('地图审图号（普通地图）: $mapContentApprovalNumber');
    print('地图审图号（卫星地图): $satelliteImageApprovalNumber');
  }

  /// 动态申请定位权限
  void requestPermission() async {
    // 申请权限
    bool hasLocationPermission = await requestLocationPermission();
    if (hasLocationPermission) {
      print("定位权限申请通过");
    } else {
      print("定位权限申请不通过");
    }
  }

  /// 申请定位权限
  /// 授予定位权限返回true， 否则返回false
  Future<bool> requestLocationPermission() async {
    //获取当前的权限
    var status = await Permission.location.status;
    if (status == PermissionStatus.granted) {
      //已经授权
      return true;
    } else {
      //未授权则发起一次申请
      status = await Permission.location.request();
      if (status == PermissionStatus.granted) {
        return true;
      } else {
        return false;
      }
    }
  }

  // 逆地理编码
  Future _requestRegeoGeocode() async {

    Map<String,dynamic> params = new Map();
    params["key"] = AmapConfig.webKey;
    params["location"] = _currentLng.toString()+","+_currentLat.toString();

    final Map resultMap = await HttpRequest().getFullUrl(HttpUrl.amap_regeoGeocode_URL,params: params);
    if (int.parse(resultMap["status"].toString()) == 1) {
      _addressStr = resultMap["regeocode"]["formatted_address"];
      print("_addressStr = " + _addressStr);
      setState(() {});
    }

  }


  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

}

