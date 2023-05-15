import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:plant_process/InitProcess/components/time/components/bonphan.dart';
import 'package:plant_process/model/utilities.dart';
import 'package:http/http.dart' as http;
import 'package:plant_process/tip_plant/components/product_plant.dart';
import 'package:plant_process/tip_plant/components/select_plant.dart';
import '../../../../model/mission.dart';

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
      print("body$body");
      var mis = body['mission'];
      print("asas$mis");
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
    final TextEditingController _week = TextEditingController();
    final TextEditingController _descriptionController =
        TextEditingController();

    void _showAddTodoDialog() async {
      String? todo1;
      String? todo2;
      await showDialog<String>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Thêm quy trình'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // TextField(
                //   decoration: InputDecoration(
                //     hintText: 'Nhập thông tin',
                //     hintStyle: TextStyle(color: Colors.grey),
                //     border: OutlineInputBorder(
                //       borderRadius: BorderRadius.circular(8.0),
                //     ),
                //     enabledBorder: OutlineInputBorder(
                //       borderSide: BorderSide(color: Colors.grey),
                //       borderRadius: BorderRadius.circular(8.0),
                //     ),
                //     focusedBorder: OutlineInputBorder(
                //       borderSide: BorderSide(color: Colors.blue),
                //       borderRadius: BorderRadius.circular(8.0),
                //     ),
                //   ),
                //   maxLines: null,
                // ),
                // SizedBox(height: 16.0),
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Nhập thông tin',
                    hintStyle: const TextStyle(color: Colors.grey),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.blue),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  maxLines: null,
                )
              ],
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('Hủy'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              TextButton(
                child: const Text('Lưu'),
                onPressed: () {
                  Navigator.pop(context, [todo1, todo2]);
                },
              ),
            ],
          );
        },
      );

      if (todo1 != null && todo1.isNotEmpty) {
        // Xử lý công việc đã nhập ở đây
      }
    }

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
                          if(mission[index].type=='BON_PHAN'){
                            Navigator.push(
                              context,MaterialPageRoute(builder: (context)=>
                            BonPhan(dateFrom: widget.dateFrom, dateTo: widget.dateTo, selectedWeekIndex: widget.selectedWeekIndex))
                            );
                          }
                          else{
                            Navigator.pushNamed(context, Select_plant.routeName);
                          }
                        });
                  }),
            ))
            // Expanded(
            //   child: SingleChildScrollView(
            //     child: Column(
            //       children: [
            //         Container(
            //           decoration: BoxDecoration(
            //             color: Colors.white,
            //             borderRadius: BorderRadius.circular(8.0),
            //           ),
            //           width: 300,
            //           padding: const EdgeInsets.only(left: 20, right: 10),
            //           height: 50,
            //           margin: const EdgeInsets.only(top: 10),
            //           child: Row(
            //             children: [
            //               const Text(
            //                 'Bón Phân Hoá Học',
            //                 style: TextStyle(
            //                   fontSize: 20,
            //                   fontWeight: FontWeight.w500,
            //                 ),
            //               ),
            //               const Spacer(),
            //               IconButton(
            //                 onPressed: () {
            //                   setState(() {
            //                     int selectedWeekIndex = widget.selectedWeekIndex;
            //                     Navigator.push(
            //                       context,
            //                       MaterialPageRoute(
            //                         builder: (context) =>
            //                             BonPhan(
            //                               selectedWeekIndex: selectedWeekIndex,
            //                               dateFrom: widget.dateFrom!,
            //                               dateTo: widget.dateTo!,
            //                             ),
            //                         // settings: RouteSettings(arguments:{
            //                         //   'selectedWeekIndex': selectedWeekIndex,
            //                         //   'dateFrom': widget.dateFrom,
            //                         //   'dateTo': widget.dateTo,
            //                         // })
            //                       ),
            //                     );
            //                   });
            //                 },
            //                 icon: SvgPicture.asset('asset/icon/edit.svg'),
            //               ),
            //             ],
            //           ),
            //         ),
            //         Container(
            //           decoration: BoxDecoration(
            //             color: Colors.white,
            //             borderRadius: BorderRadius.circular(8.0),
            //           ),
            //           width: 300,
            //           padding: const EdgeInsets.only(left: 20, right: 10),
            //           height: 50,
            //           margin: const EdgeInsets.only(top: 10),
            //           child: Row(
            //             children: [
            //               const Text(
            //                 'Làm cỏ',
            //                 style: TextStyle(
            //                   fontSize: 20,
            //                   fontWeight: FontWeight.w500,
            //                 ),
            //               ),
            //               const Spacer(),
            //               IconButton(
            //                 onPressed: () {
            //                   setState(() {
            //                     _showAddTodoDialog;
            //                   });
            //                 },
            //                 icon: SvgPicture.asset('asset/icon/edit.svg'),
            //               ),
            //             ],
            //           ),
            //         ),
            //         Container(
            //           decoration: BoxDecoration(
            //             color: Colors.white,
            //             borderRadius: BorderRadius.circular(8.0),
            //           ),
            //           width: 300,
            //           padding: const EdgeInsets.only(left: 20, right: 10),
            //           height: 50,
            //           margin: const EdgeInsets.only(top: 10),
            //           child: Row(
            //             children: [
            //               const Text(
            //                 'Thuỷ lợi',
            //                 style: TextStyle(
            //                   fontSize: 20,
            //                   fontWeight: FontWeight.w500,
            //                 ),
            //               ),
            //               const Spacer(),
            //               IconButton(
            //                 onPressed: () {
            //                   setState(() {
            //                     _showAddTodoDialog;
            //                   });
            //                 },
            //                 icon: SvgPicture.asset('asset/icon/edit.svg'),
            //               ),
            //             ],
            //           ),
            //         ),
            //         Container(
            //           decoration: BoxDecoration(
            //             color: Colors.white,
            //             borderRadius: BorderRadius.circular(8.0),
            //           ),
            //           width: 300,
            //           padding: const EdgeInsets.only(left: 20, right: 10),
            //           height: 50,
            //           margin: const EdgeInsets.only(top: 10),
            //           child: Row(
            //             children: [
            //               const Text(
            //                 'Bón Phân Hữu cơ',
            //                 style: TextStyle(
            //                   fontSize: 20,
            //                   fontWeight: FontWeight.w500,
            //                 ),
            //               ),
            //               const Spacer(),
            //               IconButton(
            //                 onPressed: () {
            //                   setState(() {
            //                     _showAddTodoDialog;
            //                   });
            //                 },
            //                 icon: SvgPicture.asset('asset/icon/edit.svg'),
            //               ),
            //             ],
            //           ),
            //         ),
            //         Container(
            //           decoration: BoxDecoration(
            //             color: Colors.white,
            //             borderRadius: BorderRadius.circular(8.0),
            //           ),
            //           width: 300,
            //           padding: const EdgeInsets.only(left: 20, right: 10),
            //           height: 50,
            //           margin: const EdgeInsets.only(top: 10),
            //           child: Row(
            //             children: [
            //               const Text(
            //                 'Biện Pháp phòng ngừa',
            //                 style: TextStyle(
            //                   fontSize: 20,
            //                   fontWeight: FontWeight.w500,
            //                 ),
            //               ),
            //               const Spacer(),
            //               IconButton(
            //                 onPressed: () {
            //                   setState(() {
            //                     _showAddTodoDialog;
            //                   });
            //                 },
            //                 icon: SvgPicture.asset('asset/icon/edit.svg'),
            //               ),
            //             ],
            //           ),
            //         ),
            //       ],
            //     ),
            //   ),
            // )
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
