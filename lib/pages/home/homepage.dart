

import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _MineState createState() => _MineState();
}

class _MineState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("首页"),
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