

import 'package:flutter/material.dart';
import 'package:huomanduo_owner/common/base_app_bar.dart';
import 'package:huomanduo_owner/utils/screen_fit.dart';

class HomePage extends StatefulWidget {
  @override
  _MineState createState() => _MineState();
}

class _MineState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {

  @override
  void initState() {
    ScreenFit.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        titleStr: "首页",
        bgColor: Colors.amber,
        leading: Text(""),
      )
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}