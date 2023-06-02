import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:plant_process/model/processplant.dart';
import 'package:plant_process/model/utilities.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../../../../../model/plant_provider.dart';

class editKTT extends StatefulWidget {
  static String routeName = '/editKTT';
  final String id;

   editKTT({Key? key, required this.id}) : super(key: key);

  @override
  State<editKTT> createState() => _editKTTState();
}

class _editKTTState extends State<editKTT> {
  String url = Utilities.url;
  List<KyThuatTrong> kythuattrong = [];
  final _formKey = GlobalKey<FormState>();
  final _tenKyThuat = TextEditingController();
  final _moTa = TextEditingController();
  final _huongDan = TextEditingController();

  void getKTT() async {
    PlantProvider myProvider =
        Provider.of<PlantProvider>(context, listen: false);
    final response = await http.get(Uri.parse(
        '$url/api/process/${myProvider.id}/chamSoc/KTT/${widget.id}'));
    if (response.statusCode == 200) {
      print(response.body);
      final kyThuatTrong = jsonDecode(response.body);
      String tenKyThuat = kyThuatTrong['tenKyThuat'];
      String moTa = kyThuatTrong['moTa'];
      String huongDan = kyThuatTrong['huongDan'];

      setState(() {
        _huongDan.text = huongDan;
        _moTa.text = moTa;
        _tenKyThuat.text = tenKyThuat;
      });
    } else {
      print('Failed to fetch data. Error: ${response.statusCode}');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getKTT();
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
              child: Center(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 50,
                    ),
                    Container(
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            tenKTT(),
                            SizedBox(
                              height: 10,
                            ),
                            moTa(),
                            SizedBox(
                              height: 10,
                            ),
                            huongDan(),
                            ElevatedButton(
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  _formKey.currentState!.save();
                                  // await DatabaseHelper.instance.insertProcess(_process);
                                }
                              },
                              child: const Text('Lưu'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  TextFormField tenKTT() {
    return TextFormField(
      controller: _tenKyThuat,
      decoration: InputDecoration(
        hintText: 'Tên kỹ thuật',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        filled: true,
        fillColor: Colors.white,
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
      onSaved: (value) {
        _tenKyThuat.text = value!;
      },
    );
  }

  TextFormField moTa() {
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

  Widget huongDan() {
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
