

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:huomanduo_owner/pages/home/controller/amap_config.dart';

import '../../../common/base_app_bar.dart';
import 'package:amap_flutter_map/amap_flutter_map.dart';

class SelectLocation extends StatefulWidget {
  @override
  _SelectLocationState createState() => _SelectLocationState();
}

class _SelectLocationState extends State<SelectLocation>
    with SingleTickerProviderStateMixin {

  @override
  void initState() {

  }

  @override
  Widget build(BuildContext context) {

    final AMapWidget map = AMapWidget(
      apiKey: AmapConfig.amapApiKeys,
      onMapCreated: onMapCreated,
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
            Container(
              //left: 0,
              //top: 0,
              height: 200,
              width: 300,
              child: map,
            ),
            Positioned(
              right: 10,
                bottom: 15,
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: _approvalNumberWidget,
                  ),
                )
            )

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

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

}