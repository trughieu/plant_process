import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../progressbar.dart';
import '../../../provider/progressbar.dart';
import 'components/weekdetail.dart';
import 'package:provider/provider.dart';
class WeekPLant extends StatefulWidget {
  final DateTime? dateFrom;
  final DateTime? dateTo;

  WeekPLant({Key? key, this.dateFrom, this.dateTo}) : super(key: key);

  @override
  State<WeekPLant> createState() => _WeekPLantState();
}

class _WeekPLantState extends State<WeekPLant> {
  @override
  int getWeeksCount(DateTime dateFrom, DateTime dateTo) {
    final daysDifference = dateTo
        .difference(dateFrom)
        .inDays;

    if (daysDifference < 7) {
      return 1;
    }

    final weeks = daysDifference ~/ 7;
    final remainingDays = daysDifference % 7;

    if (remainingDays == 0) {
      return weeks;
    } else {
      return weeks + 1;
    }
  }

  @override
  Widget build(BuildContext context) {
    // final weeksCount = getWeeksCount(widget.dateFrom!, widget.dateTo!);
    // int remainingDays = widget.dateTo!.difference(widget.dateFrom!).inDays + 1 - weeks * 7;
    ProgressProvider progressProvider = Provider.of<ProgressProvider>(context);

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
          width: MediaQuery
              .of(context)
              .size
              .width,
          padding: EdgeInsets.all(8),
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
              CustomProgressBar(),
              // Nội dung màn hình
              const SizedBox(
                height: 100,
              ),
              Row(
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 20),
                    child: const Text(
                      "Ngày gieo:",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  )
                ],
              ),
              Container(
                margin: EdgeInsets.only(top: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      width: 150,
                      height: 50,
                      child: Center(
                        child: Text(
                          "${DateFormat('dd/MM/yyyy').format(
                              widget.dateFrom!)}",
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1F6C00),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    const Icon(Icons.arrow_right_alt_outlined),
                    // mũi tên hướng về phải
                    const SizedBox(
                      width: 20,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      width: 150,
                      height: 50,
                      child: Center(
                        child: Text(
                          "${DateFormat('dd/MM/yyyy').format(widget.dateTo!)}",
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1F6C00),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 20, top: 20),
                    child: const Text(
                      "Giai đoạn cấy giống",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  )
                ],
              ),
              Expanded(
                child: SingleChildScrollView(
                    child: Column(
                      children: List.generate(
                        getWeeksCount(widget.dateFrom!, widget.dateTo!),
                            (weekIndex) {
                          final dateFormatter = DateFormat('dd/MM/yyyy');
                          final startOfWeek =
                          widget.dateFrom!.add(Duration(days: weekIndex * 7));
                          final isLastWeek = weekIndex ==
                              getWeeksCount(widget.dateFrom!, widget.dateTo!) -
                                  1;

                          final endOfWeek = isLastWeek
                              ? widget.dateTo!
                              : startOfWeek.add(Duration(days: 6));
                          final startDateString = dateFormatter.format(
                              startOfWeek);
                          final endDateString = dateFormatter.format(endOfWeek);
                          final weekLabel = isLastWeek
                              ? 'Tuần ${weekIndex +
                              1} ($startDateString - $endDateString)'
                              : 'Tuần ${weekIndex +
                              1} ($startDateString - ${dateFormatter.format(
                              startOfWeek.add(Duration(days: 6)))})';

                          return weekLabel.isNotEmpty
                              ? GestureDetector(
                            onTap: () {
                              int selectedWeekIndex = weekIndex + 1;
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      WeekDetail(
                                        selectedWeekIndex: selectedWeekIndex,
                                        dateFrom: widget.dateFrom!,
                                        dateTo: widget.dateTo!,
                                      ),
                                ),
                              );
                            },
                            child: Column(
                              children: [
                                SizedBox(height: 20),
                                Container(
                                  width: MediaQuery
                                      .of(context)
                                      .size
                                      .width,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  height: 50,
                                  child: Center(
                                      child: Row(
                                        children: [
                                          Container(
                                            margin: EdgeInsets.only(left: 20),
                                            child: Text(
                                              weekLabel,
                                              style: const TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                color: Color(0xFF1F6C00),
                                              ),
                                            ),
                                          ),
                                          Spacer(),
                                          IconButton(
                                            onPressed: () {},
                                            icon: Icon(Icons.add),
                                          ),
                                        ],
                                      )),
                                ),
                              ],
                            ),
                          )
                              : Container();
                        },
                      ),
                    ),
                ),
              ),
            ],
          ),
        ));
  }
}
