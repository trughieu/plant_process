import 'dart:convert';

import 'package:flutter/material.dart';

import '../../../model/gieotrong.dart';
import '../../../model/mission.dart';
import '../../../model/plant_provider.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import '../../../model/utilities.dart';

class ChonGiong extends StatefulWidget {
  final Mission mission;

  ChonGiong({Key? key, required this.mission}) : super(key: key);

  @override
  State<ChonGiong> createState() => _ChonGiongState();
}

class _ChonGiongState extends State<ChonGiong> {
  String url = Utilities.url;
  List<GieoTrong> gieoTrongList = [];
  List<String> chonGiongdata = [];

  void getGieoTrong() async {
    PlantProvider myProvider =
    Provider.of<PlantProvider>(context, listen: false);
    final response = await http.get(Uri.parse('$url/api/process'));
    if (response.statusCode == 200) {
      final process = jsonDecode(response.body);
      var pro = process['process'];
      for (var p in pro) {
        var idplant = p['id_plant'];
        var gieotrongData = p['cachTrong']['gieoTrong'];
        if (idplant == myProvider.id) {
          var chonGiong = p['cachTrong']['chonGiong'];
          print(chonGiong);
          var ngoaiCanh = gieotrongData['ngoaiCanh'];
          var mota = ngoaiCanh['moTa'];
          var huongDan = gieotrongData['thoiVu'];

          var gieoTrongObj = GieoTrong(
            ngoaiCanh: NgoaiCanh(
              nhietdo: ngoaiCanh['nhietDo'],
              anhSang: ngoaiCanh['anhSang'],
              nuoc: ngoaiCanh['nuoc'],
              doAm: ngoaiCanh['doAm'],
              chatLuongKK: ngoaiCanh['chatLuongKK'],
              moTaThem: ngoaiCanh['moTaThem'],
            ),
            thoiVu: huongDan,
          );
          setState(() {
            gieoTrongList.add(gieoTrongObj);
            chonGiongdata = [chonGiong];
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
    getGieoTrong();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.mission.title),
          leading: IconButton(
            color: Colors.white,
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          backgroundColor: const Color(0xff91CD00),
          centerTitle: true,
        ),
        body: Container(
            width: MediaQuery
                .of(context)
                .size
                .width,
            height: MediaQuery
                .of(context)
                .size
                .height,
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
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Thông tin Gieo Trồng',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    chonGiongdata.isNotEmpty ? chonGiongdata[0] : '',

                  )
                ],
              ),
            )));
  }
}
