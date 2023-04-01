import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Follow_mission extends StatelessWidget {
  static String routeName = "/mission";

  const Follow_mission({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        title: Text("Cây ngô"),

        // leading: IconButton(
        //   onPressed: () {},
        //   icon: const Icon(Icons.arrow_back_ios),
        // ),
        // title: Center(
        //   child: Row(
        //     children: [
        //       Container(
        //         margin: EdgeInsets.only(right: 20),
        //         child: Image.asset("asset/images/corn.png"),
        //       ),
        //       Text("Âsss")
        //     ],
        //   ),
        // ),
        // flexibleSpace: Container(
        //   child: Text("Cây ngô",
        //     style: TextStyle(
        //       fontWeight: FontWeight.bold,
        //       fontSize: 20
        //     ),
        //   ),
        // ),

        // leading: IconButton(
        //   color: Colors.white,
        //   icon: const Icon(Icons.arrow_back_ios),
        //   onPressed: () {
        //     Navigator.pop(context);
        //   },
        // ),
        // flexibleSpace: Container(
        //   decoration: BoxDecoration(
        //     image: DecorationImage(
        //       image: AssetImage("asset/images/corn.png")
        //     )
        //   ),
        // ),

        backgroundColor: const Color(0xff91CD00),
      ),
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
        child: Column(
          children: [
            Container(
              color: Color(0x80FFFFFF),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                Container(
                  margin: EdgeInsets.only(left: 40, right: 40),
                  child: Image.asset("asset/images/corn.png"),
                ),
                // const Center(
                //   child: Text(
                //     "Cây ngô",
                //     style: TextStyle(
                //       color: Colors.black,
                //       fontSize: 30,
                //       fontWeight: FontWeight.bold,
                //     ),
                //   ),
                // ),
                // Expanded(
                //   child: SvgPicture.asset("asset/icon/edit.svg"),
                // ),
              ]),
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(top: 5),
                    margin: const EdgeInsets.all(20),
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.black),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(15))),
                    child: Center(
                      child: Column(
                        children: [
                          Image.asset("asset/images/tree_mission.png"),
                          Text("Chọn giống")
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(top: 5),
                    margin: const EdgeInsets.all(20),
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                    child: Center(
                      child: Column(
                        children: [
                          Image.asset("asset/images/tree_mission.png"),
                          Text("Chọn giống")
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(top: 5),
                    margin: const EdgeInsets.all(20),
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.black),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(15))),
                    child: Center(
                      child: Column(
                        children: [
                          Image.asset("asset/images/tree_mission.png"),
                          Text("Chọn giống")
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(top: 5),
                    margin: const EdgeInsets.all(20),
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                    child: Center(
                      child: Column(
                        children: [
                          Image.asset("asset/images/tree_mission.png"),
                          Text("Chọn giống")
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(top: 5),
                    margin: const EdgeInsets.all(20),
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.black),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(15))),
                    child: Center(
                      child: Column(
                        children: [
                          Image.asset("asset/images/tree_mission.png"),
                          Text("Chọn giống")
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(top: 5),
                    margin: const EdgeInsets.all(20),
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                    child: Center(
                      child: Column(
                        children: [
                          Image.asset("asset/images/tree_mission.png"),
                          Text("Chọn giống")
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(top: 5),
                    margin: const EdgeInsets.all(20),
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.black),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(15))),
                    child: Center(
                      child: Column(
                        children: [
                          Image.asset("asset/images/tree_mission.png"),
                          Text("Chọn giống")
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(top: 5),
                    margin: const EdgeInsets.all(20),
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                    child: Center(
                      child: Column(
                        children: [
                          Image.asset("asset/images/tree_mission.png"),
                          Text("Chọn giống")
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
