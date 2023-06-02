import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:plant_process/model/processplant.dart';
import 'package:plant_process/model/utilities.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../../../../../model/plant_provider.dart';
import '../../../../../model/saubenh.dart';

class editPSB extends StatefulWidget {
  final String id;

  const editPSB({Key? key, required this.id}) : super(key: key);

  @override
  State<editPSB> createState() => _editPSBState();
}

class _editPSBState extends State<editPSB> {
  String url = Utilities.url;
  List<sauBenh> saubenhList = [];
  final _formKey = GlobalKey<FormState>();
  final _tenLoaiSB = TextEditingController();
  final _moTa = TextEditingController();
  final _cachPhongTru = TextEditingController();

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
              _moTa.text = mota;
              _cachPhongTru.text = cachPhongTru;
              _tenLoaiSB.text = tenloaiSB;
            });
          }
          break;
        }
      }
    }
  }

  void updatePSB() async {
    Map<String, dynamic> updateData = {
      'tenLoaiSB': _tenLoaiSB.text,
      'moTa': _moTa.text,
      'cachPhongTru': _cachPhongTru.text,
    };

    PlantProvider myProvider =
        Provider.of<PlantProvider>(context, listen: false);
    final response = await http.put(
      Uri.parse('$url/api/process/${myProvider.id}/chamSoc/psb/${widget.id}'),
      body: jsonEncode(updateData),
      headers: {'Content-Type': 'application/json'},
    );
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
        title: const Text(
          "Phòng sâu bệnh",
          style: TextStyle(
              fontFamily: 'Inter-Medium-500.ttf',
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.w600),
        ),
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              child: Center(
                child: Column(
                  children: [
                    SizedBox(
                      height: 50,
                    ),
                    Container(
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            tenLoaiSB(),
                            SizedBox(
                              height: 10,
                            ),
                            moTa(),
                            SizedBox(
                              height: 10,
                            ),
                            cachPhongTru(),
                            ElevatedButton(
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  _formKey.currentState!.save();
                                  updatePSB();
                                  Navigator.pop(context);
                                }
                              },
                              child: Text('Lưu'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  TextFormField tenLoaiSB() {
    return TextFormField(
      controller: _tenLoaiSB,
      decoration: InputDecoration(
        hintText: 'Thời gian thu hoạch',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        filled: true,
        fillColor: Colors.white,
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
      onSaved: (value) {
        _tenLoaiSB.text = value!;
      },
    );
  }

  TextFormField moTa() {
    return TextFormField(
      controller: _moTa,
      decoration: InputDecoration(
        labelText: 'Bảo quản',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        filled: true,
        fillColor: Colors.white,
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
      onSaved: (value) {
        _moTa.text = value!;
      },
    );
  }

  TextFormField cachPhongTru() {
    return TextFormField(
      controller: _cachPhongTru,
      decoration: InputDecoration(
        labelText: 'Nội dung',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        filled: true,
        fillColor: Colors.white,
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
      onSaved: (value) {
        _cachPhongTru.text = value!;
      },
    );
  }
}
