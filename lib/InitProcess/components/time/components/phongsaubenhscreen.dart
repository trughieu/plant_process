import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:plant_process/model/processplant.dart';
import '../../../../model/plant_provider.dart';
import '../../../../model/utilities.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../../../../provider/progressbar.dart';

class SauBenhScreen extends StatefulWidget {
  final DateTime dateFrom;
  final DateTime dateTo;
  final int selectedWeekIndex;

  SauBenhScreen(
      {Key? key,
      required this.dateFrom,
      required this.dateTo,
      required this.selectedWeekIndex})
      : super(key: key);

  @override
  State<SauBenhScreen> createState() => _SauBenhScreenState();
}

int getElapsedWeeks(DateTime startDate, DateTime endDate) {
  final daysElapsed = DateTime.now().difference(startDate).inDays;
  return (daysElapsed / 7).floor();
}

int getRemainingWeeks(
    DateTime startDate, DateTime endDate, int selectedWeekIndex) {
  final weeksElapsed = getElapsedWeeks(startDate, endDate);
  return (endDate.difference(startDate).inDays / 7).ceil() -
      weeksElapsed -
      selectedWeekIndex;
}

class _SauBenhScreenState extends State<SauBenhScreen> {
  String url = Utilities.url;
  final _formKey = GlobalKey<FormState>();
  final _tenLoaiSB = TextEditingController();
  final _moTa = TextEditingController();
  final _cachPhongTru = TextEditingController();

  void uploadSauBenh() async {
    PlantProvider myProvider =
        Provider.of<PlantProvider>(context, listen: false);
    final idPlant = myProvider.id;

    PhongSauBenh phongSauBenh = PhongSauBenh(
        tenLoaiSB: _tenLoaiSB.text,
        moTa: _moTa.text,
        cachPhongTru: _cachPhongTru.text);

    final response = await http.get(Uri.parse('$url/api/process/'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final plants = data['process'];
      final processExists =
          plants.any((plant) => plant['id_plant'] == myProvider.id);
      if (processExists) {
        print(processExists);
        final res = await http.put(
          Uri.parse('$url/api/process/$idPlant/chamSoc/tuoiNuoc'),
          headers: {'Content-Type': 'application/json'},
          body: json.encode({'tuoiNuoc': phongSauBenh.toJson()}),
        );
        if (res.statusCode == 200) {
          print(res.body);
        } else {
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
          "Khởi tạo quy trình",
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
              margin: const EdgeInsets.only(top: 10),
              child: Column(
                children: [
                  Center(
                    child: Text(
                      '${getRemainingWeeks(widget.dateFrom, widget.dateTo, widget.selectedWeekIndex)} tuần còn lại trước khi gieo hạt',
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.w600),
                    ),
                  )
                ],
              ),
            ),
            Container(
              child: Center(
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: 50, right: 50),
                      margin: const EdgeInsets.only(top: 20),
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                      color: const Color(0x50FFFFFF),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          'Tuần ${widget.selectedWeekIndex}',
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
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
                            moTa(),
                            cachPhongTru(),
                            ElevatedButton(
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  _formKey.currentState!.save();
                                  // await DatabaseHelper.instance.insertProcess(_process);
                                  uploadSauBenh();
                                  Provider.of<ProgressProvider>(context, listen: false).updateProgress();
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
      decoration: const InputDecoration(
        hintText: "Thời gian thu hoạch",
      ),
      onSaved: (pass) {
        _tenLoaiSB.text = pass!;
      },
    );
  }

  TextFormField moTa() {
    return TextFormField(
      controller: _moTa,
      decoration: const InputDecoration(
        labelText: "Bảo quản",
      ),
      onSaved: (pass) {
        _moTa.text = pass!;
      },
    );
  }

  TextFormField cachPhongTru() {
    return TextFormField(
      controller: _cachPhongTru,
      decoration: const InputDecoration(
        labelText: "nội dung",
      ),
      onSaved: (pass) {
        _cachPhongTru.text = pass!;
      },
    );
  }
}
