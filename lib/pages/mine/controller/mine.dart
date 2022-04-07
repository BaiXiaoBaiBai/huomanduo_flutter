
import 'package:cached_network_image/cached_network_image.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:huomanduo_owner/gen_a/A.dart';
import 'package:huomanduo_owner/pages/mine/model/user_model.dart';
import 'package:huomanduo_owner/utils/hex_color.dart';
import 'package:huomanduo_owner/utils/toast_util.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../http/base_model.dart';
import '../../../http/http_request.dart';
import '../../../http/http_url.dart';
import '../../../routers/Application.dart';
import '../../../routers/routers.dart';
import '../../../utils/app_event.dart';


class MinePage extends StatefulWidget {
  @override
  _MineState createState() => _MineState();
}

class _MineState extends State<MinePage>
    with AutomaticKeepAliveClientMixin {

  bool _isLogin = false;
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

    AppEvent.event.on<ReloadUserInfoEvent>().listen((event) {
      print("监听到了");
      _requestUserInfo();
    });
  }

  Future _requestUserInfo() async {

    ToastUtil.showLoad("");
    Map<String,dynamic> params = new Map();
    SharedPreferences shared = await SharedPreferences.getInstance();
    params["token"] = shared.getString("token");

    final BaseModel baseModel = await HttpRequest().post(HttpUrl.userInfo_URL, params: params);
    if(baseModel.status == 200) {
      _isLogin = true;
      _userModel = UserModel.fromJson(baseModel.data);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    height: 170.w,
                    color: Colors.black12,
                    child: _isLogin?_alreadyLogin():_notLogin()
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
    );
  }

  // 已登录
  _alreadyLogin() {
    return Stack(
      children: [
        Positioned(
            left:15.w,
            top: 80.w,
            width: 60.w,
            height: 60.w,
            child:CircleAvatar(
              radius: 30.w,
              backgroundImage: CachedNetworkImageProvider(
                _userModel.avatar_url,
              ),
            ),
            // CachedNetworkImage(
            //   imageUrl: "https://desk-fd.zol-img.com.cn/t_s960x600c5/g6/M00/03/0E/ChMkKWDZLXSICljFAC1U9uUHfekAARQfgG_oL0ALVUO515.jpg",
            // )
            // child: CircleAvatar(
            //     radius: 30.w,
            //     backgroundImage: NetworkImage("https://desk-fd.zol-img.com.cn/t_s960x600c5/g6/M00/03/0E/ChMkKWDZLXSICljFAC1U9uUHfekAARQfgG_oL0ALVUO515.jpg")
            // )
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
    );
  }

  // 未登录
  _notLogin() {
    return Stack(
      children: [
        Positioned(
            left: 100.w,
            top: 90.w,
            //right: 50.w,
            //height: 30.w,
            child: TextButton(
              child: Text("请登录", style: TextStyle(fontSize: 17.sp, color: HexColor(HexColor.HMD_333333)),),
              onPressed: (){
                Application.router.navigateTo(context, Routes.login, transition: TransitionType.nativeModal);
              },
            )
        )
      ],
    );
  }

  // _bottomSheet() {
  //   return showModalBottomSheet(
  //       context: context,
  //       builder: (BuildContext con) => Container(
  //         height: 160,
  //         padding: EdgeInsets.all(20),
  //         color: Colors.white,
  //         child: Column(
  //           children: [Text("data"), Text("data2")],
  //         ),
  //       )
  //   );
  // }


  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

  }

}

/*

eyJhbGciOiJSUzI1NiJ9.eyJ1c2VyX2lkIjoxLCJleHAiOjE2NDg3MzI3NzV9.kbAdbEaZab7OBvpPyQE2he-u1GEbsgwWy9QpPlqeh7CFNBXK4pu-Pjc8QYk6Jf5EyZSE3N7gKeFo9AaUh-tXXXgEBh3-uokAjAsXT7yoeow5INjjEdDQ0H8Jtdna6MU2rYXaGO0ZTjz0UgflneKZv2yjtZncUA46z38zdH58WJc
 */