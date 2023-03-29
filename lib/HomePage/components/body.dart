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
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
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
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: 100,
                margin: const EdgeInsets.only(top: 50),
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [

                    SizedBox(
                        child: Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                          border: Border.all(color: const Color(0xfffecb02)),
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(100)),
                    )),
                    SizedBox(
                        child: Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                          border: Border.all(color: const Color(0xfffecb02)),
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(200)),
                    )),
                    SizedBox(
                        child: Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                          border: Border.all(color: const Color(0xfffecb02)),
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(200)),
                    )),
                    SizedBox(
                      child: Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                            border: Border.all(color: const Color(0xfffecb02)),
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(100)),
                      ),
                    ),
                    SizedBox(
                        child: Container(
                      height: 50,
                      width: 100,
                      decoration: BoxDecoration(
                          border: Border.all(color: const Color(0xfffecb02)),
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(100)),
                    )),
                    SizedBox(
                        child: Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                          border: Border.all(color: const Color(0xfffecb02)),
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(200)),
                    )),
                    SizedBox(
                        child: Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                          border: Border.all(color: const Color(0xfffecb02)),
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(200)),
                    )),
                    SizedBox(
                      child: Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                            border: Border.all(color: const Color(0xfffecb02)),
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(100)),
                      ),
                    ),
                  ],
                ),
              ),
              // Row(
              //   children: [
              //
              //
              //
              //   ],
              // ),
              // Row(children: [
              //   Align(
              //     child: Expanded(
              //       child: Align(
              //         alignment: Alignment.center,
              //         child: Container(
              //           color: Colors.red,
              //           height: 150,
              //           width: 100,
              //         ),
              //       ),
              //     ),
              //
              //       child: Expanded(
              //       child: Align(
              //         alignment: Alignment.center,
              //         child: Container(
              //           color: Colors.blue,
              //           height: 150,
              //           width: 100,
              //         ),
              //       ),
              //     ),
              //   )
              // ]),
              // Row(
              //   children: [
              //     Expanded(
              //       child: Align(
              //         alignment: Alignment.center,
              //         child: Container(
              //           color: Colors.red,
              //           height: 150,
              //           width: 100,
              //         ),
              //       ),
              //     ),
              //     SizedBox(width: 5),
              //     Expanded(
              //       child: Align(
              //         alignment: Alignment.center,
              //         child: Container(
              //           color: Colors.blue,
              //           height: 150,
              //           width: 100,
              //         ),
              //       ),
              //     ),
              //   ],
              // ),
              // Row(
              //   children: [
              //     Expanded(
              //       child: Container(
              //         color: Colors.black,
              //         height: 100,
              //         width: 50,
              //       ),
              //     ),
              //     Expanded(
              //       child: Container(
              //         color: Colors.white,
              //         height: 100,
              //         width: 50,
              //       ),
              //     ),
              //   ],
              // )
            ],
          ),
        ),
      ),
    );
  }
}
