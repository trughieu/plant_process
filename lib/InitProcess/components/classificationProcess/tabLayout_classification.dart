import 'package:flutter/material.dart';

class TabLayoutClassification extends StatefulWidget {
  const TabLayoutClassification({super.key});

  @override
  State<StatefulWidget> createState() {
    return TabLayoutClassificationState();
  }
}

class TabLayoutClassificationState extends State<TabLayoutClassification>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.animateTo(1);
  }

  static const List<Tab> _tabs = [
    Tab(
        child: Text(
      'Ngắn ngày',
      style: TextStyle(fontFamily: 'Inter-light-300.ttf'),
    )),
    Tab(text: 'Trung ngày'),
    Tab(text: 'Dài ngày'),
  ];

  static const List<Widget> _views = [
    Center(
        child: Text(
            'Cây ngày ngắn là loại cây dù trồng bất kỳ lúc nào nhưng phải đợi đến khi số giờ chiếu sáng trong ngày chuyển qua thời kỳ ngắn lại thì mới ra hoa kết quả. Cây lúa mùa chín vụ hay mùa muộn trồng ở miền Bắc trước đây hay trồng ở miền Nam như giống Nàng hương Chợ Đào, giống Huyết rồng, giống Tài nguyên thuộc giống cây ngày ngắn')),
    Center(child: Text('Content of Tab Two')),
    Center(child: Text('Content of Tab Three')),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(
          controller: _tabController,
          labelColor: Colors.black,
          unselectedLabelColor: Colors.black,
          labelStyle: const TextStyle(fontWeight: FontWeight.bold),
          unselectedLabelStyle: const TextStyle(fontStyle: FontStyle.italic),
          overlayColor:
              MaterialStateColor.resolveWith((Set<MaterialState> states) {
            if (states.contains(MaterialState.pressed)) {
              return Colors.blue;
            }
            if (states.contains(MaterialState.focused)) {
              return Colors.orange;
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
          onTap: (int index) {},
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
      ],
    );
  }
}
