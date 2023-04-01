import 'package:flutter/material.dart';

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
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
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
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.only(top: 40),
          child: Column(
            children: [
              Center(
                child: Container(
                  child: Text(
                    "Chọn giống",
                    style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 10, top: 20),
                child: Column(
                  children: [
                    Row(
                      children: const [
                        Text(
                          "Giống được chọn",
                          style: TextStyle(fontSize: 20),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 20, left: 20),
                          width: 70,
                          height: 70,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50)),
                              color: Colors.white),
                          child: Image.asset("asset/images/corn.png"),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 20, left: 35),
                          child: const Text(
                            "Ngô",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 20, left: 20),
                          width: 70,
                          height: 70,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50)),
                              color: Colors.white),
                          child: Image.asset("asset/images/corn.png"),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 20, left: 35),
                          child: const Text(
                            "Ngô",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
