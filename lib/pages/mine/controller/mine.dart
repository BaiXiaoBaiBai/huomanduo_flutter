
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:huomanduo_owner/gen_a/A.dart';
import 'package:huomanduo_owner/pages/mine/model/user_model.dart';
import '../../../http/base_model.dart';
import '../../../http/http_request.dart';
import '../../../http/http_url.dart';
import '../../../routers/Application.dart';
import '../../../routers/routers.dart';


class MinePage extends StatefulWidget {
  @override
  _MineState createState() => _MineState();
}

class _MineState extends State<MinePage>
    with AutomaticKeepAliveClientMixin {

  late UserModel _userModel;

  void initState() {
    _userModel = UserModel(
        user_id: 0,
        user_name: "",
        user_type: 0,
        avatar_url: "https://desk-fd.zol-img.com.cn/t_s960x600c5/g6/M00/03/0E/ChMkKWDZLXSICljFAC1U9uUHfekAARQfgG_oL0ALVUO515.jpg",
        mobile: ""
    );
    _requestUserInfo();
  }

  Future _requestUserInfo() async {

    Map<String,dynamic> params = new Map();
    params["token"] = "eyJhbGciOiJSUzI1NiJ9.eyJ1c2VyX2lkIjoxLCJleHAiOjE2NDg4MTIwMjZ9.4GnrOYSKvBVUILE7IEvpqombouUPtxMKrJMTPQ8a1r2eDqCDgAqCi9bCQHsHC8trEmN9qT9FEALurysv6x7qyc5lgqS-Gpab_1nZOWpRMXZcjQOyp-PtdNltbq_WpR6AcevIGqTH5_JPXD0WquuOhfEZ-CZtRDJzG-fCsmKpJFI";
    // params["companyId"] = "1";
    // params["userId"] = "9";
    // final result = await HttpRequest().post(HttpUrl.userInfo_URL, params: params);
    final BaseModel baseModel = await HttpRequest().post(HttpUrl.userInfo_URL, params: params);
    _userModel = UserModel.fromJson(baseModel.data);
    setState(() {});

    // BaseModel baseModel = BaseModel.fromJson(jsonDecode(result));
    //print("baeModel == ${baseModel.data}");

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
                    height: 170.w,
                    color: Colors.black12,
                    child: Stack(
                      children: [
                        Positioned(
                            left:15.w,
                            top: 80.w,
                            width: 60.w,
                            height: 60.w,
                            child: CircleAvatar(
                              radius: 30.w,
                              backgroundImage: NetworkImage("https://desk-fd.zol-img.com.cn/t_s960x600c5/g6/M00/03/0E/ChMkKWDZLXSICljFAC1U9uUHfekAARQfgG_oL0ALVUO515.jpg")
                            )
                        ),
                        Positioned(
                            left: 100.w,
                            top: 90.w,
                            right: 50.w,
                            height: 25.w,
                            child: Text(_userModel.user_name,style: TextStyle(fontSize: 15.sp,color: Colors.black,fontWeight: FontWeight.bold),)
                        ),
                        Positioned(
                          left: 100.w,
                            top: 115.w,
                            right: 0,
                            height: 20.w,
                            child: Text(_userModel.mobile,style: TextStyle(fontSize: 15.sp,color: Colors.grey),)
                        ),
                        Positioned(
                          top: 60.w,
                            right: 0,
                            height: 100.w,
                            width: 30.w,
                            child: GestureDetector(
                              child: Image.asset(A.assets_images_right_arrow),
                              onTap: (){
                                Application.router.navigateTo(context, Routes.myInfo, transition: TransitionType.native);
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