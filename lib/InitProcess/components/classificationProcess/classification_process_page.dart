import 'package:flutter/material.dart';
import 'package:plant_process/InitProcess/components/classificationProcess/components/body.dart';

class ClassificationProcesssPage extends StatelessWidget {
  static String routeName ='/classificationProcess';

  const ClassificationProcesssPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          color: Colors.white,
          icon: Icon(Icons.arrow_back_ios),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
        backgroundColor: Color(0xff91CD00),
        centerTitle: true,
        title: Text("Khởi tạo qui trình", style: TextStyle(
          fontFamily: 'Inter-Medium-500.ttf',
          color: Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.w600
        ),),
      ),
        body: Body(),


    );
  }

}