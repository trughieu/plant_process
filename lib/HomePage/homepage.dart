import 'package:flutter/material.dart';
import 'package:plant_process/HomePage/components/body.dart';
import 'package:plant_process/HomePage/components/info.dart';
import 'package:plant_process/tip_plant/components/select_plant.dart';

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
              children: [
                const Info(),
                const Body(),
                const SizedBox(
                  height: 157,
                ),
                // Align(
                //   alignment: Alignment.bottomCenter,
                //   child: Column(
                //     children: [Menubottom(context)],
                //   ),
                // ),
                Menubottom(context)
              ],
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
              child: const Text(
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
                Navigator.pushNamed(context, Select_plant.routeName);
              },
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
              child: const Icon(Icons.add),
            ),
          ),

          // SizedBox(
          //     width: 100,
          //     height: 70,
          //     child: Expanded(
          //       child: FloatingActionButton(
          //         onPressed: () {},
          //         child: const Icon(Icons.add),
          //         foregroundColor: Colors.black,
          //         backgroundColor: Colors.white,
          //       ),
          //     )),
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

    //   Container(
    //   height: 100.0,
    //   width: MediaQuery.of(context).size.width,
    //   alignment: Alignment.bottomCenter,
    //   decoration: const BoxDecoration(
    //       borderRadius: BorderRadius.only(
    //           topLeft: Radius.circular(15), topRight: Radius.circular(15)),
    //       gradient: LinearGradient(
    //         begin: Alignment.topCenter,
    //         end: Alignment.bottomCenter,
    //         colors: [Color(0xff91CD00), Color(0xff005200)],
    //       )),
    //   child: Row(
    //     children: [Container()],
    //   ),
    // );
  }
}
