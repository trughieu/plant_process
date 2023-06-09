import 'package:flutter/material.dart';
import 'package:plant_process/tip_plant/components/follow_mission.dart';
import 'package:plant_process/tip_plant/components/select_plant.dart';

class Plant extends StatelessWidget {
  const Plant({Key? key}) : super(key: key);
  static String routeName = "/plants";

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
        child: Container(
          margin: EdgeInsets.all(20),
          child: Stack(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                alignment: Alignment.bottomLeft,
                child: Image.asset("asset/images/farmer.png"),
              ),
              Column(
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
                                    child: Image.asset("asset/images/corn.png"),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 20),
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
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 20),
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
                    height: 100,
                    margin: EdgeInsets.only(top: 20),
                    decoration: BoxDecoration(
                        border: Border.all(color: Color(0xfffecb02)),
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        color: Colors.white),
                    child: GestureDetector(
                      onTap: (){
                        Navigator.pushNamed(context, Follow_mission.routeName);
                      },
                      child: const Center(
                        child: Text(
                          "Theo Nhiệm Vụ",
                          style: TextStyle(
                              color: Color(0xff116000), fontSize: 30),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    height: 100,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        border: Border.all(color: Color(0xfffecb02)),
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        color: Colors.white),
                    child: const Center(
                      child: Text(
                        "Theo Giai Đoạn",
                        style:
                            TextStyle(color: Color(0xff116000), fontSize: 30),
                      ),
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
