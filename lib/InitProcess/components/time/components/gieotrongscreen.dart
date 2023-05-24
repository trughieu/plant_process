import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:plant_process/model/processplant.dart';

import '../../../../model/plant_provider.dart';
import '../../../../model/utilities.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

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
        nhietDo: 'nhietDo',
        anhSang: 'abc',
        nuoc: 'nuoc',
        doAm: 'doAm',
        chatLuongKK: 'chatLuongKK',
        moTaThem: 'moTa');

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
      body: ElevatedButton(
        onPressed: () {
          uploadGieoTrong();
        },
        child: Text('next'),
      ),
    );
  }
}
