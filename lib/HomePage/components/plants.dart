import 'package:flutter/material.dart';

class Plant extends StatelessWidget {
  const Plant({Key? key}) : super(key: key);
  static String routeName = "/plants";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          child: Container(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  Row(
                    children: [
                      SizedBox(
                        child: ClipOval(
                          child: SizedBox(
                            height: 100,
                            width: 100,
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.yellow
                                  // Color(0xfffecb02))
                                  ,
                                  //   color: Colors.white,
                                  width: 2.5,
                                  // borderRadius: BorderRadius.circular(100)),
                                ),
                                shape: BoxShape.circle,
                              ),
                              child: ClipOval(
                                child: SizedBox(
                                  height: 100,
                                  child: Container(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(left: 20),
                        height: 50,
                        child: const Center(
                          child: Text(
                            "Cây Ngô",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 30,
                                decoration: TextDecoration.none),
                          ),
                        ),
                      ),

                      //     child: Text(
                      //   "Cây ngô",
                      //   style: TextStyle(fontSize: 12),
                      // ))
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 20),
                    child: const Text(
                      "Ngô (Zea mays L.) là cây nông nghiệp một lá mầm thuộc chi Zea, họ hòa thảo (Poaceae hay còn gọi là Gramineae)",
                      style: TextStyle(
                        color: Colors.black,
                        decoration: TextDecoration.none,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  Container(
                    padding:  EdgeInsets.only(top: 20),
                    height: 100,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      color: Colors.white
                    ),

                  ),
                  Container(
                    padding:  EdgeInsets.only(top: 20),
                    height: 100,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        color: Colors.black
                    ),

                  ),
                ],
              )),

      ),
    );
  }
}
