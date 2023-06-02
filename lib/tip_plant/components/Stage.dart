import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:plant_process/model/utilities.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../../model/gieotrong.dart';
import '../../model/kythuattrong.dart';
import '../../model/phanbon.dart';
import '../../model/plant_provider.dart';
import '../../model/saubenh.dart';
import '../../model/thuhoach.dart';
import '../../model/thuyloi.dart';

class Stage extends StatefulWidget {
  final String image;
  final String name;

  const Stage({Key? key, required this.image, required this.name})
      : super(key: key);

  @override
  State<Stage> createState() => _StageState();
}

class _StageState extends State<Stage> {
  String url = Utilities.url;
  List<GieoTrong> gieoTrongList = [];
  List<String> chonGiongdata = [];
  List<KyThuatTrong> kythuattrong = [];
  List<PhanBon> danhSachPhanBon = [];
  List<sauBenh> saubenhList = [];
  List<thuHoach> thuhoachList = [];
  List<TuoiNuoc> tuoinuoclist = [];

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
        if (idplant == myProvider.id) {
          var chonGiong = p['cachTrong']['chonGiong'];
          print(chonGiong);
          var ngoaiCanh = gieotrongData['ngoaiCanh'];
          var mota = ngoaiCanh['moTa'];
          var huongDan = gieotrongData['thoiVu'];

          var gieoTrongObj = GieoTrong(
            ngoaiCanh: NgoaiCanh(
              nhietdo: ngoaiCanh['nhietDo'],
              anhSang: ngoaiCanh['anhSang'],
              nuoc: ngoaiCanh['nuoc'],
              doAm: ngoaiCanh['doAm'],
              chatLuongKK: ngoaiCanh['chatLuongKK'],
              moTaThem: ngoaiCanh['moTaThem'],
            ),
            thoiVu: huongDan,
          );
          setState(() {
            gieoTrongList.add(gieoTrongObj);
            chonGiongdata = [chonGiong];
          });
          break;
        }
      }
    }
  }

  void getKTT() async {
    PlantProvider myProvider =
        Provider.of<PlantProvider>(context, listen: false);

    final response = await http.get(Uri.parse('$url/api/process'));
    if (response.statusCode == 200) {
      final process = jsonDecode(response.body);
      var pro = process['process'];
      for (var p in pro) {
        var idplant = p['id_plant'];
        var phanBon = p['chamSoc']['kyThuatTrong'];
        if (idplant == myProvider.id) {
          for (var pb in phanBon) {
            var tenKyThuat = pb['tenKyThuat'];
            var moTa = pb['moTa'];
            var huongDan = pb['huongDan'];

            var phanBonObj = KyThuatTrong(
              tenKyThuat: tenKyThuat,
              moTa: moTa,
              img_KT: '',
              huongDan: huongDan,
              id: '',
            );
            setState(() {
              kythuattrong.add(phanBonObj);
            });
          }
          break;
        }
      }
    }
  }

  void getThuyloi() async {
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
            tuoinuoclist.add(tuoinuoc);
          });

          break;
        }
      }
    }
  }

  void getThuhoach() async {
    PlantProvider myProvider =
        Provider.of<PlantProvider>(context, listen: false);
    final response = await http.get(Uri.parse('$url/api/process'));
    if (response.statusCode == 200) {
      final process = jsonDecode(response.body);
      var pro = process['process'];
      for (var p in pro) {
        var idplant = p['id_plant'];
        var phanBon = p['chamSoc']['thuHoach'];
        if (idplant == myProvider.id) {
          var thoigianTH = phanBon['thoiGianTH'];
          var baoQuan = phanBon['baoQuan'];
          var noiDung = phanBon['noiDung'];
          print(thoigianTH);

          print(baoQuan);
          print(noiDung);
          var tuoinuoc = thuHoach(
              baoQuan: baoQuan, noiDung: noiDung, thoigianTH: thoigianTH);
          setState(() {
            thuhoachList.add(tuoinuoc);
          });

          break;
        }
      }
    }
  }

  void getPSB() async {
    PlantProvider myProvider =
        Provider.of<PlantProvider>(context, listen: false);

    final response = await http.get(Uri.parse('$url/api/process'));
    if (response.statusCode == 200) {
      final process = jsonDecode(response.body);
      var pro = process['process'];
      for (var p in pro) {
        var idplant = p['id_plant'];
        var saubenh = p['chamSoc']['phongSauBenh'];
        if (idplant == myProvider.id) {
          for (var pb in saubenh) {
            var cachPhongTru = pb['cachPhongTru'];
            var mota = pb['moTa'];
            var tenloaiSB = pb['tenLoaiSB'];
            var phanBonObj = sauBenh(
                cachPhongTru: cachPhongTru,
                mota: mota,
                tenloaiSB: tenloaiSB,
                id: '');
            setState(() {
              saubenhList.add(phanBonObj);
            });
          }
          break;
        }
      }
    }
  }

  void getPhanbon() async {
    PlantProvider myProvider =
        Provider.of<PlantProvider>(context, listen: false);

    final response = await http.get(Uri.parse('$url/api/process'));
    if (response.statusCode == 200) {
      final process = jsonDecode(response.body);
      var pro = process['process'];
      for (var p in pro) {
        var idplant = p['id_plant'];
        var phanBon = p['chamSoc']['phanBon'];
        if (idplant == myProvider.id) {
          for (var pb in phanBon) {
            var tenLoaiPhan = pb['tenLoaiPhan'];
            var mota = pb['moTa'];
            var huongDan = pb['huongDan'];
            print(tenLoaiPhan);
            print(mota);
            print(huongDan);

            var phanBonObj = PhanBon(
              tenLoaiPhan: tenLoaiPhan,
              moTa: mota,
              img_PB: '',
              huongDan: huongDan,
            );
            setState(() {
              danhSachPhanBon.add(phanBonObj);
            });
          }
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
    getPhanbon();
    getThuhoach();
    getThuyloi();
    getKTT();
    getPSB();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
        leading: IconButton(
          color: Colors.white,
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: const Color(0xff91CD00),
        centerTitle: true,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFC1FD2D),
              Color(0xFFFFFFFF),
            ],
          ),
        ),
        child: Container(
          padding: EdgeInsets.all(16),
          child: Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 90,
                    decoration: BoxDecoration(
                      color: Color(0x50FFFFFF),
                    ),
                    child: Image(
                      image: NetworkImage(widget.image),
                    ),
                  ),
                  SizedBox(height: 16),
                  // Hiển thị dữ liệu từ danh sách chonGiongdata
                  Text(
                    'Chọn giống:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Column(
                    children: chonGiongdata.map((item) {
                      return Text(item);
                    }).toList(),
                  ),
                  SizedBox(height: 16),
                  // Hiển thị dữ liệu từ danh sách gieoTrongList
                  Text(
                    'Gieo Trồng:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Column(
                    children: gieoTrongList.map((item) {
                      return Column(
                        children: [
                          Text('Ngoại cảnh:'),
                          Text('Nhiệt độ: ${item.ngoaiCanh.nhietdo}'),
                          Text('Ánh sáng: ${item.ngoaiCanh.anhSang}'),
                          // Hiển thị các thuộc tính khác của ngoaiCanh
                          SizedBox(height: 16),
                          Text('Hướng dẫn gieo trồng:'),
                          Text(item.thoiVu),
                          // Hiển thị các thuộc tính khác của thoiVu
                          SizedBox(height: 16),
                        ],
                      );
                    }).toList(),
                  ),
                  SizedBox(height: 16),
                  // Hiển thị dữ liệu từ danh sách tuoinuoclist
                  Text(
                    'Tuổi nước:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Column(
                    children: tuoinuoclist.map((item) {
                      return Column(
                        children: [
                          Text('Ngày tưới: ${item.ngayTuoi}'),
                          Text('Thời gian tưới: ${item.thoiGianTuoi}'),
                          // Hiển thị các thuộc tính khác của tuoinuoc
                          SizedBox(height: 16),
                        ],
                      );
                    }).toList(),
                  ),
                  SizedBox(height: 16),
                  // Hiển thị dữ liệu từ danh sách kythuattrong
                  Text(
                    'Kỹ thuật trồng:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Column(
                    children: kythuattrong.map((item) {
                      return Column(
                        children: [
                          Text('Tên kỹ thuật: ${item.tenKyThuat}'),
                          Text('Mô tả: ${item.moTa}'),
                          // Hiển thị các thuộc tính khác của kythuattrong
                          SizedBox(height: 16),
                        ],
                      );
                    }).toList(),
                  ),
                  SizedBox(height: 16),
                  // Hiển thị dữ liệu từ danh sách danhSachPhanBon
                  Text(
                    'Danh sách phân bón:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Column(
                    children: danhSachPhanBon.map((item) {
                      return Column(
                        children: [
                          Text('Tên phân bón: ${item.tenLoaiPhan}'),
                          Text('Hướng dẫn: ${item.huongDan}'),
                          Text('Hướng dẫn: ${item.moTa}'),

                          // Hiển thị các thuộc tính khác của phanBon
                          SizedBox(height: 16),
                        ],
                      );
                    }).toList(),
                  ),
                  SizedBox(height: 16),
                  // Hiển thị dữ liệu từ danh sách saubenhList
                  Text(
                    'Sâu bệnh:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Column(
                    children: saubenhList.map((item) {
                      return Column(
                        children: [
                          Text('Tên loại sâu bệnh: ${item.tenloaiSB}'),
                          Text('Cách phòng trừ: ${item.cachPhongTru}'),
                          Text('Mô tả: ${item.mota}'),

                          // Hiển thị các thuộc tính khác của saubenh
                          SizedBox(height: 16),
                        ],
                      );
                    }).toList(),
                  ),
                  SizedBox(height: 16),
                  // Hiển thị dữ liệu từ danh sách thuhoachList
                  Text(
                    'Thu hoạch:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Column(
                    children: thuhoachList.map((item) {
                      return Column(
                        children: [
                          Text('Thời gian thu hoạch: ${item.thoigianTH}'),
                          Text('Nội dung: ${item.noiDung}'),
                          Text('Bảo quản: ${item.baoQuan}'),

                          // Hiển thị các thuộc tính khác của thuhoach
                          SizedBox(height: 16),
                        ],
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ),
        )
      ),
    );
  }
}
