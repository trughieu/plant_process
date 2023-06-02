import 'package:flutter/cupertino.dart';
import 'package:plant_process/HomePage/homepage.dart';
import 'package:plant_process/InitProcess/components/time/components/edit/editchongiong.dart';
import 'package:plant_process/InitProcess/components/time/components/edit/editthuyloi.dart';
import 'package:plant_process/InitProcess/components/time/components/edit/gieotrong.dart';
import 'package:plant_process/InitProcess/components/time/components/edit/editmission.dart';
import 'package:plant_process/InitProcess/components/time/components/edit/managePSB.dart';
import 'package:plant_process/InitProcess/components/time/components/edit/managePhanbon.dart';
import 'package:plant_process/InitProcess/components/time/components/edit/editthuhoach.dart';
import 'package:plant_process/InitProcess/components/time/timePlant.dart';
import 'package:plant_process/tip_plant/components/follow_mission.dart';
import 'package:plant_process/tip_plant/components/manage.dart';
import 'package:plant_process/tip_plant/components/mission/gieotrong.dart';
import 'package:plant_process/tip_plant/components/select_plant.dart';
import 'InitProcess/components/classificationProcess/classification_process_page.dart';
import 'InitProcess/components/time/components/edit/manageKTT.dart';

final Map<String, WidgetBuilder> routes = {
  HomePage.routeName: (context) => HomePage(),
  Select_plant.routeName: (context) => Select_plant(),
  Follow_mission.routeName: (context) => Follow_mission(),
  ClassificationProcesssPage.routeName: (context) =>
      ClassificationProcesssPage(),
  TimePlant.routeName: (context) => TimePlant(),
  CreateProcessPage.routeName: (context) => CreateProcessPage(),
  ItemListWidget.routeName: (context) => ItemListWidget(),
  editThuhoach.routeName: (context) => editThuhoach(),
  editMission.routeName: (context) => editMission(),
  editGieoTrong.routeName: (context) => editGieoTrong(),
  ManageKTT.routeName: (context) => ManageKTT(),
  editThuyLoi.routeName: (context) => editThuyLoi(),
  ManagePhanBon.routeName:(context)=> ManagePhanBon(),
  ManagePSB.routeName:(context)=>ManagePSB(),

};
