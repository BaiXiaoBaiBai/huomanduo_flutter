

import 'package:event_bus/event_bus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:huomanduo_owner/routers/Application.dart';
import 'package:huomanduo_owner/utils/app_event.dart';
import 'package:huomanduo_owner/utils/hex_color.dart';
import 'package:huomanduo_owner/utils/toast_util.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../http/base_model.dart';
import '../../../http/http_request.dart';
import '../../../http/http_url.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<LoginPage>
    with AutomaticKeepAliveClientMixin {

  final TextEditingController _mobileCtrl = TextEditingController();
  final TextEditingController _pwdCtrl = TextEditingController();

  void initState() {

  }

  Future _submitLoginInfo() async {

    Map<String,dynamic> params = new Map();
    params["mobile"] = _mobileCtrl.text;
    params["password"] = _pwdCtrl.text;

    final BaseModel baseModel = await HttpRequest().post(HttpUrl.userLogin_URL, params: params);
    if (baseModel.status == 200) {
      _saveToken(baseModel.data);
    }
    else {
      ToastUtil.show(baseModel.msg);
    }
  }

  // 保存token
  _saveToken(String token) async {

    SharedPreferences shared = await SharedPreferences.getInstance();
    await shared.setString("token", token);
    AppEvent.event.fire(ReloadUserInfoEvent());
    Application.router.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 170.w,
          ),
          Container(
            color: HexColor(HexColor.HMD_White),
            height: 50.w,
            child: Stack(
              children: [
                Positioned(
                    left:15.w,
                    top: 0,
                    bottom: 0,
                    child: Center(child: Text("手机号 :", style: TextStyle(fontSize: 15.sp, color: HexColor(HexColor.HMD_333333)),),)
                ),
                Positioned(
                    top: 0.w,
                    bottom: 0.w,
                    left: 90.w,
                    right: 15.w,
                    child: TextField(
                      controller: _mobileCtrl,
                      style: TextStyle(fontSize: 15.sp, color: HexColor(HexColor.HMD_666666)),
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "请输入手机号",
                      ),
                    )
                )
              ],
            ),
          ),
          Divider(
            color: HexColor(HexColor.HMD_DCDCDC),
            height: 1,
          ),
          Container(
            color: HexColor(HexColor.HMD_White),
            height: 50.w,
            child: Stack(
              children: [
                Positioned(
                    left:15.w,
                    top: 0,
                    bottom: 0,
                    child: Center(child: Text("密   码 :", style: TextStyle(fontSize: 15.sp, color: HexColor(HexColor.HMD_333333)),),)
                ),
                Positioned(
                    top: 0.w,
                    bottom: 0.w,
                    left: 90.w,
                    right: 15.w,
                    child: TextField(
                      controller: _pwdCtrl,
                      style: TextStyle(fontSize: 15.sp, color: HexColor(HexColor.HMD_666666)),
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "请输密码",
                      ),
                    )
                )
              ],
            ),
          ),
          SizedBox(
            height: 50.w,
          ),
          Container(
            height: 35.w,
            width: 170.w,
            child: ElevatedButton(
              style: ButtonStyle(backgroundColor: MaterialStateProperty.all(HexColor(HexColor.HMD_1A70FB))),
              child: Text("登录"),
              onPressed: (){
                if (_mobileCtrl.text.length == 0) {
                  ToastUtil.show("请输入手机号");
                }
                else if (_pwdCtrl.text.length == 0) {
                  ToastUtil.show("请输入密码");
                }
                else {
                  _submitLoginInfo();
                }
              },
            ),
          )
        ],
      )
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}








