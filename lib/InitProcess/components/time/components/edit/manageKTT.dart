import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:plant_process/InitProcess/components/time/components/edit/editktt.dart';

import '../../../../../model/kythuattrong.dart';
import '../../../../../model/plant_provider.dart';
import '../../../../../model/utilities.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class ManageKTT extends StatefulWidget {
  static String routeName = '/manageKTT';

  const ManageKTT({Key? key}) : super(key: key);

  @override
  State<ManageKTT> createState() => _ManageKTTState();
}

class _ManageKTTState extends State<ManageKTT> {
  String uri = Utilities.url;
  List<KyThuatTrong> ktt = [];

  void getKTT() async {
    PlantProvider myProvider =
        Provider.of<PlantProvider>(context, listen: false);
    final idPlant = myProvider.id;
    final response = await http.get(Uri.parse('$uri/api/process'));
    if (response.statusCode == 200) {
      final process = jsonDecode(response.body);
      var pro = process['process'];
      for (var p in pro) {
        var idplant = p['id_plant'];
        var phanBon = p['chamSoc']['kyThuatTrong'];
        if (idplant == myProvider.id) {
          for (var pb in phanBon) {
            var tenKyThuat = pb['tenKyThuat'];
            var moTa = pb['moTa'];
            var huongDan = pb['huongDan'];
            var id = pb['_id'];
            var phanBonObj = KyThuatTrong(
                tenKyThuat: tenKyThuat,
                moTa: moTa,
                img_KT: '',
                huongDan: huongDan,
                id: id);
            setState(() {
              ktt.add(phanBonObj);
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
    getKTT();
  }

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
        title: const Text("Chọn giống"),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(8),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            tileMode: TileMode.clamp,
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFC1FD2D),
              Color(0xFFFFFFFF),
            ],
          ),
        ),
        child: ListView.builder(
          itemCount: ktt.length,
          itemBuilder: (context, index) {
            KyThuatTrong item = ktt[index];
            return Card(
                color: Colors.white,
                child: ListTile(
                  title: Text(item.tenKyThuat.toString()),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit),
                        color: Colors.red,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => editKTT(id: item.id,),
                            ),
                          );
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        color: Colors.red,
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Text('Xác nhận'),
                              content: Text('Bạn có chắc muốn xoá mục này?'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    setState(() {});
                                    Navigator.pop(context);
                                  },
                                  child: Text('Đồng ý'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text('Hủy'),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ));
          },
        ),
      ),
    );
  }
}
