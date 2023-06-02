import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:plant_process/model/thuhoach.dart';
import 'package:plant_process/model/utilities.dart';

import '../../../model/mission.dart';
import '../../../model/plant_provider.dart';

import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class ThuHoach extends StatefulWidget {
  final Mission mission;

  const ThuHoach({Key? key, required this.mission}) : super(key: key);

  @override
  State<ThuHoach> createState() => _ThuHoachState();
}

class _ThuHoachState extends State<ThuHoach> {
  String url = Utilities.url;
  List<thuHoach> thuhoachList = [];

  void getThuhoach() async {
    PlantProvider myProvider =
        Provider.of<PlantProvider>(context, listen: false);
    final response = await http.get(Uri.parse('$url/api/process'));
    if (response.statusCode == 200) {
      final process = jsonDecode(response.body);
      var pro = process['process'];
      for (var p in pro) {
        var idplant = p['id_plant'];
        var phanBon = p['chamSoc']['thuHoach'];
        if (idplant == myProvider.id) {
          var thoigianTH = phanBon['thoiGianTH'];
          var baoQuan = phanBon['baoQuan'];
          var noiDung = phanBon['noiDung'];
          print(thoigianTH);

          print(baoQuan);
          print(noiDung);
          var tuoinuoc = thuHoach(
              baoQuan: baoQuan, noiDung: noiDung, thoigianTH: thoigianTH);
          setState(() {
            thuhoachList.add(tuoinuoc);
          });

          break;
        }
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getThuhoach();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.mission.title),
        leading: IconButton(
          color: Colors.white,
          icon: Icon(Icons.arrow_back),
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
            Container(
              margin: EdgeInsets.only(top: 20),
              width: MediaQuery.of(context).size.width,
              height: 100,
              child: SizedBox(
                child: widget.mission.img,
              ),
            ),
            if (thuhoachList.isNotEmpty)
              Container(
                margin: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 16),
                    RichText(
                      text: TextSpan(
                        style: TextStyle(fontSize: 16, color: Colors.black),
                        children: [
                          TextSpan(
                            text: 'Thời gian thu hoạch: ',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(text: '${thuhoachList[0].thoigianTH}'),
                        ],
                      ),
                    ),
                    RichText(
                      text: TextSpan(
                        style: TextStyle(fontSize: 16, color: Colors.black),
                        children: [
                          TextSpan(
                            text: 'Nội dung: ',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(text: '${thuhoachList[0].noiDung}'),
                        ],
                      ),
                    ),
                    RichText(
                      text: TextSpan(
                        style: TextStyle(fontSize: 16, color: Colors.black),
                        children: [
                          TextSpan(
                            text: 'Bảo quản: ',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(text: '${thuhoachList[0].baoQuan}'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
