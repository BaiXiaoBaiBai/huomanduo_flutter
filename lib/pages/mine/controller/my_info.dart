
import 'dart:io';

import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:huomanduo_owner/common/base_app_bar.dart';
import 'package:huomanduo_owner/http/http_request.dart';
import 'package:huomanduo_owner/utils/hex_color.dart';
import 'package:huomanduo_owner/utils/image_compress.dart';
import 'package:huomanduo_owner/utils/toast_util.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../gen_a/A.dart';
import '../../../http/base_model.dart';
import '../../../http/http_url.dart';
import '../../../utils/app_event.dart';
import '../../home/view/input_done_view.dart';
import '../model/user_model.dart';

class MyInfoPage extends StatefulWidget {
  @override
  _MyInfoState createState() => _MyInfoState();
}

class _MyInfoState extends State<MyInfoPage>
    with AutomaticKeepAliveClientMixin {

  late UserModel _userModel;
  late Image _iconImage;
  late String _imagePath;
  final TextEditingController _userNameCtrl = TextEditingController();
  InputDoneView _inputDoneView = InputDoneView();
  FocusNode _hideFocusNode = FocusNode();

  void initState() {
    _userModel = UserModel(
        user_id: 0,
        user_name: "",
        user_type: 0,
        avatar_url: "https://desk-fd.zol-img.com.cn/t_s960x600c5/g6/M00/03/0E/ChMkKWDZLXSICljFAC1U9uUHfekAARQfgG_oL0ALVUO515.jpg",
        mobile: ""
    );
    _iconImage = Image.network(_userModel.avatar_url, fit: BoxFit.cover,);
    // _iconImage = CachedNetworkImage(
    //   imageUrl: _userModel.avatar_url,
    //   fit: BoxFit.cover,
    // ) as Image;
    _requestUserInfo();

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

  Future _requestUserInfo() async {

    Map<String,dynamic> params = new Map();
    SharedPreferences shared = await SharedPreferences.getInstance();
    params["token"] = shared.getString("token");

    final BaseModel baseModel = await HttpRequest().post(HttpUrl.userInfo_URL, params: params);
    _userModel = UserModel.fromJson(baseModel.data);
    _userNameCtrl.text = _userModel.user_name;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        titleStr: "????????????",
        actions: [
          TextButton(
            child: Text("??????",style: TextStyle(fontSize: 13.sp, color: HexColor(HexColor.HMD_666666)),),
            onPressed: (){
              _submitUserInfo();
            },
          )
        ],
      ),
      body: Column(
        children: [
          Container(
            height: 10.w,
            width: ScreenUtil().screenWidth,
            color: HexColor(HexColor.HMD_F7F7F7),
          ),
          Expanded(
              child: ListView.separated(
                shrinkWrap: true, //???????????????
                itemCount: 3,
                itemBuilder: (BuildContext context, int index) {
                  switch(index){
                    case 0 :
                      return _headerImageCell();
                      break;
                    case 1 :
                      return _userNameCell();
                      break;
                    default:
                      return _mobileCell();
                      break;
                  }
                },
                separatorBuilder: (BuildContext context, int index) {
                  return Divider(
                    color: HexColor(HexColor.HMD_DCDCDC),
                    height: 1,
                  );
                },
              )
          )
        ],
      )
    );
  }

  // ??????cell
  _headerImageCell() {
    return Container(
        height: 70.w,
        color: HexColor(HexColor.HMD_White),
        child: Stack(
          children: [
            Positioned(
                left: 15.w,
                top: 0,
                bottom: 0,
                child: Center(
                  child: Text(
                    "??????",
                    style: TextStyle(fontSize: 15.sp, color: HexColor(HexColor.HMD_333333)),
                    textAlign: TextAlign.left,
                  ),
                )
            ),
            Positioned(
                top: 10.w,
                width: 50.w,
                height: 50.w,
                right: 50.w,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(25.w),
                  child: _iconImage,
                )
            ),
            Positioned(
                right: 0,
                top: 0,
                bottom: 0,
                width: 50.w,
                child: GestureDetector(
                  child: Image.asset(A.assets_images_right_arrow),
                  onTap: () async {
                    final result = await showConfirmationDialog<int>(
                      context: context,
                      title: "?????????",
                      cancelLabel: "??????",
                      actions: const [
                        AlertDialogAction(key: 1,label: "??????"),
                        AlertDialogAction(key: 2,label: "???????????????")
                      ],
                    );
                    switch(result){
                      case 1 :
                        takePhoto();
                        break;
                      case 2 :
                        photoLibrary();
                        break;
                    }
                  },
                )
            )
          ],
        )
    );
  }

  // ??????
  Future takePhoto() async {
    XFile? xFile = await ImagePicker().pickImage(source: ImageSource.camera, imageQuality: 1);
    _iconImage = Image.file(File(xFile!.path), fit: BoxFit.cover,);
    _imagePath = xFile.path;
    setState(() {});
  }

  // ??????????????????
  Future photoLibrary() async {
    XFile? xFile = await ImagePicker().pickImage(source: ImageSource.gallery, imageQuality: 20);
    _iconImage = Image.file(
      File(xFile!.path),
      fit: BoxFit.cover,
    );
    _imagePath = xFile.path;
    setState(() {});
  }

  // ?????????cell
  _userNameCell() {
    return Container(
      height: 50.w,
      color: HexColor(HexColor.HMD_White),
      child: Stack(
        children: [
          Positioned(
              left: 15.w,
              top: 0,
              bottom: 0,
              child: Center(
                child: Text(
                  "?????????",
                  style: TextStyle(fontSize: 15.sp, color: HexColor(HexColor.HMD_333333)),
                  textAlign: TextAlign.left,
                ),
              )
          ),
          Positioned(
              top: 0,
              bottom: 0,
              right: 50.w,
              left: 100.w,
              child: TextField(
                controller: _userNameCtrl,
                focusNode: _hideFocusNode,
                style: TextStyle(fontSize: 15.sp, color: HexColor(HexColor.HMD_333333)),
                keyboardType: TextInputType.text,
                textAlign: TextAlign.end,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "??????????????????",
                ),
              )
              // Center(
              //   child: Text(_userModel.user_name, style: TextStyle(fontSize: 15.sp, color: HexColor(HexColor.HMD_333333))),
              // )
          ),
          Positioned(
            right: 0,
              top: 0,
              bottom: 0,
              width: 50.w,
              child: GestureDetector(
                child: Image.asset(A.assets_images_right_arrow),
                onTap: (){

                },
              )
          )
        ],
      )
    );
  }

  // ?????????cell
  _mobileCell() {
    return Container(
        height: 50.w,
        color: HexColor(HexColor.HMD_White),
        child: Stack(
          children: [
            Positioned(
                left: 15.w,
                top: 0,
                bottom: 0,
                child: Center(
                  child: Text(
                    "?????????",
                    style: TextStyle(fontSize: 15.sp, color: HexColor(HexColor.HMD_333333)),
                    textAlign: TextAlign.left,
                  ),
                )
            ),
            Positioned(
                top: 0,
                bottom: 0,
                right: 50.w,
                child: Center(
                  child: Text(_userModel.mobile, style: TextStyle(fontSize: 15.sp, color: HexColor(HexColor.HMD_333333))),
                )
            )
          ],
        )
    );
  }

  //??????????????????
  Future _submitUserInfo() async {

    Map<String,dynamic> params = new Map();
    SharedPreferences shared = await SharedPreferences.getInstance();
    params["token"] = shared.getString("token");
    params["user_name"] = _userNameCtrl.text;

    FormData formData = FormData.fromMap({
      "avatar": await MultipartFile.fromFile(_imagePath, filename: "huomanduo.jpeg")
    });
   //params["picture"] = formData;

    final BaseModel baseModel = await HttpRequest().post(HttpUrl.editUser_URL, params: params, data: formData);
    ToastUtil.show(baseModel.msg);
    if (baseModel.status == 200) {
      AppEvent.event.fire(ReloadUserInfoEvent());
    }
  }
  
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  // http://oss-cn-zhangjiakou.aliyuncs.com/huomanduo-images/2022-04/2022-04-07/26aa80e4e21e48a2bfbea76a9bdd2873huomanduo.png1197706862557057781.png
}