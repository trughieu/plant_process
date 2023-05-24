import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:plant_process/model/processplant.dart';
import 'package:plant_process/model/utilities.dart';
import 'package:http/http.dart' as http;

import '../../../../model/plant_provider.dart';
import 'package:provider/provider.dart';

class ThuHoachScreen extends StatefulWidget {
  final DateTime dateFrom;
  final DateTime dateTo;
  final int selectedWeekIndex;

  ThuHoachScreen(
      {Key? key,
      required this.dateFrom,
      required this.dateTo,
      required this.selectedWeekIndex})
      : super(key: key);

  @override
  State<ThuHoachScreen> createState() => _ThuHoachScreenState();
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

class _ThuHoachScreenState extends State<ThuHoachScreen> {
  String url = Utilities.url;
  final _formKey = GlobalKey<FormState>();
  final _timeTH = TextEditingController();
  final _baoQuan = TextEditingController();
  final _noiDung = TextEditingController();

  void uploadBonphan() async {
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
                            thoiGianTH(),
                            baoQuan(),
                            noiDung(),
                            ElevatedButton(
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  _formKey.currentState!.save();
                                  // await DatabaseHelper.instance.insertProcess(_process);
                                  uploadBonphan();
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

  TextFormField thoiGianTH() {
    return TextFormField(
      controller: _timeTH,
      decoration: const InputDecoration(
        hintText: "Thời gian thu hoạch",
      ),
      onSaved: (pass) {
        _timeTH.text = pass!;
      },
    );
  }

  TextFormField baoQuan() {
    return TextFormField(
      controller: _baoQuan,
      decoration: const InputDecoration(
        labelText: "Bảo quản",
      ),
      onSaved: (pass) {
        _baoQuan.text = pass!;
      },
    );
  }

  TextFormField noiDung() {
    return TextFormField(
      controller: _noiDung,
      decoration: const InputDecoration(
        labelText: "nội dung",
      ),
      onSaved: (pass) {
        _noiDung.text = pass!;
      },
    );
  }
}
