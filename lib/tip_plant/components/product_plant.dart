import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:plant_process/InitProcess/components/classificationProcess/classification_process_page.dart';
import 'package:plant_process/model/processplant.dart';

import '../../model/plant_model.dart';
import '../../model/plant_provider.dart';
import '../../model/process.dart';
import '../../model/utilities.dart';
import 'package:provider/provider.dart';

//
// class Product_plant extends StatelessWidget {
//   Product_plant({Key? key}) : super(key: key);

class Product_plant extends StatefulWidget {
  Product_plant({Key? key}) : super(key: key);

  @override
  State<Product_plant> createState() => _Product_plantState();
}

class _Product_plantState extends State<Product_plant> {
  String uri = Utilities.url;
  List<Plants_model> plants = [];
  int selectedIndex = -1;
  String? selectedProductId;

  void getProduct() async {
    final response = await http.get(Uri.parse('$uri/api/plant'));
    if (response.statusCode == 200) {
      print(response.body);
      final body = jsonDecode(response.body);
      var plant = body['plant'];
      for (var p in plant) {
        setState(() {
          plants.add(Plants_model.fromJson(p as Map<String, dynamic>));
        });
        for (int i = 0; i < plants.length; i++) {
          plants[i].img = Image.network('$uri/${plants[i].img_av}');
        }
      }
    }
  }

  void selectItem(int index) {
    setState(() {
      if (selectedIndex == index) {
        // if the same item is selected again, deselect it
        selectedIndex = -1;
        selectedProductId = null;
      } else {
        // select a different item
        selectedIndex = index;
        selectedProductId = plants[index].id;
      }
    });
  }

  //
  // void postProcess(String id) async {
  //   bool idExists = await checkIfIdExists(id);
  //   ProcessPlant process = ProcessPlant(
  //     idPlant: id,
  //     cachTrong: CachTrong(
  //       chonGiong: '',
  //       gieoTrong: GieoTrong(
  //         thoiVu: '',
  //         ngoaiCanh: NgoaiCanh(
  //           nhietDo: '',
  //           anhSang: '',
  //           nuoc: '',
  //           doAm: '',
  //           chatLuongKK: '',
  //           moTaThem: '',
  //         ),
  //       ),
  //     ),
  //     chamSoc: ChamSoc(
  //       tuoiNuoc: TuoiNuoc(
  //         ngayTuoi: '',
  //         thoiGianTuoi: '',
  //         huongDan: '',
  //       ),
  //       kyThuatTrong: [
  //         KyThuatTrong(
  //           tenKyThuat: '',
  //           moTa: '',
  //           imgKT: '',
  //           huongDan: '',
  //         ),
  //       ],
  //       phanBon: [
  //         PhanBon(
  //           tenLoaiPhan: '',
  //           moTa: '',
  //           imgPB: '',
  //           huongDan: '',
  //         ),
  //       ],
  //       phongSauBenh: [
  //         PhongSauBenh(
  //           tenLoaiSB: '',
  //           moTa: '',
  //           cachPhongTru: '',
  //         ),
  //       ],
  //       thuHoach: ThuHoach(
  //         thoiGianTH: '',
  //         baoQuan: '',
  //         noiDung: '',
  //       ),
  //     ),
  //   );
  //   if (idExists) {
  //     print(idExists);
  //     // Nếu id đã tồn tại, thực hiện cập nhật dữ liệu
  //     final res = await http.put(
  //       Uri.parse('$uri/api/process/$id'),
  //       headers: {'Content-Type': 'application/json'},
  //       body: json.encode(process.toJson()),
  //     );
  //
  //     if (res.statusCode == 200) {
  //       print(res.body);
  //     } else {
  //       print(res.body);
  //       throw Exception('Failed to update');
  //     }
  //   } else {
  //     // Nếu id chưa tồn tại, thực hiện tạo dữ liệu mới
  //     final res = await http.post(
  //       Uri.parse('$uri/api/process'),
  //       headers: {'Content-Type': 'application/json'},
  //       body: json.encode(process.toJson()),
  //     );
  //
  //     if (res.statusCode == 200) {
  //       print(res.body);
  //     } else {
  //       print(res.body);
  //       throw Exception('Failed to upload');
  //     }
  //   }
  // }

