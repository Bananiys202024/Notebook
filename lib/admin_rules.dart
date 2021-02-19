import 'package:flutter/material.dart';
import 'package:notebook/parts/add_note_form.dart';

import 'parts/admin_rules.dart';


class AdminRulesPage extends StatefulWidget {
  AdminRulesPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  __AdminRulesPageState createState() => __AdminRulesPageState();
}

class __AdminRulesPageState extends State<AdminRulesPage> {
  int _counter = 0;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title: Text("Admin panel"),
        ),
        body: AdminRules(),
    );
  }
}
