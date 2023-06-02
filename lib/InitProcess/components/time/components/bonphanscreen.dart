import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:plant_process/model/processplant.dart';

import '../../../../model/plant_provider.dart';
import '../../../../model/utilities.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dio/dio.dart';

import '../../../../provider/progressbar.dart';

class BonPhanScreen extends StatefulWidget {
  final DateTime dateFrom;
  final DateTime dateTo;
  final int selectedWeekIndex;

  const BonPhanScreen(
      {Key? key,
      required this.dateFrom,
      required this.dateTo,
      required this.selectedWeekIndex})
      : super(key: key);

  @override
  State<BonPhanScreen> createState() => _BonPhanScreenState();
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

class _BonPhanScreenState extends State<BonPhanScreen> {
  String url = Utilities.url;
  final _formKey = GlobalKey<FormState>();
  final _tenLoaiPhan = TextEditingController();
  final _moTa = TextEditingController();
  final _huongDan = TextEditingController();
  String imagePath = '';

  void uploadBonphan() async {
    PlantProvider myProvider =
        Provider.of<PlantProvider>(context, listen: false);
    final idPlant = myProvider.id;
    String tenLoaiPhan = _tenLoaiPhan.text;
    String moTa = _moTa.text;
    String huongDan = _huongDan.text;
    PhanBon phanBon = PhanBon(
        tenLoaiPhan: tenLoaiPhan,
        moTa: moTa,
        imgPB: imagePath,
        huongDan: huongDan);

    final response = await http.get(Uri.parse('$url/api/process/'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final plants = data['process'];
      final processExists =
          plants.any((plant) => plant['id_plant'] == myProvider.id);
      if (processExists) {
        Dio dio = Dio();
        FormData formData = FormData.fromMap({
          'tenLoaiPhan': tenLoaiPhan,
          'moTa': moTa,
          'img_PB': await MultipartFile.fromFile(imagePath, filename: imagePath),
          'huongDan': huongDan,
        });
        final res = await dio.post(
          '$url/api/process/$idPlant/chamSoc/phanBon',
          data: formData,
        );

        if (res.statusCode == 200) {
          print(res.data);
        }
      } else {
        print('Process does not exist for plant with ID: ${myProvider.id}');
      }
    } else {
      print('Failed to fetch data. Error: ${response.statusCode}');
    }
  }

  void getPhanbon() async {
    final resPB = await http.get(
        Uri.parse('$url/api/process/645747397cd1a83b835adb0d/chamSoc/phanBon'));
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
                                  Provider.of<ProgressProvider>(context, listen: false).updateProgress();
                                  Navigator.pop(context);  }
                              },
                              child: Text('Lưu'),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () async {
                              // Tải hình ảnh từ thiết bị
                              // final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
                              // Chụp hình
                              final pickedFile = await ImagePicker()
                                  .getImage(source: ImageSource.camera);

                              // Xử lý pickedFile
                              if (pickedFile != null) {
                                // Đường dẫn hình ảnh
                                imagePath = pickedFile.path;

                                // Tiếp tục xử lý hình ảnh tại đây (ví dụ: upload lên server)
                                // ...
                              } else {
                                // Không có hình ảnh được chọn hoặc chụp
                              }
                            },
                            child: Text('Chụp hình ảnh'),
                          ),
                        ),
                        Expanded(
                            child: ElevatedButton(
                          onPressed: () async {
                            // Tải hình ảnh từ thiết bị
                            final pickedFile = await ImagePicker()
                                .pickImage(source: ImageSource.gallery);

                            // Chụp hình
                            // final pickedFile = await ImagePicker().getImage(source: ImageSource.camera);

                            // Xử lý pickedFile
                            if (pickedFile != null) {
                              // Đường dẫn hình ảnh
                              imagePath = pickedFile.path;

                              // Tiếp tục xử lý hình ảnh tại đây (ví dụ: upload lên server)
                              // ...
                            } else {
                              // Không có hình ảnh được chọn hoặc chụp
                            }
                          },
                          child: Text('Chọn hình ảnh từ thiết bị'),
                        )),
                      ],
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

  TextFormField thoiGianTH() {
    return TextFormField(
      controller: _tenLoaiPhan,
      decoration: const InputDecoration(
        hintText: "Tên loại phân",
      ),
      onSaved: (pass) {
        _tenLoaiPhan.text = pass!;
      },
    );
  }

  TextFormField baoQuan() {
    return TextFormField(
      controller: _moTa,
      decoration: const InputDecoration(
        labelText: "Mô tả",
      ),
      onSaved: (pass) {
        _moTa.text = pass!;
      },
    );
  }

  TextFormField noiDung() {
    return TextFormField(
      controller: _huongDan,
      decoration: const InputDecoration(
        labelText: "Hướng dẫn",
      ),
      onSaved: (pass) {
        _huongDan.text = pass!;
      },
    );
  }
}
