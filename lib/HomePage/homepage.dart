import 'package:flutter/material.dart';
import 'package:plant_process/HomePage/components/body.dart';
import 'package:plant_process/HomePage/components/info.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  static String routeName = "/homepage";
  var selectIndex = 0;
  var flag = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // body: SafeArea(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFC1FD2D),
              Color(0xFFFFFFFF),
            ],
          ),
        ),
        child: Stack(
          children: [
            footerScreen(context),
            Column(
              children: [Info(), Body(), Menubottom(context)],
            ),
          ],
        ),
      ),
    );
  }

//
  Widget footerScreen(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      alignment: Alignment.bottomLeft,
      child: Image.asset("asset/images/tree.png"),
    );
  }

  Widget Menubottom(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15), topRight: Radius.circular(15)),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xff91CD00), Color(0xff005200)],
          )),
      child: Row(
        children: [Container()],
      ),
    );
  }
}
