
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:huomanduo_owner/generated/json/base/json_convert_content.dart';
import 'package:huomanduo_owner/pages/orders/model/order_model.dart';
import 'package:huomanduo_owner/utils/toast_util.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../common/base_app_bar.dart';
import '../../../http/base_model.dart';
import '../../../http/http_request.dart';
import '../../../http/http_url.dart';
import '../../../utils/hex_color.dart';

class OrderPage extends StatefulWidget {
  @override
  _OrderState createState() => _OrderState();
}

class _OrderState extends State<OrderPage>
    with AutomaticKeepAliveClientMixin {

  List<OrderModel> _orderList = [];
  RefreshController _refreshController = RefreshController(initialRefresh: false);

  void initState() {

    _requesOrderList();
  }

  Future _requesOrderList() async {

    Map<String,dynamic> params = new Map();
    final BaseModel baseModel = await HttpRequest().post(HttpUrl.orderList_URL, params: params);

    _orderList = JsonConvert.fromJsonAsT(baseModel.data);
    _refreshController.refreshCompleted();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        titleStr: "订单",
        bgColor: Colors.amber,
        leading: Text(""),
      ),
      body: SmartRefresher(
        enablePullDown: true,
        enablePullUp: true,
        onRefresh: _onRefresh,
        onLoading: _onLoading,
        controller: _refreshController,
        child: ListView.separated(
          shrinkWrap: true,
          itemCount: _orderList.length,
          padding: EdgeInsets.only(left: 10.w, right: 10.w, top: 10.w, bottom: 10.w),
          itemBuilder: (BuildContext context, int index) {
            OrderModel model = _orderList[index];
            return _orderCell(model);
          },
          separatorBuilder: (BuildContext context, int index) {
            return SizedBox(
              height: 10.w,
            );
          },
        ),
      )
    );
  }

  _orderCell(OrderModel orderModel) {
    return Container(
      padding: EdgeInsets.only(left: 15.w, right: 15.w),
      //height: 300.w,
      // color: HexColor(HexColor.HMD_White),
      decoration: BoxDecoration(
        color: HexColor(HexColor.HMD_White),
        borderRadius: BorderRadius.all(Radius.circular(10)),
        border: Border.all(width: 1, color: HexColor(HexColor.HMD_DCDCDC)),
      ),
      child:
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 10.w,
            ),
            Text(
                orderModel.loadingBeginTime + " ~ " + orderModel.loadingEndTime,
                style: TextStyle(fontSize: 14.sp, color: HexColor(HexColor.HMD_999999))
            ),
            SizedBox(
              height: 10.w,
            ),
            Divider(
              height: 0.5,
              color: HexColor(HexColor.HMD_DCDCDC),
            ),
            SizedBox(
              height: 10.w,
            ),
            Row(
              children: [
                Container(
                  width: 20.w,
                  height: 20.w,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10.w)),
                      color: Colors.green
                  ),
                  child: Center(
                    child: Text("发", style: TextStyle(fontSize: 12.sp, color: HexColor(HexColor.HMD_White)),),
                  ),
                ),
                SizedBox(
                  width: 10.w,
                ),
                Expanded(
                    child: Text(
                      orderModel.sendAddress,
                      style: TextStyle(fontSize: 15.sp, color: HexColor(HexColor.HMD_333333)),
                    ),
                )
              ],
            ),
            SizedBox(
              height: 5.w,
            ),
            Row(
              children: [
                Container(
                  width: 20.w,
                  height: 20.w,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10.w)),
                      color: Colors.red
                  ),
                  child: Center(
                    child: Text("收", style: TextStyle(fontSize: 12.sp, color: HexColor(HexColor.HMD_White)),),
                  ),
                ),
                SizedBox(
                  width: 10.w,
                ),
                Expanded(
                  child: Text(
                    orderModel.receiveAddress,
                    style: TextStyle(fontSize: 15.sp, color: HexColor(HexColor.HMD_333333)),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 10.w,
            ),
            Divider(
              height: 0.5,
              color: HexColor(HexColor.HMD_DCDCDC),
            ),
            SizedBox(
              height: 10.w,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                    orderModel.releaseTime,
                    style: TextStyle(fontSize: 15.sp, color: HexColor(HexColor.HMD_333333))
                ),
                // Flexible(
                //   fit: FlexFit.loose,
                //     child: SizedBox()
                // ),
                //Spacer(),
                // Expanded(
                //     child: SizedBox()
                // ),
                Text(
                    orderModel.orderPrice.toStringAsFixed(2),
                    style: TextStyle(fontSize: 17.sp, color: Colors.red),
                ),
              ],
            ),

            SizedBox(
              height: 10.w,
            ),
          ],
        )
    );
  }

  void _onRefresh() {

    _requesOrderList();
  }

  void _onLoading() {

    _refreshController.loadComplete();
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

