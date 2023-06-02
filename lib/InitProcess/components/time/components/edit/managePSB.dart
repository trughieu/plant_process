import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:plant_process/InitProcess/components/time/components/edit/editphanbon.dart';
import 'package:plant_process/InitProcess/components/time/components/edit/editphongsaubenh.dart';
import '../../../../../model/plant_provider.dart';
import '../../../../../model/saubenh.dart';
import '../../../../../model/utilities.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class ManagePSB extends StatefulWidget {
  static String routeName = '/managePSB';

  const ManagePSB({Key? key}) : super(key: key);

  @override
  State<ManagePSB> createState() => _ManagePSBState();
}

class _ManagePSBState extends State<ManagePSB> {
  String uri = Utilities.url;
  List<sauBenh> psb = [];

  void getPSB() async {
    PlantProvider myProvider =
        Provider.of<PlantProvider>(context, listen: false);
    final response = await http.get(Uri.parse('$uri/api/process'));
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
            var id = pb['_id'];
            var saubenhh = sauBenh(
                tenloaiSB: tenloaiSB,
                mota: mota,
                cachPhongTru: cachPhongTru,
                id: id);
            setState(() {
              psb.add(saubenhh);
            });
          }
          break;
        }
      }
    }
  }

  void deletePSB(String id) async {
    PlantProvider myProvider =
        Provider.of<PlantProvider>(context, listen: false);
    final response = await http
        .delete(Uri.parse('$uri/api/process/${myProvider.id}/chamSoc/psb/$id'));
    if (response.statusCode == 200) {
      print(response.body);
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
        leading: IconButton(
          color: Colors.white,
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: const Color(0xff91CD00),
        centerTitle: true,
        title: const Text("Phòng sâu bệnh"),
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
          itemCount: psb.length,
          itemBuilder: (context, index) {
            sauBenh item = psb[index];
            return Card(
                color: Colors.white,
                child: ListTile(
                  title: Text(item.tenloaiSB.toString()),
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
                              builder: (context) => editPSB(
                                id: item.id,
                              ),
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
                                    setState(() {
                                      deletePSB(item.id);
                                      psb.removeAt(index);
                                    });
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
