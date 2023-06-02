import 'package:flutter/material.dart';
import 'package:plant_process/InitProcess/components/classificationProcess/tabLayout_classification.dart';
import 'package:plant_process/InitProcess/components/time/timePlant.dart';
import 'package:plant_process/model/processplant.dart';

import '../../../model/plant_provider.dart';
import '../../../progressbar.dart';
import '../../../provider/progressbar.dart';
import 'package:provider/provider.dart';
import 'dart:convert';

import 'package:plant_process/model/classify.dart';

import '../../../model/utilities.dart';
import 'package:http/http.dart' as http;

class ClassificationProcesssPage extends StatefulWidget {
  static String routeName = '/classificationProcess';

  const ClassificationProcesssPage({Key? key}) : super(key: key);

  @override
  State<ClassificationProcesssPage> createState() =>
      _ClassificationProcesssPageState();
}

class _ClassificationProcesssPageState extends State<ClassificationProcesssPage>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    getClassify();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.animateTo(1);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  String uri = Utilities.url;
  List<Classify> classify = [];
  List<Widget> _views = [];
  List<Tab> _tabs = [];
  int selectedIndex = 0;
  List<String> _idList = []; // Danh sách lưu trữ các giá trị _id

  void getClassify() async {
    final res = await http.get(Uri.parse('$uri/api/classify'));
    if (res.statusCode == 200) {
      print(res.body);
      final body = jsonDecode(res.body);
      var loaiCay = body['classify'];
      List<Widget> updatedViews = [];
      List<Tab> updatedTabs = [];

      for (var p in loaiCay) {
        var classifyData = Classify.fromJson(p as Map<String, dynamic>);
        var textWidget = Center(child: Text(classifyData.des));
        var textTabs = Tab(
          child: Text(
            classifyData.title,
          ),
        );
        updatedViews.add(textWidget);
        updatedTabs.add(textTabs);
        String id = classifyData.id;
        _idList.add(id);
        print(id);
      }
      setState(() {
        _views = updatedViews;
        _tabs = updatedTabs;
        _idList;
      });
    } else {
      print('fal');
    }
  }

  void UpdateClassify(String loaicay) async {
    PlantProvider myProvider =
        Provider.of<PlantProvider>(context, listen: false);
    final res = await http.post(
      Uri.parse('$uri/api/process'),
      body: {'id_plant': myProvider.id, 'loaiCay': loaicay},
    );
    if (res.statusCode == 200) {
      print(res.body);
    } else {
      print("falsas");
    }
  }
  List<String> getTextDataFromViews() {
    List<String> textDataList = [];

    for (Widget view in _views) {
      String textData = '';

      if (view is Center) {
        Center centerWidget = view;

        if (centerWidget.child is Text) {
          Text textWidget = centerWidget.child as Text;
          textData = textWidget.data ?? '';
        }
      }

      textDataList.add(textData);
    }

    return textDataList;
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
        height: MediaQuery.of(context).size.height,
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
            Container(
              child: Expanded(
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    CustomProgressBar(), // Giá trị progress từ 0.0 đến 1.0
                    // Nội dung màn hình
                    const SizedBox(
                      height: 40,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 30),
                      child: Text(
                        "Phân loại cây trồng:",
                        style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'Inter-SemiBold-600.ttf',
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Column(
                      children: [
                        TabBar(
                          controller: _tabController,
                          labelColor: Colors.black,
                          unselectedLabelColor: Colors.black,
                          labelStyle:
                              const TextStyle(fontWeight: FontWeight.bold),
                          unselectedLabelStyle:
                              const TextStyle(fontStyle: FontStyle.italic),
                          overlayColor: MaterialStateColor.resolveWith(
                              (Set<MaterialState> states) {
                            if (states.contains(MaterialState.pressed)) {
                              return Colors.blue;
                            }
                            if (states.contains(MaterialState.focused)) {
                              return Colors.black;
                            } else if (states.contains(MaterialState.hovered)) {
                              return Colors.white;
                            }

                            return Colors.transparent;
                          }),
                          indicatorWeight: 10,
                          indicatorColor: Colors.red,
                          indicatorSize: TabBarIndicatorSize.tab,
                          indicatorPadding: const EdgeInsets.all(5),
                          indicator: BoxDecoration(
                            border: Border.all(color: Colors.red),
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                          ),
                          isScrollable: true,
                          physics: const BouncingScrollPhysics(),
                          onTap: (int index) {
                            setState(() {
                              selectedIndex = index;
                            });
                          },
                          enableFeedback: true,
                          tabs: _tabs,
                        ),
                        Container(
                          height: 200,
                          width: MediaQuery.of(context).size.width,
                          child: TabBarView(
                            controller: _tabController,
                            physics: BouncingScrollPhysics(),
                            // Uncomment the line below and remove DefaultTabController if you want to use a custom TabController
                            // controller: _tabController,
                            children: _views,
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, TimePlant.routeName);
                            Provider.of<ProgressProvider>(context,
                                    listen: false)
                                .updateProgress(); //update thanh tien trinh
                            Widget selectedView = _views[selectedIndex];
                            String selectedText = '';

                            if (selectedView is Center) {
                              if (selectedView.child is Text) {
                                Text selectedTextWidget =
                                    selectedView.child as Text;
                                selectedText = selectedTextWidget.data ?? '';
                                UpdateClassify(selectedText);
                                Provider.of<PlantProvider>(context, listen: false)
                                    .setIdLoaiCay(_idList[selectedIndex]);

                                print(_idList[selectedIndex]);
                              }
                            }
                          },
                          child: const Text('Next'),
                        ),
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
}
