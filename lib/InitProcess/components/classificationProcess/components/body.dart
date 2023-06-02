import 'package:flutter/material.dart';
import 'package:plant_process/InitProcess/components/classificationProcess/tabLayout_classification.dart';
import '../../../../progressbar.dart';
import '../../../../provider/progressbar.dart';
import 'package:provider/provider.dart';

class Body extends StatefulWidget{
  const Body({Key? key}) : super(key: key);

  @override
  BodyState createState() => BodyState();
}
enum Classification { nganngay, trungngay, daingay}

class BodyState extends State<Body>{

  Classification? _classification = Classification.nganngay;

  @override
  Widget build(BuildContext context) {
    ProgressProvider progressProvider = Provider.of<ProgressProvider>(context);

    return Container(

      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(8),
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
      child: ListView(
        shrinkWrap: true,
        children: [
          CustomProgressBar(), // Giá trị progress từ 0.0 đến 1.0
          // Nội dung màn hình
          SizedBox(
            height: 40,
          ),

          SizedBox(height: 30,),
          Padding(
            padding: EdgeInsets.only(left: 30),
            child: Text("Phân loại cây trồng:", style: TextStyle(
            fontSize: 20,
            fontFamily: 'Inter-SemiBold-600.ttf',
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),),
          ),
          SizedBox(height: 20,),
        ],
      ),
    );
  }

}
