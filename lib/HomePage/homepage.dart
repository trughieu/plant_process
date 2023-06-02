import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:plant_process/HomePage/components/body.dart';
import 'package:plant_process/HomePage/components/info.dart';
import 'package:plant_process/tip_plant/components/select_plant.dart';

import '../tip_plant/components/manage.dart';

class HomePage extends StatefulWidget {
  static String routeName = "/homepage";
  HomePage({Key? key}) : super(key: key);
  var selectIndex = 0;
  var flag = true;
  @override
  State<HomePage> createState() => _HomePageState();
}



class _HomePageState extends State<HomePage> {

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
            Container(
              child: footerScreen(context),
            ),
            Column(
              children: const [Info(), Body()],
            ),
            Container(
              alignment: Alignment.bottomCenter,
              child: Menu_bottom(context),
            )
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

  Widget Menu_bottom(BuildContext context) {
    return Container(
      height: 80,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15), topRight: Radius.circular(15)),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xff91CD00), Color(0xff005200)],
          )),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(top: 10),
              height: 50,
              child:  Text(
                "CÂY TRỒNG",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: FloatingActionButton(
              onPressed: () {
                Navigator.pushNamed(context, ItemListWidget.routeName);
              },
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
              child: const Icon(Icons.add),
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(top: 10),
              height: 50,
              child: const Text(
                "LỊCH",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          // Container()
        ],
      ),
    );
  }
}
