import 'package:flutter/material.dart';

class Info extends StatefulWidget {
  const Info({Key? key}) : super(key: key);

  @override
  State<Info> createState() => _InfoState();
}

class _InfoState extends State<Info> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 70,
      margin: const EdgeInsets.only(top: 50),
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          SizedBox(
              child: Container(
            height: 70,
            width: 70,
            decoration: BoxDecoration(
                border: Border.all(color: const Color(0xfffecb02)),
                color: Colors.red,
                borderRadius: BorderRadius.circular(100)),
          )),
          SizedBox(
              child: Container(
            height: 70,
            width: 70,
            decoration: BoxDecoration(
                border: Border.all(color: const Color(0xfffecb02)),
                color: Colors.white,
                borderRadius: BorderRadius.circular(200)),
          )),
          SizedBox(
              child: Container(
            height: 70,
            width: 70,
            decoration: BoxDecoration(
                border: Border.all(color: const Color(0xfffecb02)),
                color: Colors.white,
                borderRadius: BorderRadius.circular(200)),
          )),
          SizedBox(
            child: Container(
              height: 70,
              width: 70,
              decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xfffecb02)),
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(100)),
            ),
          ),
          SizedBox(
              child: Container(
            height: 70,
            width: 70,
            decoration: BoxDecoration(
                border: Border.all(color: const Color(0xfffecb02)),
                color: Colors.white,
                borderRadius: BorderRadius.circular(100)),
          )),
          SizedBox(
              child: Container(
            height: 70,
            width: 70,
            decoration: BoxDecoration(
                border: Border.all(color: const Color(0xfffecb02)),
                color: Colors.white,
                borderRadius: BorderRadius.circular(200)),
          )),
          SizedBox(
              child: Container(
            height: 70,
            width: 70,
            decoration: BoxDecoration(
                border: Border.all(color: const Color(0xfffecb02)),
                color: Colors.black,
                borderRadius: BorderRadius.circular(200)),
          )),
          SizedBox(
            child: Container(
              height: 70,
              width: 70,
              decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xfffecb02)),
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(100)),
            ),
          ),
        ],
      ),
    );

    // FutureBuilder<List>MyData <>(
    // future: fetchData(),
    // builder: (context, snapshot) {
    // if (snapshot.hasData) {
    // return ListView.builder(
    // itemCount: snapshot.data.length,
    // itemBuilder: (context, index) {
    // final item = snapshot.data[index];
    // return ListTile(
    // title: Text(item.title),
    // subtitle: Text(item.subtitle),
    // );
    // },
    // );
    // } else if (snapshot.hasError) {
    // return Text(&apos;${snapshot.error}&apos;);
    // }
    // return CircularProgressIndicator();
    // },
    // )
  }
}
