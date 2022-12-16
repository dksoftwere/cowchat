import 'package:cowchat/constants.dart';
import 'package:flutter/material.dart';

class ProgressHUD extends StatelessWidget {
   Widget? child;
   bool ?inAsyncCall;
   double ?opacity;
   Color? color;
  ProgressHUD({super.key,
    @required this.child,
    @required this.inAsyncCall,
    this.opacity = 0.3,
    this.color = Colors.grey,
  });
  @override
  Widget build(BuildContext context) {
    List<Widget> widgetList = <Widget>[];
    widgetList.add(child!);
    if (inAsyncCall!) {
      final modal = Stack(
        children: [
          Opacity(
            opacity: opacity!,
            child: ModalBarrier(dismissible: false, color: color),
          ),
          const Center(
              child: CircularProgressIndicator(color:CWPrimaryColor)
          ),
        ],
      );
      widgetList.add(modal);
    }
    return Stack(
      children: widgetList,
    );
  }
}