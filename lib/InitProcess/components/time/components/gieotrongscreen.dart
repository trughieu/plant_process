import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:plant_process/model/processplant.dart';

import '../../../../model/plant_provider.dart';
import '../../../../model/utilities.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import '../../../../provider/progressbar.dart';

class GieoStrongScreen extends StatefulWidget {
  final DateTime dateFrom;
  final DateTime dateTo;
  final int selectedWeekIndex;

  const GieoStrongScreen(
      {Key? key,
      required this.dateFrom,
      required this.dateTo,
      required this.selectedWeekIndex})
      : super(key: key);

  @override
  State<GieoStrongScreen> createState() => _GieoStrongScreenState();
}
//ngoaicanh

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
class _GieoStrongScreenState extends State<GieoStrongScreen> {
  String url = Utilities.url;
  final _formKey = GlobalKey<FormState>();
  final _nhietDo = TextEditingController();
  final _anhSang = TextEditingController();
  final _nuoc = TextEditingController();
  final _doAm = TextEditingController();
  final _chatLuongKk = TextEditingController();
  final _moTaThem = TextEditingController();
  final _thoiVu = TextEditingController();

  void uploadGieoTrong() async {
    PlantProvider myProvider =
    Provider.of<PlantProvider>(context, listen: false);
    final idPlant = myProvider.id;
    String nhietDo = _nhietDo.text;
    String anhSang = _anhSang.text;
    String nuoc = _nuoc.text;
    String doAm = _doAm.text;
    String chatLuongKK = _chatLuongKk.text;
    String moTa = _moTaThem.text;
    String thoivu = _thoiVu.text;

    NgoaiCanh ngoaiCanh = NgoaiCanh(
        nhietDo: nhietDo,
        anhSang: anhSang,
        nuoc: nuoc,
        doAm: doAm,
        chatLuongKK: chatLuongKK,
        moTaThem: moTa);

    final response = await http.get(Uri.parse('$url/api/process/'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final plants = data['process'];
      final processExists =
      plants.any((plant) => plant['id_plant'] == myProvider.id);
      if (processExists) {
        print(processExists);
        final res = await http.put(
          Uri.parse('$url/api/process/$idPlant/cachTrong/gieoTrong/ngoaiCanh'),
          headers: {'Content-Type': 'application/json'},
          body: json.encode({'ngoaiCanh': ngoaiCanh.toJson()}),
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
          "Khởi tạo quy trình",
          style: TextStyle(
              fontFamily: 'Inter-Medium-500.ttf',
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.w600),
        ),
      ),
      body: Container(
        width: MediaQuery
            .of(context)
            .size
            .width,
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
                      '${getRemainingWeeks(widget.dateFrom, widget.dateTo,
                          widget
                              .selectedWeekIndex)} tuần còn lại trước khi gieo hạt',
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
                      width: MediaQuery
                          .of(context)
                          .size
                          .width,
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
                    SingleChildScrollView(
                      child: Container(
                        child: Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              nhietDo(),
                              anhSang(),
                              nuoc(),
                              doAm(),
                              chatLuongKK(),
                              moTa(),
                              ElevatedButton(
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                    _formKey.currentState!.save();
                                    // await DatabaseHelper.instance.insertProcess(_process);
                                    uploadGieoTrong();
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
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  TextFormField nhietDo() {
      return TextFormField(
      controller: _nhietDo,
      decoration: const InputDecoration(
        hintText: "Nhiệt độ",
      ),
      onSaved: (pass) {
        _nhietDo.text = pass!;
      },
    );
  }

  TextFormField anhSang() {
    return TextFormField(
      controller: _anhSang,
      decoration: const InputDecoration(
        labelText: "Ánh sáng",
      ),
      onSaved: (pass) {
        _anhSang.text = pass!;
      },
    );
  }

  TextFormField nuoc() {
    return TextFormField(
      controller: _nuoc,
      decoration: const InputDecoration(
        labelText: "Nước",
      ),
      onSaved: (pass) {
        _nuoc.text = pass!;
      },
    );
  }
  TextFormField doAm() {
    return TextFormField(
      controller: _doAm,
      decoration: const InputDecoration(
        labelText: "Độ ẩm",
      ),
      onSaved: (pass) {
        _doAm.text = pass!;
      },
    );
  } TextFormField chatLuongKK() {
    return TextFormField(
      controller: _chatLuongKk,
      decoration: const InputDecoration(
        labelText: "Chất lượng không khí",
      ),
      onSaved: (pass) {
        _chatLuongKk.text = pass!;
      },
    );
  }

  TextFormField moTa() {
    return TextFormField(
      controller: _moTaThem,
      decoration: const InputDecoration(
        labelText: "Mô tả",
      ),
      onSaved: (pass) {
        _moTaThem.text = pass!;
      },
    );
  } TextFormField thoiVu() {
    return TextFormField(
      controller: _thoiVu,
      decoration: const InputDecoration(
        labelText: "nội dung",
      ),
      onSaved: (pass) {
        _thoiVu.text = pass!;
      },
    );
  }
}