  void postProcess(String id) async {
    bool idExists = await checkIfIdExists(id);
    ProcessPlant process = ProcessPlant(
      idPlant: id,
      cachTrong: CachTrong(
        chonGiong: '',
        gieoTrong: GieoTrong(
          thoiVu: '',
          ngoaiCanh: NgoaiCanh(
              nhietDo: '',
              anhSang: '',
              nuoc: '',
              doAm: '',
              chatLuongKK: '',
              moTaThem: ''),
        ),
      ),
      chamSoc: ChamSoc(
        tuoiNuoc: TuoiNuoc(
          ngayTuoi: '',
          thoiGianTuoi: '',
          huongDan: '',
        ),
        kyThuatTrong: [],
        phanBon: [],
        phongSauBenh: [],
        thuHoach: ThuHoach(
          thoiGianTH: '',
          baoQuan: '',
          noiDung: '',
        ),
      ), loaiCay: '',
    );

    if (idExists) {
      print(idExists);
      // Nếu id đã tồn tại, thực hiện cập nhật dữ liệu
      // final res = await http.put(
      //   Uri.parse('$uri/api/process/$id'),
      //   headers: {'Content-Type': 'application/json'},
      //   body: json.encode(process.toJson()),
      // );
      //
      // if (res.statusCode == 200) {
      //   print(res.body);
      // } else {
      //   print(res.body);
      //   throw Exception('Failed to update');
      // }
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: Text('Quy trình này đã có'),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                });
                Navigator.pop(context);
              },
              child: Text('Đồng ý'),
            ),
          ],
        ),
      );
    } else {
      // Nếu id chưa tồn tại, thực hiện tạo dữ liệu mới
      final res = await http.post(
        Uri.parse('$uri/api/process'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(process.toJson()),
      );

      if (res.statusCode == 200) {
        Navigator.pushNamed(
            context, ClassificationProcesssPage.routeName);
        print(res.body);
      } else {
        print(res.body);
        throw Exception('Failed to upload');
      }
    }
  }

  Future<bool> checkIfIdExists(String id) async {
    final res = await http.get(Uri.parse('$uri/api/process/$id'));

    if (res.statusCode == 200) {
      final data = json.decode(res.body);
      print(data);
      // Dữ liệu đã tồn tại
      return true;
    } else if (res.statusCode == 404) {
      // Dữ liệu không tồn tại
      print('khong ton tai');
      return false;
    } else {
      throw Exception('Failed to check id existence');
    }
  }

// const ProductPopular({Key? key}) : super(key: key);
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getProduct();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(30),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            child: GridView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                primary: false,
                itemCount: plants.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    childAspectRatio: 0.7),
                itemBuilder: (context, index) {
                  return ProductItem(
                      plant: plants[index],
                      isSelected: index == selectedIndex,
                      onTap: () {
                        selectItem(index);
                        print(plants[index].id);
                      });
                }),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              if (selectedProductId != null) {
                // checkIfIdExists(selectedProductId.toString());
                postProcess(selectedProductId.toString());
                Provider.of<PlantProvider>(context, listen: false)
                    .setId(selectedProductId.toString());

                print(selectedProductId);
              }

              // handle button click event
            },
            child: const Text('Next'),
          ),
        ],
      ),
    );
  }
}

class ProductItem extends StatelessWidget {
  final Plants_model plant;
  final bool isSelected;
  final VoidCallback onTap;

  ProductItem(
      {Key? key,
      required this.plant,
      this.isSelected = false,
      required this.onTap})
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
              shape: BoxShape.circle,
              border: Border.all(
                color: isSelected ? Colors.yellow : Colors.transparent,
                width: 3,
              ),
            ),
            child: SizedBox(
              height: 80,
              width: 80,
              child: plant.img_av == null
                  ? const CircularProgressIndicator()
                  : plant.img!,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            plant.name,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
