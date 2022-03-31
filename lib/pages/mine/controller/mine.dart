
import 'package:flutter/material.dart';
import 'package:huomanduo_owner/gen_a/A.dart';
import 'package:huomanduo_owner/utils/screen_fit.dart';
import 'package:huomanduo_owner/utils/toast_util.dart';
import '../../../http/base_model.dart';
import '../../../http/http_request.dart';
import '../../../http/http_url.dart';


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
    params["token"] = "eyJhbGciOiJSUzI1NiJ9.eyJ1c2VyX2lkIjoxLCJleHAiOjE2NDg3MzQ2OTd9.6F_hhQBO9myP77VeUzDS9qJfTVTsFW17TNylJ-6028Rhfw9ZsLV-ElfjYByn1ttvmnaNmeSYq_KovKf_6xPunVhTJz6ufjK_zSrgLJJDZAP9D7g6cANRA1k1hxC5ZdL-AK0_x3IipjpFeUmqzCgA0htLd3UzBQhR3xxFBH3Y-mE";
    // params["companyId"] = "1";
    // params["userId"] = "9";
    // final result = await HttpRequest().post(HttpUrl.userConfig_url, params: params);
    final BaseModel baseModel = await HttpRequest().post(HttpUrl.userInfo_URL, params: params);
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
      // appBar: AppBar(
      //   title: Text("我的"),
      //   backgroundColor: Colors.green,
      //   elevation: 0, //去掉底部的阴影
      // ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    height: ScreenFit.getWidth(130),
                    color: Colors.black12,
                    child: Stack(
                      children: [
                        Positioned(
                            left:ScreenFit.getWidth(15),
                            top: ScreenFit.getWidth(50),
                            width: ScreenFit.getWidth(60),
                            height: ScreenFit.getWidth(60),
                            child: CircleAvatar(
                              radius: ScreenFit.getWidth(30),
                              backgroundImage: NetworkImage("https://desk-fd.zol-img.com.cn/t_s960x600c5/g6/M00/03/0E/ChMkKWDZLXSICljFAC1U9uUHfekAARQfgG_oL0ALVUO515.jpg")
                            )
                        ),
                        Positioned(
                            left: ScreenFit.getWidth(100),
                            top: ScreenFit.getWidth(60),
                            right: ScreenFit.getWidth(50),
                            height: ScreenFit.getWidth(25),
                            child: Text("白小白",style: TextStyle(fontSize: 15,color: Colors.black,fontWeight: FontWeight.bold),)
                        ),
                        Positioned(
                          left: ScreenFit.getWidth(100),
                            top: ScreenFit.getWidth(90),
                            right: ScreenFit.getWidth(0),
                            height: ScreenFit.getWidth(20),
                            child: Text("15633671843",style: TextStyle(fontSize: 15,color: Colors.grey),)
                        ),
                        Positioned(
                          top: ScreenFit.getWidth(50),
                            right: 0,
                            height: ScreenFit.getWidth(60),
                            width: ScreenFit.getWidth(30),
                            child: GestureDetector(
                              child: Image.asset(A.assets_images_right_arrow),
                              onTap: (){
                                ToastUtil.show("msgStr");
                              },
                            )
                        )
                      ],


                    )
                  )
                ),
              ],
            )
          ),
          SliverToBoxAdapter(

          ),
          SliverList(delegate: SliverChildBuilderDelegate((content,index){

          }))
        ],
      ),
      // body: ListView (
      //   shrinkWrap: true,
      //   itemCount: 5,
      //   itemBuilder: (BuildContext context, int index) {
      //
      //   },
      //   separatorBuilder: (BuildContext context, int index) {
      //     return Divider(
      //       color: Colors.red,
      //       height: 1,
      //     );
      //   },
      // )
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

/*

eyJhbGciOiJSUzI1NiJ9.eyJ1c2VyX2lkIjoxLCJleHAiOjE2NDg3MzI3NzV9.kbAdbEaZab7OBvpPyQE2he-u1GEbsgwWy9QpPlqeh7CFNBXK4pu-Pjc8QYk6Jf5EyZSE3N7gKeFo9AaUh-tXXXgEBh3-uokAjAsXT7yoeow5INjjEdDQ0H8Jtdna6MU2rYXaGO0ZTjz0UgflneKZv2yjtZncUA46z38zdH58WJc
 */