import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:plant_process/model/processplant.dart';
import 'package:plant_process/model/utilities.dart';
import 'package:http/http.dart' as http;

import 'package:provider/provider.dart';

import '../../../../../model/plant_provider.dart';

class editGieoTrong extends StatefulWidget {
  static String routeName = '/editGieotrong';

  const editGieoTrong({Key? key}) : super(key: key);

  @override
  State<editGieoTrong> createState() => _editGieoTrongState();
}

class _editGieoTrongState extends State<editGieoTrong> {
  String url = Utilities.url;
  final _formKey = GlobalKey<FormState>();
  final _nhietDo = TextEditingController();
  final _anhSang = TextEditingController();
  final _nuoc = TextEditingController();
  final _doAm = TextEditingController();
  final _chatLuongKk = TextEditingController();
  final _moTaThem = TextEditingController();
  final _thoiVu = TextEditingController();
  List<GieoTrong> gieoTrongList = [];

  void getGieoTrong() async {
    PlantProvider myProvider =
        Provider.of<PlantProvider>(context, listen: false);
    final response = await http.get(Uri.parse('$url/api/process'));
    if (response.statusCode == 200) {
      final process = jsonDecode(response.body);
      var pro = process['process'];
      for (var p in pro) {
        var idplant = p['id_plant'];
        var gieotrongData = p['cachTrong']['gieoTrong'];
        print("1112$gieotrongData");
        if (idplant == myProvider.id) {
          var tenLoaiPhan = gieotrongData['chonGiong'];
          var ngoaiCanh = gieotrongData['ngoaiCanh'];
          var mota = ngoaiCanh['moTa'];
          var thoivu = gieotrongData['thoiVu'];
          print("aa$tenLoaiPhan");
          print(mota);

          var gieoTrongObj = GieoTrong(
            ngoaiCanh: NgoaiCanh(
              nhietDo: ngoaiCanh['nhietDo'],
              anhSang: ngoaiCanh['anhSang'],
              nuoc: ngoaiCanh['nuoc'],
              doAm: ngoaiCanh['doAm'],
              chatLuongKK: ngoaiCanh['chatLuongKK'],
              moTaThem: ngoaiCanh['moTaThem'],
            ),
            thoiVu: thoivu,
          );
          setState(() {
            _nhietDo.text = ngoaiCanh['nhietDo'];
            _anhSang.text = ngoaiCanh['anhSang'];
            _nuoc.text = ngoaiCanh['nuoc'];
            _doAm.text = ngoaiCanh['doAm'];
            _chatLuongKk.text = ngoaiCanh['chatLuongKK'];
            _moTaThem.text = ngoaiCanh['moTaThem'];
          });
          break;
        }
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getGieoTrong();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
                    SingleChildScrollView(
                      child: Container(
                        child: Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              nhietDo(),
                              SizedBox(height: 10,),
                              anhSang(),
                              SizedBox(height: 10,),
                              nuoc(),
                              SizedBox(height: 10,),
                              doAm(),
                              SizedBox(height: 10,),
                              chatLuongKK(),
                              SizedBox(height: 10,),
                              moTa(),
                              ElevatedButton(
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                    _formKey.currentState!.save();
                                    // await DatabaseHelper.instance.insertProcess(_process);
                                  }
                                },
                                child: Text('Lưu'),
                              ),
                            ],
                          ),
                        ),
                      ),
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

  Widget nhietDo() {
    return TextFormField(
      controller: _nhietDo,
      decoration: InputDecoration(
        labelText: 'Nhiệt độ',
        hintText: 'Thời gian thu hoạch',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        filled: true,
        fillColor: Colors.white,
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
      textInputAction: TextInputAction.newline,
      onSaved: (value) {
        _nhietDo.text = value!;
      },
    );
  }

  Widget anhSang() {
    return TextFormField(
      controller: _anhSang,
      decoration: InputDecoration(
        labelText: 'Ánh sáng',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        filled: true,
        fillColor: Colors.white,
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
      onSaved: (value) {
        setState(() {
          _anhSang.text = value!;
        });
        // Xử lý sự kiện khi giá trị thay đổi
      },
    );
  }

  Widget nuoc() {
    return TextFormField(
      controller: _nuoc,
      decoration: InputDecoration(
        labelText: 'Nước',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        filled: true,
        fillColor: Colors.white,
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
      onSaved: (value) {
        setState(() {
          _nuoc.text = value!;
        });
        // Xử lý sự kiện khi giá trị thay đổi
      },
    );
  }

  Widget doAm() {
    return TextFormField(
      controller: _doAm,
      decoration: InputDecoration(
        labelText: 'Độ ẩm',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        filled: true,
        fillColor: Colors.white,
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
      onSaved: (value) {
        setState(() {
          _doAm.text = value!;
        });
        // Xử lý sự kiện khi giá trị thay đổi
      },
    );
  }

  Widget chatLuongKK() {
    return TextFormField(
      controller: _chatLuongKk,
      decoration: InputDecoration(
        labelText: 'Chất lượng không khí',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        filled: true,
        fillColor: Colors.white,
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
      onSaved: (value) {
        setState(() {
          _chatLuongKk.text = value!;
        });
        // Xử lý sự kiện khi giá trị thay đổi
      },
    );
  }

  Widget moTa() {
    return TextFormField(
      controller: _moTaThem,
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
        setState(() {
          _moTaThem.text = value!;
        });
        // Xử lý sự kiện khi giá trị thay đổi
      },
    );
  }

  Widget thoiVu() {
    return TextFormField(
      controller: _thoiVu,
      decoration: InputDecoration(
        labelText: 'Nội dung',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        filled: true,
        fillColor: Colors.white,
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
      onSaved: (value) {
        setState(() {
          _thoiVu.text = value!;
        });
        // Xử lý sự kiện khi giá trị thay đổi
      },
    );
  }
}
