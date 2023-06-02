import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:plant_process/HomePage/homepage.dart';
import 'package:plant_process/InitProcess/components/time/components/bonphanscreen.dart';
import 'package:plant_process/InitProcess/components/time/components/gieotrongscreen.dart';
import 'package:plant_process/InitProcess/components/time/components/kttscreen.dart';
import 'package:plant_process/InitProcess/components/time/components/phongsaubenhscreen.dart';
import 'package:plant_process/InitProcess/components/time/components/thuhoachscreen.dart';
import 'package:plant_process/InitProcess/components/time/components/thuyloiscreen.dart';
import 'package:plant_process/model/utilities.dart';
import 'package:http/http.dart' as http;
import '../../../../model/mission.dart';
import '../../../../progressbar.dart';

class WeekDetail extends StatefulWidget {
  final DateTime dateFrom;
  final DateTime dateTo;
  final int selectedWeekIndex;

  WeekDetail(
      {Key? key,
      required this.dateFrom,
      required this.dateTo,
      required this.selectedWeekIndex})
      : super(key: key);

  @override
  State<WeekDetail> createState() => _WeekDetailState();
}

class _WeekDetailState extends State<WeekDetail> {
  late List<DateTime> lastWeekData;
  List<String> selectedOptions = [];
  String url = Utilities.url;
  List<Mission> mission = [];

  void getMission() async {
    final response = await http.get(Uri.parse('$url/api/mission'));
    if (response.statusCode == 200) {
      print(response.body);
      final body = jsonDecode(response.body);
      var mis = body['mission'];
      for (var p in mis) {
        setState(() {
          mission.add(Mission.fromJson(p as Map<String, dynamic>));
        });
        for (int i = 0; i < mission.length; i++) {
          mission[i].img = Image.network('$url/imgMission/${mission[i].image}');
        }
      }
    }
  }

  @override
  void initState() {
    super.initState();
    // selectedWeekIndex = ModalRoute.of(context)?.settings.arguments as int ??  0;
    lastWeekData = calculateLastWeekData();
    getMission();
  }

  int getWeeksCount(DateTime startDate, DateTime endDate) {
    final days = endDate.difference(startDate).inDays;
    return (days / 7).ceil();
  }

  List<DateTime> calculateLastWeekData() {
    final weeksCount = getWeeksCount(widget.dateFrom, widget.dateTo);
    final startOfWeek =
        widget.dateFrom.add(Duration(days: (weeksCount - 2) * 7));
    final endOfWeek = widget.dateTo.subtract(const Duration(days: 7));
    return [startOfWeek, endOfWeek];
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
          children: [
            Container(
              margin: const EdgeInsets.only(top: 10),
              child: Column(
                children: [
                  CustomProgressBar(),
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
              margin: const EdgeInsets.only(top: 20),
              width: MediaQuery.of(context).size.width,
              height: 50,
              color: const Color(0x50FFFFFF),
              child: Center(
                child: Text(
                  'Tuần ${widget.selectedWeekIndex} ',
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Expanded(
                child: SingleChildScrollView(
              child: GridView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  primary: false,
                  itemCount: mission.length,
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 200,
                      // Chiều rộng tối đa của mỗi mục
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20,
                      mainAxisExtent: 150),
                  itemBuilder: (context, index) {
                    return ProductItem(
                        mission: mission[index],
                        onTap: () {
                          if (mission[index].type == 'THU_HOACH') {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ThuHoachScreen(
                                        dateFrom: widget.dateFrom,
                                        dateTo: widget.dateTo,
                                        selectedWeekIndex:
                                            widget.selectedWeekIndex)));
                          } else if (mission[index].type == 'BON_PHAN') {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => BonPhanScreen(
                                        dateFrom: widget.dateFrom,
                                        dateTo: widget.dateTo,
                                        selectedWeekIndex:
                                            widget.selectedWeekIndex)));
                          } else if (mission[index].type == 'GIEO_TRONG') {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => GieoStrongScreen(
                                        dateFrom: widget.dateFrom,
                                        dateTo: widget.dateTo,
                                        selectedWeekIndex:
                                            widget.selectedWeekIndex)));
                          } else if (mission[index].type == 'THUY_LOI') {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ThuyLoiScreen(
                                        dateFrom: widget.dateFrom,
                                        dateTo: widget.dateTo,
                                        selectedWeekIndex:
                                            widget.selectedWeekIndex)));
                          } else if (mission[index].type == 'KY_THUAT') {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => KyThuatTrongScreen(
                                        dateFrom: widget.dateFrom,
                                        dateTo: widget.dateTo,
                                        selectedWeekIndex:
                                            widget.selectedWeekIndex)));
                          } else if (mission[index].type == 'PHONG_SAU_BENH') {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SauBenhScreen(
                                        dateFrom: widget.dateFrom,
                                        dateTo: widget.dateTo,
                                        selectedWeekIndex:
                                            widget.selectedWeekIndex)));
                          }
                        });
                  }),
            )),
            ElevatedButton(
              onPressed: () async {
                Navigator.pushNamedAndRemoveUntil(
                    context, HomePage.routeName, (Route<dynamic>route) => false);
                },
              child: Text('Xong'),
            ),
          ],
        ),
      ),
    );
  }
}

class ProductItem extends StatelessWidget {
  final Mission mission;
  final VoidCallback onTap;

  ProductItem({Key? key, required this.mission, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.rectangle,
                border: Border.all(color: Colors.black)),
            child: Column(
              children: [
                Container(
                  child: SizedBox(
                    width: 150,
                    height: 70,
                    child: mission.image == null
                        ? const CircularProgressIndicator()
                        : mission.img!,
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  width: 100,
                  height: 50,
                  child: Text(
                    mission.title,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
