import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:plant_process/model/mission.dart';

import '../../../model/plant_provider.dart';
import '../../../model/thuyloi.dart';
import '../../../model/utilities.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class thuyLoi extends StatefulWidget {
  final Mission mission;

  const thuyLoi({Key? key, required this.mission}) : super(key: key);

  @override
  State<thuyLoi> createState() => _thuyLoiState();
}

class _thuyLoiState extends State<thuyLoi> {
  String url = Utilities.url;
  List<TuoiNuoc> tuoinuoclist = [];

  void getPhanbon() async {
    PlantProvider myProvider =
        Provider.of<PlantProvider>(context, listen: false);

    final response = await http.get(Uri.parse('$url/api/process'));
    if (response.statusCode == 200) {
      final process = jsonDecode(response.body);
      var pro = process['process'];
      for (var p in pro) {
        var idplant = p['id_plant'];
        var phanBon = p['chamSoc']['tuoiNuoc'];
        if (idplant == myProvider.id) {
          var ngaytuoi = phanBon['ngayTuoi'];
          var thoigian = phanBon['thoiGianTuoi'];
          var huongDan = phanBon['huongDan'];
          print("1212$thoigian");
          print("111$ngaytuoi");
          print("222$huongDan");

          var tuoinuoc = TuoiNuoc(
              huongDan: huongDan, thoiGianTuoi: thoigian, ngayTuoi: ngaytuoi);
          setState(() {
            tuoinuoclist.add(tuoinuoc);
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
    getPhanbon();
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
        child: ListView.builder(
          itemCount: tuoinuoclist.length,
          itemBuilder: (context, index) {
            var tuoinuoc = tuoinuoclist[index];
            return Container(
              margin: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Ngày tưới: ${tuoinuoc.ngayTuoi}',
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    'Thời gian tưới: ${tuoinuoc.thoiGianTuoi}',
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    'Hướng dẫn: ${tuoinuoc.huongDan}',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
