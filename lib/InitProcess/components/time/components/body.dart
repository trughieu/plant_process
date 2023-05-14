import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:plant_process/HomePage/homepage.dart';
import 'package:plant_process/InitProcess/components/time/weekplant.dart';

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

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
            children: [
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
                        // if (_selectedDate2 != null)
                        //   Text(
                        //     DateFormat('dd/MM/yyyy').format(_selectedDate2!),
                        //     style: const TextStyle(
                        //       fontSize: 16,
                        //       color: Colors.black54,
                        //     ),
                        //   ),
                      ],
                    ),
                  ),
                )
              ]),
          GestureDetector(
            onTap: () {
              // Xử lý khi người dùng chạm vào Container

              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => WeekPLant(
                          dateFrom: _selectedDate1,
                          dateTo: _selectedDate2,
                        )),
              );
            },
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
                    'Bên cạnh việc theo đuổi một nền nông nghiệp hài hòa và bền vững, thì việc trồng các loại cây nông nghiệp ngắn ngày giá trị cao sẽ cải thiện kinh tế nhanh cho bà con ở một số vùng trong nước. Với đặc điểm yêu cầu vốn đầu tư không cần lớn, kỹ thuật trồng và chăm sóc đơn giản, thời gian thu hồi vốn nhanh… cây nông nghiệp ngắn ngày nhận được sự quan tâm tìm hiểu của nhiều bà con nông dân.',
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
