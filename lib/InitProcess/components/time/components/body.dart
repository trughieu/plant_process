import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:plant_process/HomePage/homepage.dart';
import 'package:plant_process/InitProcess/components/time/weekplant.dart';
import 'package:http/http.dart' as http;
import 'package:plant_process/model/classify.dart';

import '../../../../model/plant_provider.dart';
import '../../../../model/utilities.dart';
import '../../../../provider/progressbar.dart';
import 'package:provider/provider.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  DateTime? _selectedDate1;
  DateTime? _selectedDate2;
  String? _displayText1;
  String? _displayText2;

  final DateFormat formatter = DateFormat('dd/MM/yyyy');

  Future<void> _selectDate1() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate1 ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != _selectedDate1) {
      setState(() {
        _selectedDate1 = picked;
        _displayText1 = DateFormat('dd/MM/yyyy').format(picked);
      });
    }
  }

  Future<void> _selectDate2() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate2 ?? _selectedDate1 ?? DateTime.now(),
      firstDate: _selectedDate1 ?? DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != _selectedDate2) {
      setState(() {
        _selectedDate2 = picked;
        _displayText2 = DateFormat('dd/MM/yyyy').format(picked);
      });
    }
  }

  String uri = Utilities.url;
  List<String> classify = [];

  void getBangTin() async {
    PlantProvider myProvider =
        Provider.of<PlantProvider>(context, listen: false);
    print(myProvider.idLoaiCay);
    final response =
        await http.get(Uri.parse('$uri/api/classify/${myProvider.idLoaiCay}'));
    if (response.statusCode == 200) {
      print("dadad" + response.body);
      final body = jsonDecode(response.body);
      var loaiCay = body['classify'];
      String char = loaiCay['char'];
      print(char);
      setState(() {
        classify = [char];
        // add vao list Process
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getBangTin();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        child: Column(children: [
          const Padding(
            padding: EdgeInsets.only(top: 50),
            child: Text(
              "Thời gian gieo trồng",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
          ),
          Row(
              mainAxisAlignment: MainAxisAlignment.center,
              // căn giữa theo chiều ngang
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8), // bo góc
                  ),
                  width: 150, // Kích thước có thể tuỳ chỉnh
                  height: 50, // Kích thước có thể tuỳ chỉnh
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    // căn giữa theo chiều ngang
                    children: [
                      GestureDetector(
                        onTap: _selectDate1,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          width: 150,
                          height: 150,
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  _displayText1 ?? 'Từ',
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ]),
                        ),
                      ),
                    ],
                  ),
                ),
                //   ],
                // ),
                const SizedBox(
                  width: 20,
                ),
                const Icon(Icons.arrow_right_alt_outlined),
                // mũi tên hướng về phải
                const SizedBox(
                  width: 20,
                ),
                GestureDetector(
                  onTap: _selectDate2,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    width: 150,
                    height: 50,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          _displayText2 ?? 'đến',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ]),
          GestureDetector(
            onTap: (_selectedDate1 != null && _selectedDate2 != null)
                ? () {
                    // Xử lý khi người dùng chạm vào Container
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => WeekPLant(
                                dateFrom: _selectedDate1,
                                dateTo: _selectedDate2,
                              )),
                    );
                    Provider.of<ProgressProvider>(context, listen: false)
                        .updateProgress();
                  }
                : null,
            child: Container(
              margin: EdgeInsets.only(top: 10),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Color(0xFF186600), width: 2)),
              width: 150,
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    "Xác nhận",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  )
                ],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 20),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(20),
                  child: Text(
                    'Bảng tin',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 20, right: 20, bottom: 50),
                  child: Text(
                    classify.isNotEmpty ? classify[0] : '',
                    style: TextStyle(
                      fontSize: 20,
                      color: Color(0xFF2D7800),
                    ),
                  ),
                )
              ],
            ),
          )
        ]));
  }
}
