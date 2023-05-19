import 'package:flutter/material.dart';

import '../../../model/process.dart';

class CreateProcessPage extends StatefulWidget {
  static String routeName = "/gieotrong";

  const CreateProcessPage({super.key});

  @override
  _CreateProcessPageState createState() => _CreateProcessPageState();
}

class _CreateProcessPageState extends State<CreateProcessPage> {
  final _formKey = GlobalKey<FormState>();
  final _process = Process(id_plant: '');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tạo quy trình trồng cây'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Tên quy trình',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Vui lòng nhập tên quy trình';
                  }
                  return null;
                },
                onSaved: (value) {
                  _process.name = value;
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Mô tả quy trình',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Vui lòng nhập mô tả quy trình';
                  }
                  return null;
                },
                onSaved: (value) {
                  _process.description = value;
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Thời gian trồng (ngày)',
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Vui lòng nhập thời gian trồng';
                  }
                  return null;
                },
                onSaved: (value) {
                  // _process.time = int.parse(value!);
                },
              ),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    // await DatabaseHelper.instance.insertProcess(_process);
                    Navigator.pop(context);
                  }
                },
                child: Text('Lưu'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
