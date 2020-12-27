import 'package:flutter/material.dart';
import 'package:notebook/parts/add_note_form.dart';


class AddnotePage extends StatefulWidget {
  AddnotePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  __AddnotePageState createState() => __AddnotePageState();
}

class __AddnotePageState extends State<AddnotePage> {
  int _counter = 0;

  void _create_note() {
    setState(() {
      debugPrint('from method create_note');
    });
  }

  @override
  Widget build(BuildContext context) {

      return Scaffold(
      appBar: AppBar(
        title: Text("Add note"),
      ),
      body: MyCustomForm()
    );
  }
}
