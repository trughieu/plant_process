// import 'dart:convert';
//
// import 'package:flutter/material.dart';
// import 'package:plant_process/model/classify.dart';
//
// import '../../../model/utilities.dart';
// import 'package:http/http.dart' as http;
//
// class TabLayoutClassification extends StatefulWidget {
//   const TabLayoutClassification({super.key});
//
//   @override
//   State<StatefulWidget> createState() {
//     return TabLayoutClassificationState();
//   }
// }
//
// class TabLayoutClassificationState extends State<TabLayoutClassification>
//     with TickerProviderStateMixin {
//   late TabController _tabController;
//
//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: 3, vsync: this);
//     _tabController.animateTo(1);
//     getClassify();
//   }
//
//   String uri = Utilities.url;
//   List<Classify> classify = [];
//   List<Widget> _views = [];
//
//   void getClassify() async {
//     final res = await http.get(Uri.parse('$uri/api/classify'));
//     if (res.statusCode == 200) {
//       print(res.body);
//       final body = jsonDecode(res.body);
//       var classify = body['classify'];
//       List<Widget> updatedViews = [];
//
//       for (var p in classify) {
//         var classifyData = Classify.fromJson(p as Map<String, dynamic>);
//         var textWidget = Center(child: Text(classifyData.des));
//         updatedViews.add(textWidget);
//       }
//       setState(() {
//         _views = updatedViews;
//       });
//
//     }
//     else{
//       print('fal');
//     }
//   }
//
//   static const List<Tab> _tabs = [
//     Tab(
//         child: Text(
//       'Ngắn ngày',
//       style: TextStyle(fontFamily: 'Inter-light-300.ttf'),
//     )),
//     Tab(text: 'Trung ngày'),
//     Tab(text: 'Dài ngày'),
//   ];
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         TabBar(
//           controller: _tabController,
//           labelColor: Colors.black,
//           unselectedLabelColor: Colors.black,
//           labelStyle: const TextStyle(fontWeight: FontWeight.bold),
//           unselectedLabelStyle: const TextStyle(fontStyle: FontStyle.italic),
//           overlayColor:
//               MaterialStateColor.resolveWith((Set<MaterialState> states) {
//             if (states.contains(MaterialState.pressed)) {
//               return Colors.blue;
//             }
//             if (states.contains(MaterialState.focused)) {
//               return Colors.black;
//             } else if (states.contains(MaterialState.hovered)) {
//               return Colors.white;
//             }
//
//             return Colors.transparent;
//           }),
//           indicatorWeight: 10,
//           indicatorColor: Colors.red,
//           indicatorSize: TabBarIndicatorSize.tab,
//           indicatorPadding: const EdgeInsets.all(5),
//           indicator: BoxDecoration(
//             border: Border.all(color: Colors.red),
//             borderRadius: BorderRadius.circular(10),
//             color: Colors.white,
//           ),
//           isScrollable: true,
//           physics: const BouncingScrollPhysics(),
//           onTap: (int index) {},
//           enableFeedback: true,
//           tabs: _tabs,
//         ),
//         Container(
//           height: 200,
//           width: MediaQuery.of(context).size.width,
//           child: TabBarView(
//             controller: _tabController,
//             physics: BouncingScrollPhysics(),
//             // Uncomment the line below and remove DefaultTabController if you want to use a custom TabController
//             // controller: _tabController,
//             children: _views,
//           ),
//         ),
//       ],
//     );
//   }
// }
