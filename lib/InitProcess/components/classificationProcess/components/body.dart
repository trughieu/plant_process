import 'package:flutter/material.dart';
import 'package:plant_process/InitProcess/components/classificationProcess/tabLayout_classification.dart';

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
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
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
          SizedBox(
            height: 40,
          ),
          Center(
            child: Text("KHỞI TẠO QUI TRÌNH", style: TextStyle(
              fontFamily: 'Inter-Bold-700.ttf',
              color: Colors.black,
              fontWeight: FontWeight.w900,
              fontSize: 30,
            ),),
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
          Padding(
              padding: EdgeInsets.only(left: 30),
              child: Column(
                children: [
                  RadioListTile<Classification>(
                      title: const Text('Ngắn ngày'),
                      value: Classification.nganngay,
                      groupValue: _classification,
                      onChanged: (Classification? value){
                        setState(() {
                          _classification = value;
                        });
                      }),

                  RadioListTile(
                      title: const Text('Trung ngày'),
                      value: Classification.trungngay,
                      groupValue: _classification,
                      onChanged: (Classification? value){
                        setState(() {
                          _classification = value;
                        });
                      }),
                  RadioListTile(
                      title: const Text('Dài ngày'),
                      value: Classification.daingay,
                      groupValue: _classification,
                      onChanged: (Classification? value){
                        setState(() {
                          _classification = value;
                        });
                      }),
                ],
              )
          ),
          TabLayoutClassification()
        ],
      ),
    );
  }

}
