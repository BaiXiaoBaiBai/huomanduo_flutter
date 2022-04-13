

import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:huomanduo_owner/pages/home/controller/amap_config.dart';

import '../../../common/base_app_bar.dart';
import 'package:amap_flutter_map/amap_flutter_map.dart';
import 'package:amap_flutter_base/amap_flutter_base.dart';
import 'package:amap_flutter_location/amap_flutter_location.dart';
import 'package:amap_flutter_location/amap_location_option.dart';
import 'package:permission_handler/permission_handler.dart';

class SelectLocation extends StatefulWidget {
  @override
  _SelectLocationState createState() => _SelectLocationState();
}

class _SelectLocationState extends State<SelectLocation>
    with SingleTickerProviderStateMixin {

  //LatLng _mapCenter = LatLng(39.909187, 116.397451);
  AMapFlutterLocation _locationPlugin = new AMapFlutterLocation();
  double _currentLat = 39.909187;
  double _currentLng = 116.397451;

  @override
  void initState() {

    AMapFlutterLocation.updatePrivacyShow(true, true);
    AMapFlutterLocation.updatePrivacyAgree(true);
    /// 动态申请定位权限
    requestPermission();

    AMapFlutterLocation.setApiKey(AmapConfig.androidKey, AmapConfig.iosKey);
    _setLocationOption();
    _locationPlugin.startLocation();

    _locationPlugin.onLocationChanged().listen((Map<String, Object>event) {

      print("11111111111");
      print(event);
      print(event["latitude"]);
      print(event["longitude"]);
      _currentLat = event["latitude"] as double;
      _currentLng = event["longitude"] as double;
    });
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
      //   print("lat = " + location.latLng.latitude.toString());
      //   print("lng = " + location.latLng.longitude.toString());
      // },
      onCameraMoveEnd: (pos) {

        print("lat1 = " + pos.target.latitude.toString());
        print("lng1 = " + pos.target.longitude.toString());
        //_mapCenter = LatLng(pos.target.latitude, pos.target.longitude);
      },

    );

    return Scaffold(
      // appBar: BaseAppBar(
      //   titleStr: "选择位置",
      //   bgColor: Colors.amber,
      // ),
      body: ConstrainedBox(
        constraints: BoxConstraints.expand(),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              left: 0,
              top: 0,
              right: 0,
              height: 500.h,
              child: map,
            ),
            // Positioned(
            //   right: 10,
            //     bottom: 15,
            //     child: Container(
            //       alignment: Alignment.centerLeft,
            //       child: Column(
            //         mainAxisAlignment: MainAxisAlignment.start,
            //         children: _approvalNumberWidget,
            //       ),
            //     )
            // )

          ],
        ),
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

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

}