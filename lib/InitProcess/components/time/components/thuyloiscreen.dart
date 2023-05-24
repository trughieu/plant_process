import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:plant_process/model/processplant.dart';
import '../../../../model/plant_provider.dart';
import '../../../../model/utilities.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class ThuyLoiScreen extends StatefulWidget {
  final DateTime dateFrom;
  final DateTime dateTo;
  final int selectedWeekIndex;

  const ThuyLoiScreen(
      {Key? key,
      required this.dateFrom,
      required this.dateTo,
      required this.selectedWeekIndex})
      : super(key: key);

  @override
  State<ThuyLoiScreen> createState() => _ThuyLoiScreenState();
}

class _ThuyLoiScreenState extends State<ThuyLoiScreen> {
  String url = Utilities.url;

  void uploadTuoiNuoc() async {
    PlantProvider myProvider =
        Provider.of<PlantProvider>(context, listen: false);
    final idPlant = myProvider.id;

    TuoiNuoc tuoiNuoc = TuoiNuoc(
        ngayTuoi: 'ngayTuoi',
        thoiGianTuoi: 'thoiGianTuoi',
        huongDan: 'huongDan');

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
          body: json.encode({'tuoiNuoc': tuoiNuoc.toJson()}),
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
          uploadTuoiNuoc();
        },
        child: Text('next'),
      ),
    );
  }
}

