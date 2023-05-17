

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
        var phanBon = p['chamSoc']['phanBon'];
        if (idplant == myProvider.id) {
          if (phanBon is List) {
            for (var pb in phanBon) {
              var ngaytuoi = pb['ngayTuoi'];
              var thoigian = pb['thoiGianTuoi'];
              var huongDan = pb['huongDan'];
              print(thoigian);
              print(ngaytuoi);
              print(huongDan);

              var tuoinuoc =
              TuoiNuoc(huongDan: huongDan, thoiGianTuoi: thoigian, ngayTuoi: ngaytuoi);
              setState(() {
                tuoinuoclist.add(tuoinuoc);
              });
            }
          }
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
    return const Placeholder();
  }
}
