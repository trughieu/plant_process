import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:plant_process/InitProcess/components/classificationProcess/classification_process_page.dart';
import 'package:plant_process/InitProcess/components/time/components/edit/mission.dart';
import 'package:plant_process/InitProcess/components/time/components/edit/thuhoach.dart';
import 'package:plant_process/model/processplant.dart';
import 'package:plant_process/tip_plant/components/select_plant.dart';

import '../../model/item.dart';
import '../../model/plant_model.dart';
import '../../model/plant_provider.dart';
import '../../model/process.dart';
import '../../model/utilities.dart';
import 'package:provider/provider.dart';

class ItemListWidget extends StatefulWidget {
  static String routeName = "/manage";

  @override
  _ItemListWidgetState createState() => _ItemListWidgetState();
}

class _ItemListWidgetState extends State<ItemListWidget> {
  String uri = Utilities.url;
  List<Process> process = [];

  void getProcess() async {
    final response = await http.get(Uri.parse('$uri/api/process'));
    if (response.statusCode == 200) {
      print(response.body);
      final body = jsonDecode(response.body);
      var processes = body['process'];
      // collection plant
      final plantResponse = await http.get(Uri.parse('$uri/api/plant'));
      if (plantResponse.statusCode == 200) {
        final plantBody = jsonDecode(plantResponse.body);
        var plants = plantBody['plant'];
        for (var e in plants) {}
        //Loop
        for (var pro in processes) {
          var p = Process.fromJson(pro);
          // find the img plant for this process
          var plant = plants.firstWhere((pl) => pl['_id'] == pro['id_plant'],
              orElse: () => null);

          if (plant != null) {
            // Build the complete URL to the image
            var imgUri = Uri.parse(uri).resolve(plant['img_av']).toString();
            var name = plant['name'].toString();
            var des = plant['description'].toString();
            // Load the image and store it in the process object
            p.image = imgUri.toString();
            p.name = name;
            p.description = des;
          }
          setState(() {
            // add vao list Process
            process.add(p);
          });
        }
      }
    }
  }

  void deleteProcess(String id) async {
    final response = await http.delete(Uri.parse('$uri/api/process/$id'));
    if (response.statusCode == 200) {
      print(response.body);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getProcess();
  }

  String? selectedProcessId;

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
        title: const Text("Chọn giống"),
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
        child: ListView.builder(
          itemCount: process.length,
          itemBuilder: (context, index) {
            Process item = process[index];

            return Card(
                color: Colors.white,
                child: ListTile(
                  title: Text(item.name.toString()),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit),
                        color: Colors.red,
                        onPressed: () {
                          selectedProcessId = item.id_plant;
                          Provider.of<PlantProvider>(context, listen: false)
                              .setId(selectedProcessId.toString());
                          Navigator.pushNamed(context, editMission.routeName);
                          // Xử lý sự kiện chỉnh sửa mục
                          // Ví dụ: Navigator.push để chuyển đến màn hình chỉnh sửa
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        color: Colors.red,
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Text('Xác nhận'),
                              content: Text('Bạn có chắc muốn xoá mục này?'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    setState(() {
                                      selectedProcessId = item.id_plant;
                                      deleteProcess(selectedProcessId!);
                                      process.removeAt(index);
                                    });
                                    Navigator.pop(context);
                                  },
                                  child: Text('Đồng ý'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text('Hủy'),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ));
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        onPressed: () {
          Navigator.pushNamed(context, Select_plant.routeName);

          // Xử lý sự kiện khi nhấn nút floating action button
        },
        child: Icon(
          Icons.add,
        ),
      ),
    );
  }
}
