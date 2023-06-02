import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:plant_process/model/processplant.dart';
import 'package:plant_process/model/utilities.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../../../../../model/plant_provider.dart';

class editThuyLoi extends StatefulWidget {
  static String routeName = '/editThuyloi';

  const editThuyLoi({Key? key}) : super(key: key);

  @override
  State<editThuyLoi> createState() => _editThuyLoiState();
}

class _editThuyLoiState extends State<editThuyLoi> {
  String url = Utilities.url;
  List<TuoiNuoc> tuoinuoclist = [];
  final _formKey = GlobalKey<FormState>();
  final _ngayTuoi = TextEditingController();
  final _thoiGianTuoi = TextEditingController();
  final _huongDan = TextEditingController();

  void getThuyLoi() async {
    PlantProvider myProvider =
        Provider.of<PlantProvider>(context, listen: false);

    final response = await http.get(Uri.parse('$url/api/process'));
    if (response.statusCode == 200) {
      final process = jsonDecode(response.body);
      var pro = process['process'];
      for (var p in pro) {
        var idplant = p['id_plant'];
        var phanBon = p['chamSoc']['tuoiNuoc'];
        if (idplant == myProvider.id) {
          var ngaytuoi = phanBon['ngayTuoi'];
          var thoigian = phanBon['thoiGianTuoi'];
          var huongDan = phanBon['huongDan'];

          var tuoinuoc = TuoiNuoc(
              huongDan: huongDan, thoiGianTuoi: thoigian, ngayTuoi: ngaytuoi);
          setState(() {
            _ngayTuoi.text = ngaytuoi;
            _thoiGianTuoi.text = thoigian;
            _huongDan.text = huongDan;
          });

          break;
        }
      }
    }
  }

  void updateThuyLoi() async {
    PlantProvider myProvider =
        Provider.of<PlantProvider>(context, listen: false);

    TuoiNuoc tuoiNuoc = TuoiNuoc(
        ngayTuoi: _ngayTuoi.text,
        thoiGianTuoi: _thoiGianTuoi.text,
        huongDan: _huongDan.text);

    final response = await http.get(Uri.parse('$url/api/process/'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final plants = data['process'];
      final processExists =
          plants.any((plant) => plant['id_plant'] == myProvider.id);
      if (processExists) {
        print(processExists);
        final res = await http.put(
          Uri.parse('$url/api/process/${myProvider.id}/chamSoc/tuoiNuoc'),
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
  void initState() {
    // TODO: implement initState
    super.initState();
    getThuyLoi();
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
          "Thuỷ lợi",
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
                            ngayTuoi(),
                            SizedBox(
                              height: 10,
                            ),
                            thoiGianTuoi(),
                            SizedBox(
                              height: 10,
                            ),
                            huongDan(),
                            ElevatedButton(
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  _formKey.currentState!.save();
                                  updateThuyLoi();
                                  Navigator.pop(context);
                                  // await DatabaseHelper.instance.insertProcess(_process);
                                }
                              },
                              child: Text('Lưu'),
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

  TextFormField ngayTuoi() {
    return TextFormField(
      controller: _ngayTuoi,
      decoration: InputDecoration(
        labelText: 'Ngày Tưới',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        filled: true,
        fillColor: Colors.white,
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
      onSaved: (value) {
        _ngayTuoi.text = value!;
      },
    );
  }

  TextFormField thoiGianTuoi() {
    return TextFormField(
      controller: _thoiGianTuoi,
      decoration: InputDecoration(
        labelText: 'Thời gian tưới',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        filled: true,
        fillColor: Colors.white,
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
      onSaved: (value) {
        _thoiGianTuoi.text = value!;
      },
    );
  }

  TextFormField huongDan() {
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
