import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:plant_process/model/saubenh.dart';

import '../../../model/mission.dart';
import '../../../model/plant_provider.dart';
import '../../../model/utilities.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class phongSauBenh extends StatefulWidget {
  final Mission mission;

  const phongSauBenh({Key? key, required this.mission}) : super(key: key);

  @override
  State<phongSauBenh> createState() => _phongSauBenhState();
}

class _phongSauBenhState extends State<phongSauBenh> {
  String url = Utilities.url;
  List<sauBenh> saubenhList = [];

  void getPSB() async {
    PlantProvider myProvider =
        Provider.of<PlantProvider>(context, listen: false);

    final response = await http.get(Uri.parse('$url/api/process'));
    if (response.statusCode == 200) {
      final process = jsonDecode(response.body);
      var pro = process['process'];
      for (var p in pro) {
        var idplant = p['id_plant'];
        var saubenh = p['chamSoc']['phongSauBenh'];
        if (idplant == myProvider.id) {
          for (var pb in saubenh) {
            var cachPhongTru = pb['cachPhongTru'];
            var mota = pb['moTa'];
            var tenloaiSB = pb['tenLoaiSB'];
            var phanBonObj = sauBenh(
                cachPhongTru: cachPhongTru,
                mota: mota,
                tenloaiSB: tenloaiSB,
                id: '');
            setState(() {
              saubenhList.add(phanBonObj);
            });
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
    getPSB();
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
            child: Column(children: [
              Container(
                  margin: EdgeInsets.only(top: 20),
                  width: MediaQuery.of(context).size.width,
                  height: 100,
                  child: SizedBox(
                    child: widget.mission.img,
                  )),
              Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(16.0),
                    child: ListView.builder(
                  itemCount: saubenhList.length,
                  itemBuilder: (context, index) {
                    var phanBon = saubenhList[index];
                    return ListTile(
                      contentPadding: EdgeInsets.all(0),
                      title: RichText(
                        text: TextSpan(
                          style: DefaultTextStyle.of(context).style,
                          children: [
                            TextSpan(
                              text: phanBon.tenloaiSB,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.black,
                              ),
                            ),
                            const TextSpan(text: '  '),
                          ],
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 10),
                          Text(
                            phanBon.mota,
                            style: TextStyle(fontSize: 16, color: Colors.black),
                          ),
                          SizedBox(height: 5),
                          RichText(
                            text: TextSpan(
                              text: 'Hướng dẫn: ',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                              children: [
                                TextSpan(
                                  text: phanBon.cachPhongTru,
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      onTap: () {
                        // Xử lý sự kiện khi người dùng chọn một đối tượng PhanBon
                      },
                    );
                  },
                ),
              )),
            ])));
  }
}
