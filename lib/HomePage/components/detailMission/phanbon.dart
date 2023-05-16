import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:plant_process/HomePage/components/body.dart';
import 'package:plant_process/model/mission.dart';
import 'package:plant_process/model/phanbon.dart';
import 'package:plant_process/model/plant_provider.dart';
import 'package:plant_process/model/utilities.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class PhanBonDetail extends StatefulWidget {
  final Mission mission;

  const PhanBonDetail({Key? key, required this.mission}) : super(key: key);

  @override
  State<PhanBonDetail> createState() => _PhanBonDetailState();
}

class _PhanBonDetailState extends State<PhanBonDetail> {
  String url = Utilities.url;
  List<PhanBon> danhSachPhanBon = [];

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
          for (var pb in phanBon) {
            var tenLoaiPhan = pb['tenLoaiPhan'];
            var mota = pb['moTa'];
            var huongDan = pb['huongDan'];
            print(tenLoaiPhan);
            print(mota);
            print(huongDan);

            var phanBonObj = PhanBon(
              tenLoaiPhan: tenLoaiPhan,
              moTa: mota,
              img_PB: '',
              huongDan: huongDan,
            );
            danhSachPhanBon.add(phanBonObj);
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
                    )),
                Expanded(
                  child: ListView.builder(
                    itemCount: danhSachPhanBon.length,
                    itemBuilder: (context, index) {
                      var phanBon = danhSachPhanBon[index];
                      return ListTile(
                        title: Text(phanBon.tenLoaiPhan),
                        subtitle: Text(phanBon.moTa),
                        onTap: () {
                          // Xử lý sự kiện khi người dùng chọn một đối tượng PhanBon
                          print('Đã chọn đối tượng: ${phanBon.tenLoaiPhan}');
                          print('Hướng dẫn: ${phanBon.huongDan}');
                        },
                      );
                    },
                  ),
                ),
              ],
            )));
  }
}
