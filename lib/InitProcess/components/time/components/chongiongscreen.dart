import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:plant_process/model/processplant.dart';
import '../../../../model/plant_provider.dart';
import '../../../../model/utilities.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../../../../provider/progressbar.dart';

class chonGiongScreen extends StatefulWidget {
  final DateTime dateFrom;
  final DateTime dateTo;
  final int selectedWeekIndex;

  const chonGiongScreen(
      {Key? key,
      required this.dateFrom,
      required this.dateTo,
      required this.selectedWeekIndex})
      : super(key: key);

  @override
  State<chonGiongScreen> createState() => _chonGiongScreenState();
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

class _chonGiongScreenState extends State<chonGiongScreen> {

  String url = Utilities.url;
  final _formKey = GlobalKey<FormState>();
  final _chongiong = TextEditingController();

  void getChonGiong() async {
    PlantProvider myProvider =
    Provider.of<PlantProvider>(context, listen: false);
    final idPlant = myProvider.id;

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
          body: {}),
        );
        if (res.statusCode == 200) {
          print(res.body);
        } else {
          print(res.body);
        }
      } else {
        print('Process does not exist for plant with ID: ${myProvider.id}');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
