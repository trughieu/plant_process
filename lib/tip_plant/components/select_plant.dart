import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

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
          child: Column(
            children: [
              // Center(
              //   child: Container(
              //     child: const Text(
              //       "Chọn giống",
              //       style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
              //     ),
              //   ),
              // ),
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
                    Container(
                      height: 120,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [list_Plant_Select(context)],
                      ),
                    ),
                    const Divider(
                      color: Color(0xff006804),
                      height: 20,
                      thickness: 2,
                      indent: 10,
                      endIndent: 20,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 100,
                                    height: 100,
                                    decoration: BoxDecoration(
                                        border: Border.all(color: Colors.black),
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(50)),
                                        color: Colors.white),
                                    child: Image.asset("asset/images/corn.png"),
                                  )
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    child: const Text(
                                      "Ngô",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 100,
                                    height: 100,
                                    decoration: BoxDecoration(
                                        border: Border.all(color: Colors.black),
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(50)),
                                        color: Colors.white),
                                    child: Image.asset("asset/images/corn.png"),
                                  )
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Text(
                                    "Ngô",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Center(
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 100,
                                      height: 100,
                                      decoration: BoxDecoration(
                                          border:
                                              Border.all(color: Colors.black),
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(50)),
                                          color: Colors.white),
                                      child:
                                          Image.asset("asset/images/corn.png"),
                                    )
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Text(
                                      "Ngô",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),

                          // Column(
                          //   children: [
                          //     Row(
                          //       children: [
                          //         Container(
                          //           width: 70,
                          //           height: 70,
                          //           decoration: BoxDecoration(
                          //               border: Border.all(color: Colors.black),
                          //               borderRadius: BorderRadius.all(Radius.circular(50)),
                          //               color: Colors.white),
                          //           child: Image.asset("asset/images/corn.png"),
                          //         )
                          //       ],
                          //     ),
                          //     Row(
                          //       children: [
                          //         Container(
                          //           child: const Text(
                          //             "Ngô",
                          //             style:
                          //             TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                          //           ),
                          //         ),
                          //       ],
                          //     ),
                          //   ],
                          // ),
                        )
                      ],
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 20),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 100,
                                      height: 100,
                                      decoration: BoxDecoration(
                                          border:
                                              Border.all(color: Colors.black),
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(50)),
                                          color: Colors.white),
                                      child:
                                          Image.asset("asset/images/corn.png"),
                                    )
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      child: const Text(
                                        "Ngô",
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 100,
                                      height: 100,
                                      decoration: BoxDecoration(
                                          border:
                                              Border.all(color: Colors.black),
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(50)),
                                          color: Colors.white),
                                      child:
                                          Image.asset("asset/images/corn.png"),
                                    )
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Text(
                                      "Ngô",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Center(
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        width: 100,
                                        height: 100,
                                        decoration: BoxDecoration(
                                            border:
                                                Border.all(color: Colors.black),
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(50)),
                                            color: Colors.white),
                                        child: Image.asset(
                                            "asset/images/corn.png"),
                                      )
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      Text(
                                        "Ngô",
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),

                            // Column(
                            //   children: [
                            //     Row(
                            //       children: [
                            //         Container(
                            //           width: 70,
                            //           height: 70,
                            //           decoration: BoxDecoration(
                            //               border: Border.all(color: Colors.black),
                            //               borderRadius: BorderRadius.all(Radius.circular(50)),
                            //               color: Colors.white),
                            //           child: Image.asset("asset/images/corn.png"),
                            //         )
                            //       ],
                            //     ),
                            //     Row(
                            //       children: [
                            //         Container(
                            //           child: const Text(
                            //             "Ngô",
                            //             style:
                            //             TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                            //           ),
                            //         ),
                            //       ],
                            //     ),
                            //   ],
                            // ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 20),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 100,
                                      height: 100,
                                      decoration: BoxDecoration(
                                          border:
                                              Border.all(color: Colors.black),
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(50)),
                                          color: Colors.white),
                                      child:
                                          Image.asset("asset/images/corn.png"),
                                    )
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      child: const Text(
                                        "Ngô",
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 100,
                                      height: 100,
                                      decoration: BoxDecoration(
                                          border:
                                              Border.all(color: Colors.black),
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(50)),
                                          color: Colors.white),
                                      child:
                                          Image.asset("asset/images/corn.png"),
                                    )
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Text(
                                      "Ngô",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Center(
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        width: 100,
                                        height: 100,
                                        decoration: BoxDecoration(
                                            border:
                                                Border.all(color: Colors.black),
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(50)),
                                            color: Colors.white),
                                        child: Image.asset(
                                            "asset/images/corn.png"),
                                      )
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      Text(
                                        "Ngô",
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),

                            // Column(
                            //   children: [
                            //     Row(
                            //       children: [
                            //         Container(
                            //           width: 70,
                            //           height: 70,
                            //           decoration: BoxDecoration(
                            //               border: Border.all(color: Colors.black),
                            //               borderRadius: BorderRadius.all(Radius.circular(50)),
                            //               color: Colors.white),
                            //           child: Image.asset("asset/images/corn.png"),
                            //         )
                            //       ],
                            //     ),
                            //     Row(
                            //       children: [
                            //         Container(
                            //           child: const Text(
                            //             "Ngô",
                            //             style:
                            //             TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                            //           ),
                            //         ),
                            //       ],
                            //     ),
                            //   ],
                            // ),
                          )
                        ],
                      ),
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

  Widget list_Plant_Select(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 20, top: 20),
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.only(right: 20),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(50)),
                          color: Colors.white),
                      child: Image.asset("asset/images/corn.png"),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      "Ngô",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(right: 20),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(50)),
                          color: Colors.white),
                      child: Image.asset("asset/images/corn.png"),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      "Ngô",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(right: 20),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          borderRadius:
                          const BorderRadius.all(Radius.circular(50)),
                          color: Colors.white),
                      child: Image.asset("asset/images/corn.png"),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      "Ngô",
                      style:
                      TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(right: 20),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          borderRadius:
                          const BorderRadius.all(Radius.circular(50)),
                          color: Colors.white),
                      child: Image.asset("asset/images/corn.png"),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      "Ngô",
                      style:
                      TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(right: 20),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          borderRadius:
                          const BorderRadius.all(Radius.circular(50)),
                          color: Colors.white),
                      child: Image.asset("asset/images/corn.png"),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      "Ngô",
                      style:
                      TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(right: 20),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          borderRadius:
                          const BorderRadius.all(Radius.circular(50)),
                          color: Colors.white),
                      child: Image.asset("asset/images/corn.png"),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      "Ngô",
                      style:
                      TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(right: 20),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          borderRadius:
                          const BorderRadius.all(Radius.circular(50)),
                          color: Colors.white),
                      child: Image.asset("asset/images/corn.png"),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      "Ngô",
                      style:
                      TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(right: 20),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          borderRadius:
                          const BorderRadius.all(Radius.circular(50)),
                          color: Colors.white),
                      child: Image.asset("asset/images/corn.png"),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      "Ngô",
                      style:
                      TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
