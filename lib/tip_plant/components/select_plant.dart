import 'package:flutter/material.dart';
import 'package:plant_process/model/plant_model.dart';
import 'package:plant_process/tip_plant/components/product_plant.dart';

class Select_plant extends StatefulWidget {
  Select_plant({Key? key}) : super(key: key);
  static String routeName = "/select";

  @override
  State<Select_plant> createState() => _Select_plantState();
}

class _Select_plantState extends State<Select_plant> {
  @override
  Widget build(BuildContext context) {
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
        title: const Text("Chọn giống"),
      ),
      body: Container(
        width: MediaQuery
            .of(context)
            .size
            .width,
        height: MediaQuery
            .of(context)
            .size
            .height,
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
        child: Container(
          width: MediaQuery
              .of(context)
              .size
              .width,
          child: Column(
            children: [
              Product_plant()
            ],
          ),
        ),
      ),
    );
  }
}