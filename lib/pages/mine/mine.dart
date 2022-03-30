
import 'package:flutter/material.dart';
import '../../http/base_model.dart';
import '../../http/http_request.dart';
import '../../http/http_url.dart';


class MinePage extends StatefulWidget {
  @override
  _MineState createState() => _MineState();
}

class _MineState extends State<MinePage>
    with AutomaticKeepAliveClientMixin {

  @override
  void initState() {

    _getList();
  }

  Future _getList() async {

    Map<String,dynamic> params = new Map();
    params["companyId"] = "1";
    params["userId"] = "9";
    // final result = await HttpRequest().post(HttpUrl.userConfig_url, params: params);
    final BaseModel baseModel = await HttpRequest().post(HttpUrl.userConfig_url, params: params);
    // BaseModel baseModel = BaseModel.fromJson(jsonDecode(result));
    print("baeModel == ${baseModel.data}");

    //print("data == ${result['data']}");
    // UserModel userModel = UserModel.fromJson(baseModel.data);
    // //print("data == ${userModel.shopDis}");
    //
    // for (ShopDis shopDis in userModel.shopDis) {
    //   print("shopDis == ${shopDis.name}");
    // }



  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("我的"),
        backgroundColor: Colors.green,
        elevation: 0, //去掉底部的阴影
      ),
      // body: Column(
      //   children: <Widget>[
      //     //new Expanded(child: new TabBarWidget()),
      //   ],
      // ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}