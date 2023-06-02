import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:plant_process/InitProcess/components/time/components/edit/gieotrong.dart';
import 'package:plant_process/InitProcess/components/time/components/edit/editktt.dart';
import 'package:plant_process/InitProcess/components/time/components/edit/thuhoach.dart';
import 'package:plant_process/model/mission.dart';
import 'package:plant_process/model/utilities.dart';
import 'package:http/http.dart' as http;

import 'manageKTT.dart';


class editMission extends StatefulWidget {
  static String routeName='/editMission';
  const editMission({Key? key}) : super(key: key);

  @override
  State<editMission> createState() => _editMissionState();
}

class _editMissionState extends State<editMission> {
  String url = Utilities.url;
  List<Mission> mission = [];

  void getMission() async {
    final response = await http.get(Uri.parse('$url/api/mission'));
    if (response.statusCode == 200) {
      print(response.body);
      final body = jsonDecode(response.body);
      print("body$body");
      var mis = body['mission'];
      print("asas$mis");
      for (var p in mis) {
        setState(() {
          mission.add(Mission.fromJson(p as Map<String, dynamic>));
        });
        for (int i = 0; i < mission.length; i++) {
          mission[i].img = Image.network('$url/imgMission/${mission[i].image}');
        }
      }
    }
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getMission();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quản lý quy trình'),
        leading: IconButton(
          color: Colors.white,
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: const Color(0xff91CD00),
        centerTitle: true,
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
        child: Column(
          children: [
            Expanded(
                child: SingleChildScrollView(
                  child: GridView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      primary: false,
                      itemCount: mission.length,
                      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 300,
                          // Chiều rộng tối đa của mỗi mục
                          crossAxisSpacing: 20,
                          mainAxisSpacing: 20,
                          mainAxisExtent: 150),
                      itemBuilder: (context, index) {
                        return ProductItem(
                            mission: mission[index],
                            onTap: () {
                              if (mission[index].type == 'THU_HOACH') {
                                Navigator.pushNamed(context, editThuhoach.routeName);
                              }
                              else if (mission[index].type == 'GIEO_TRONG') {
                                Navigator.pushNamed(context, editGieoTrong.routeName);
                              }  else if (mission[index].type == 'KY_THUAT') {
                                Navigator.pushNamed(context, ManageKTT.routeName);
                              }
                            });
                      }),
                ))
          ],
        ),
      ),
    );
  }
}

class ProductItem extends StatelessWidget {
  final Mission mission;
  final VoidCallback onTap;

  ProductItem({Key? key, required this.mission, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: Colors.black)),
            child: Column(
              children: [
                Container(
                  child: SizedBox(
                    width: 150,
                    height: 70,
                    child: mission.image == null
                        ? const CircularProgressIndicator()
                        : mission.img!,
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  width: 100,
                  height: 50,
                  child: Text(
                    mission.title,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

