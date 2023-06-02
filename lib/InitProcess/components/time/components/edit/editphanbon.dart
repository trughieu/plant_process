import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:plant_process/model/processplant.dart';

import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dio/dio.dart';

import '../../../../../model/plant_provider.dart';
import '../../../../../model/utilities.dart';
import '../../../../../provider/progressbar.dart';

class editPhanBon extends StatefulWidget {
  final String id;
  static String routeName = '/editPhanbon';

  const editPhanBon({Key? key, required this.id}) : super(key: key);

  @override
  State<editPhanBon> createState() => _editPhanBonState();
}

class _editPhanBonState extends State<editPhanBon> {
  String url = Utilities.url;
  final _formKey = GlobalKey<FormState>();
  final _tenLoaiPhan = TextEditingController();
  final _moTa = TextEditingController();
  final _huongDan = TextEditingController();
  String imagePath = '';
  List<PhanBon> danhSachPhanBon = [];
  List<String> phanbon = [];

  void getPhanbon() async {
    PlantProvider myProvider =
        Provider.of<PlantProvider>(context, listen: false);
    final response = await http.get(Uri.parse(
        '$url/api/process/${myProvider.id}/chamSoc/phanBon/${widget.id}'));
    if (response.statusCode == 200) {
      print(response.body);
      final pb = jsonDecode(response.body);
      var tenLoaiPhan = pb['tenLoaiPhan'];
      var mota = pb['moTa'];
      var huongDan = pb['huongDan'];
      var imgUri = Uri.parse(url).resolve(pb['img_PB']).toString();

      setState(() {
        _huongDan.text = huongDan;
        _moTa.text = mota;
        _tenLoaiPhan.text = tenLoaiPhan;
        phanbon = [imgUri];
      });
    } else {
      print('Failed to fetch data. Error: ${response.statusCode}');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPhanbon();
  }

  bool isImageSelected() {
    return imagePath.isNotEmpty;
  }

  void updatePhanBon() async {
    PlantProvider myProvider = Provider.of<PlantProvider>(context, listen: false);
    final response = await http.put(
      Uri.parse('$url/api/process/${myProvider.id}/chamSoc/phanBon/${widget.id}'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'tenLoaiPhan': _tenLoaiPhan.text,
        'moTa': _moTa.text,
        'huongDan': _huongDan.text,
        'img_PB': phanbon.isNotEmpty ? phanbon[0] : '',
      }),
    );

    if (response.statusCode == 200) {
      print('PhanBon updated successfully');
    } else {
      print('Failed to update PhanBon. Error: ${response.statusCode}');
    }
  }

  void updatePb() async {
    PlantProvider myProvider =
    Provider.of<PlantProvider>(context, listen: false);
    final idPlant = myProvider.id;
    String tenLoaiPhan = _tenLoaiPhan.text;
    String moTa = _moTa.text;
    String huongDan = _huongDan.text;

    Dio dio = Dio();
    FormData formData = FormData.fromMap({
      'tenLoaiPhan': tenLoaiPhan,
      'moTa': moTa,
      'img_PB':
      await MultipartFile.fromFile(imagePath, filename: imagePath),
      'huongDan': huongDan,
    });

    final res = await dio.put(
      '$url/api/process/$idPlant/chamSoc/phanBon/${widget.id}',
      data: formData,
    );

    if (res.statusCode == 200) {
      print(res.data);
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
          "Phân bón",
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
              child: Center(
                child: Column(
                  children: [
                    SizedBox(
                      height: 50,
                    ),
                    Container(
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            SizedBox(
                              child: phanbon.isNotEmpty
                                  ? Image(
                                      image: NetworkImage(phanbon[0]),
                                    )
                                  : CircularProgressIndicator(),
                              height: 100,
                            ),
                            thoiGianTH(),
                            SizedBox(
                              height: 10,
                            ),
                            baoQuan(),
                            SizedBox(
                              height: 10,
                            ),
                            noiDung(),
                            ElevatedButton(
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  _formKey.currentState!.save();
                                  if (isImageSelected()) {
                                    // uploadBonphan();
                                    updatePb();
                                    Navigator.pop(context);
                                  } else {
                                    showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        title: Text('Lỗi'),
                                        content: Text(
                                            'Vui lòng chọn hình ảnh trước khi lưu.'),
                                        actions: [
                                          TextButton(
                                            child: Text('Đóng'),
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                          ),
                                        ],
                                      ),
                                    );
                                  }
                                }
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
      decoration: InputDecoration(
        hintText: 'Tên loại phân',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        filled: true,
        fillColor: Colors.white,
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
      onSaved: (value) {
        _tenLoaiPhan.text = value!;
      },
    );
  }

  TextFormField baoQuan() {
    return TextFormField(
      controller: _moTa,
      decoration: InputDecoration(
        labelText: 'Mô tả',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        filled: true,
        fillColor: Colors.white,
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
      onSaved: (value) {
        _moTa.text = value!;
      },
    );
  }

  TextFormField noiDung() {
    return TextFormField(
      controller: _huongDan,
      decoration: InputDecoration(
        labelText: 'Hướng dẫn',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        filled: true,
        fillColor: Colors.white,
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
      onSaved: (value) {
        _huongDan.text = value!;
      },
    );
  }
}
