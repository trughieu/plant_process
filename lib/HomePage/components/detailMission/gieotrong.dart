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
            icon: const Icon(Icons.arrow_back),
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
                  if (gieoTrongList.isNotEmpty)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Nhiệt độ:',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '${gieoTrongList[0].ngoaiCanh.nhietdo}',
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  if (gieoTrongList.isNotEmpty)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Ánh sáng:',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '${gieoTrongList[0].ngoaiCanh.anhSang}',
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  if (gieoTrongList.isNotEmpty)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Nước:',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '${gieoTrongList[0].ngoaiCanh.nuoc}',
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  if (gieoTrongList.isNotEmpty)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Độ ẩm:',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '${gieoTrongList[0].ngoaiCanh.doAm}',
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  if (gieoTrongList.isNotEmpty)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Chất lượng khí kháng:',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '${gieoTrongList[0].ngoaiCanh.chatLuongKK}',
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  if (gieoTrongList.isNotEmpty)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Mô tả thêm:',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '${gieoTrongList[0].ngoaiCanh.moTaThem}',
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  const SizedBox(height: 16),
                  if (gieoTrongList.isNotEmpty)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Thời vụ:',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '${gieoTrongList[0].thoiVu}',
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                ],
              ),
            )));
  }
}
