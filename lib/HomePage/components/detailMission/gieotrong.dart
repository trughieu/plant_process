import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:plant_process/model/utilities.dart';

import '../../../model/gieotrong.dart';
import '../../../model/mission.dart';
import '../../../model/plant_provider.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class gieoTrong extends StatefulWidget {
  final Mission mission;

  const gieoTrong({Key? key, required this.mission}) : super(key: key);

  @override
  State<gieoTrong> createState() => _gieoTrongState();
}

class _gieoTrongState extends State<gieoTrong> {
  String url = Utilities.url;
  List<GieoTrong> gieoTrongList = [];

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
        print("1112$gieotrongData");
        if (idplant == myProvider.id) {
          var tenLoaiPhan = gieotrongData['chonGiong'];
          var ngoaiCanh = gieotrongData['ngoaiCanh'];
          var mota = ngoaiCanh['moTa'];
          var huongDan = gieotrongData['thoiVu'];
          print("aa$tenLoaiPhan");
          print(mota);
          print(huongDan);

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
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: const Color(0xff91CD00),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Thông tin Gieo Trồng',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              SizedBox(height: 16),
              if (gieoTrongList.isNotEmpty)
                Text(
                  'Nhiệt độ: ${gieoTrongList[0].ngoaiCanh.nhietdo}',
                  style: TextStyle(fontSize: 16),
                ),
              if (gieoTrongList.isNotEmpty)
                Text(
                  'Ánh sáng: ${gieoTrongList[0].ngoaiCanh.anhSang}',
                  style: TextStyle(fontSize: 16),
                ),
              if (gieoTrongList.isNotEmpty)
                Text(
                  'Nước: ${gieoTrongList[0].ngoaiCanh.nuoc}',
                  style: TextStyle(fontSize: 16),
                ),
              if (gieoTrongList.isNotEmpty)
                Text(
                  'Độ ẩm: ${gieoTrongList[0].ngoaiCanh.doAm}',
                  style: TextStyle(fontSize: 16),
                ),
              if (gieoTrongList.isNotEmpty)
                Text(
                  'Chất lượng khí kháng: ${gieoTrongList[0].ngoaiCanh
                      .chatLuongKK}',
                  style: TextStyle(fontSize: 16),
                ),
              if (gieoTrongList.isNotEmpty)
                Text(
                  'Mô tả thêm: ${gieoTrongList[0].ngoaiCanh.moTaThem}',
                  style: TextStyle(fontSize: 16),
                ),
              SizedBox(height: 16),
              if (gieoTrongList.isNotEmpty)
                Text(
                  'Thời vụ: ${gieoTrongList[0].thoiVu}',
                  style: TextStyle(fontSize: 16),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
