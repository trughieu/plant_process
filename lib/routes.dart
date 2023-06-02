
import 'package:flutter/cupertino.dart';
import 'package:plant_process/HomePage/homepage.dart';
import 'package:plant_process/InitProcess/components/time/timePlant.dart';
import 'package:plant_process/model/item.dart';
import 'package:plant_process/tip_plant/components/follow_mission.dart';
import 'package:plant_process/tip_plant/components/manage.dart';
import 'package:plant_process/tip_plant/components/mission/gieotrong.dart';
import 'package:plant_process/tip_plant/components/select_plant.dart';
import 'InitProcess/components/classificationProcess/classification_process_page.dart';
import 'tip_plant/components/plants.dart';

final Map<String, WidgetBuilder> routes = {
  HomePage.routeName: (context) => HomePage(),
  Select_plant.routeName: (context) => Select_plant(),
  Follow_mission.routeName: (context) => Follow_mission(),
  ClassificationProcesssPage.routeName: (context) =>
      ClassificationProcesssPage(),
  TimePlant.routeName: (context) => TimePlant(),
  CreateProcessPage.routeName: (context) => CreateProcessPage(),
  ItemListWidget.routeName: (context)=> ItemListWidget(),
};
