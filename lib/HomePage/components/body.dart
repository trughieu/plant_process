import 'package:flutter/material.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFFC1FD2D),
                Color(0xFFFFFFFF),
              ],
            ),
          ),
          child: Stack(
            children: [
              Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 70,
                    margin: const EdgeInsets.only(top: 50),
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        SizedBox(
                            child: Container(
                          height: 70,
                          width: 70,
                          decoration: BoxDecoration(
                              border:
                                  Border.all(color: const Color(0xfffecb02)),
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(100)),
                        )),
                        SizedBox(
                            child: Container(
                          height: 70,
                          width: 70,
                          decoration: BoxDecoration(
                              border:
                                  Border.all(color: const Color(0xfffecb02)),
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(200)),
                        )),
                        SizedBox(
                            child: Container(
                          height: 70,
                          width: 70,
                          decoration: BoxDecoration(
                              border:
                                  Border.all(color: const Color(0xfffecb02)),
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(200)),
                        )),
                        SizedBox(
                          child: Container(
                            height: 70,
                            width: 70,
                            decoration: BoxDecoration(
                                border:
                                    Border.all(color: const Color(0xfffecb02)),
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(100)),
                          ),
                        ),
                        SizedBox(
                            child: Container(
                          height: 70,
                          width: 70,
                          decoration: BoxDecoration(
                              border:
                                  Border.all(color: const Color(0xfffecb02)),
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(100)),
                        )),
                        SizedBox(
                            child: Container(
                          height: 70,
                          width: 70,
                          decoration: BoxDecoration(
                              border:
                                  Border.all(color: const Color(0xfffecb02)),
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(200)),
                        )),
                        SizedBox(
                            child: Container(
                          height: 70,
                          width: 70,
                          decoration: BoxDecoration(
                              border:
                                  Border.all(color: const Color(0xfffecb02)),
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(200)),
                        )),
                        SizedBox(
                          child: Container(
                            height: 70,
                            width: 70,
                            decoration: BoxDecoration(
                                border:
                                    Border.all(color: const Color(0xfffecb02)),
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(100)),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 180,
                                width: 150,
                                child: Container(
                                  margin: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black),
                                      borderRadius: BorderRadius.circular(20),
                                      color: Colors.white),
                                  child: const Center(
                                    child: Text(
                                      'Chọn Giống',
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.black),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 180,
                                width: 150,
                                child: Container(
                                  margin: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black),
                                      borderRadius: BorderRadius.circular(20),
                                      color: Colors.white),
                                  child: const Center(
                                    child: Text(
                                      'Thông tin\nphân bón',
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.black),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 180,
                              width: 150,
                              child: Container(
                                margin: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black),
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.white),
                                child: const Center(
                                  child: Text(
                                    'Thời tiết',
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.black),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 180,
                              width: 150,
                              child: Container(
                                margin: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black),
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.white,
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),

        ),
      ),
    );
  }
}
//

