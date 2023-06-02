import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:plant_process/model/processplant.dart';
import 'package:plant_process/model/utilities.dart';
import 'package:http/http.dart' as http;

import 'package:provider/provider.dart';
import '../../../../../model/plant_provider.dart';

class editThuhoach extends StatefulWidget {
  static String routeName = '/editthuhoach';

  const editThuhoach({super.key});

  @override
  State<editThuhoach> createState() => _editThuhoachState();
}

class _editThuhoachState extends State<editThuhoach> {
  String url = Utilities.url;
  final _formKey = GlobalKey<FormState>();
  final _timeTH = TextEditingController();
  final _baoQuan = TextEditingController();
  final _noiDung = TextEditingController();

  void getPhanbon() async {
    PlantProvider myProvider =
        Provider.of<PlantProvider>(context, listen: false);
    final response = await http.get(Uri.parse('$url/api/process'));
    if (response.statusCode == 200) {
      print(response.body);
      final process = jsonDecode(response.body);
      var pro = process['process'];
      for (var p in pro) {
        var idplant = p['id_plant'];
        var phanBon = p['chamSoc']['thuHoach'];
        if (idplant == myProvider.id) {
          var thoigianTH = phanBon['thoiGianTH'];
          var baoQuan = phanBon['baoQuan'];
          var noiDung = phanBon['noiDung'];
          setState(() {
            _baoQuan.text = baoQuan;
            _noiDung.text = noiDung;
            _timeTH.text = thoigianTH;
          });

          break;
        }
      }
    }
  }


  void updateThuhoach() async {
    PlantProvider myProvider =
    Provider.of<PlantProvider>(context, listen: false);
    final idPlant = myProvider.id;
    String timeTH = _timeTH.text;
    String baoQuan = _baoQuan.text;
    String noiDung = _noiDung.text;
    ThuHoach thuHoach =
    ThuHoach(thoiGianTH: timeTH, baoQuan: baoQuan, noiDung: noiDung);
    final response = await http.get(Uri.parse('$url/api/process/'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final plants = data['process'];
      final processExists = plants.any((plant) => plant['id_plant'] == myProvider.id);
      if (processExists) {
        final res = await http.put(
          Uri.parse('$url/api/process/$idPlant/chamSoc/thuHoach'),
          headers: {'Content-Type': 'application/json'},
          body: json.encode({'thuHoach': thuHoach.toJson()}),
        );
        if (res.statusCode == 200) {
          print(res.body);
        }
      } else {
        print('Process does not exist for plant with ID: ${myProvider.id}');
      }
    } else {
      print('Failed to fetch data. Error: ${response.statusCode}');
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
      resizeToAvoidBottomInset: false,
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
          "Thu hoạch",
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
                            thoiGianTH(),
                            SizedBox(
                              height: 10,
                            ),
                            baoQuan(),
                            SizedBox(
                              height: 10,
                            ),
                            noiDung(),
                            ElevatedButton(
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  _formKey.currentState!.save();
                                  updateThuhoach();
                                  Navigator.pop(context);
                                  // await DatabaseHelper.instance.insertProcess(_process);
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

  Widget thoiGianTH() {
    return TextFormField(
      controller: _timeTH,
      decoration: InputDecoration(
        labelText: 'Bảo quản',
        hintText: 'Thời gian thu hoạch',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        filled: true,
        fillColor: Colors.white,
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
      textInputAction: TextInputAction.newline,

      onSaved: (value){
        _timeTH.text = value!;
      },
    );
  }

  Widget baoQuan() {
    return TextFormField(
      controller: _baoQuan,
      decoration: InputDecoration(
        labelText: 'Bảo quản',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        filled: true,
        fillColor: Colors.white,
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
      textInputAction: TextInputAction.newline,
      onSaved: (value){
        _baoQuan.text = value!;
      },
    );
  }

  Widget noiDung() {
    return TextFormField(
      controller: _noiDung,
      decoration: InputDecoration(
        labelText: 'Nội dung',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        filled: true,
        fillColor: Colors.white,
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
      textInputAction: TextInputAction.newline,
      onSaved: (value){
        _noiDung.text = value!;
      },
    );
  }
}
