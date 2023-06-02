import 'package:flutter/material.dart';

import '../../../progressbar.dart';
import '../../../provider/progressbar.dart';
import 'components/body.dart';
import 'package:provider/provider.dart';
class TimePlant extends StatefulWidget {
  static String routeName = '/timePlant';

  TimePlant({Key? key}) : super(key: key);

  @override
  State<TimePlant> createState() => _TimePlantState();
}

class _TimePlantState extends State<TimePlant> {
  @override
  Widget build(BuildContext context) {
    ProgressProvider progressProvider = Provider.of<ProgressProvider>(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          color: Colors.white,
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: const Color(0xff91CD00),
        centerTitle: true,
        title: const Text(
          "Khởi tạo quy trình",
          style: TextStyle(
              fontFamily: 'Inter-Medium-500.ttf',
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.w600),
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(8),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            tileMode: TileMode.clamp,
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFC1FD2D),
              Color(0xFFFFFFFF),
            ],
          ),
        ),
        child: Column(
          children:  [
            CustomProgressBar(),
            // Nội dung màn hình
            Body(),
          ],
        ),
      ),
    );
  }
}
