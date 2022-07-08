
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../gen_a/A.dart';

class InputDoneView extends StatelessWidget {

  late OverlayEntry overlayEntry;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.grey[300],
      child: Align(
        alignment: Alignment.topRight,
        child: Padding(
          padding: const EdgeInsets.all(0),
          child: CupertinoButton(
            padding: EdgeInsets.only(right: 0, top: 0, bottom: 0),
            onPressed: () {
              FocusScope.of(context).requestFocus(new FocusNode());
            },
            child: Image.asset(A.assets_images_hide_keyboard, fit: BoxFit.cover,),
            // Text("Done",
            //     style: TextStyle(
            //         color: Colors.blueAccent, fontWeight: FontWeight.bold)
            // ),
          ),
        ),
      ),
    );
  }

  void showOverlay(BuildContext context) {
    //if (overlayEntry != null) return;
    OverlayState? overlayState = Overlay.of(context);
    overlayEntry = OverlayEntry(builder: (context) {
      return Positioned(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          right: 0.0,
          //left: 0.0,
          width: 40,
          height: 30,
          child: InputDoneView());
    });

    overlayState?.insert(overlayEntry);
  }

  void removeOverlay() {
    if (overlayEntry != null) {
      overlayEntry.remove();
      //overlayEntry = null;
    }
  }
}
