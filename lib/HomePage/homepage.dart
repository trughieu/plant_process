import 'package:flutter/material.dart';
import 'package:plant_process/HomePage/components/body.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  static String routeName = "/homepage";

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Body(),
        footerScreen(context)
      ],
    );

  }

//
  Widget footerScreen(BuildContext context) {
    return Container(
      // width: 1,
      // alignment: Alignment.bottomLeft,
      // child: Image.asset("asset/images/tree.png"),
    );
  }
}
