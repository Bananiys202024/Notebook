import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:notebook/main.dart';
import 'package:notebook/model/note.dart';
import 'package:notebook/my_home_page.dart';

class AdminRules extends StatefulWidget {
  @override
  AdminRulesState createState() {
    return AdminRulesState();
  }
}

// Create a corresponding State class.
// This class holds data related to the form.
class AdminRulesState extends State<AdminRules> {


  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.

   return CustomScrollView(
      shrinkWrap: true,
      slivers: <Widget>[
        SliverPadding(
          padding: const EdgeInsets.all(20.0),
          sliver: SliverList(
            delegate: SliverChildListDelegate(
              <Widget>[

        Container(
        width: 200,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          color: Colors.white,
          elevation: 10,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const ListTile(
                leading: Icon(Icons.work, size: 40),
                title: Text('Rule 1', style: TextStyle(color: Colors.grey)),
                subtitle: Text('Try every day live by job schedule',
                    style: TextStyle(color: Colors.black)),
              ),
            ],
          ),
        ),
      ),


                Container(
                  width: 200,
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    color: Colors.white,
                    elevation: 10,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        const ListTile(
                          leading: Icon(Icons.sports_baseball, size: 40),
                          title: Text('Rule 2', style: TextStyle(color: Colors.grey)),
                          subtitle: Text('Does sport. At least 20 pushUps',
                              style: TextStyle(color: Colors.black)),
                        ),
                      ],
                    ),
                  ),
                ),

                Container(
                  width: 200,
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    color: Colors.white,
                    elevation: 10,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        const ListTile(
                          leading: Icon(Icons.pest_control, size: 40),
                          title: Text('Rule 3', style: TextStyle(color: Colors.grey)),
                          subtitle: Text('Sleep schedule has influence on other fields of life, for example: discipline',
                              style: TextStyle(color: Colors.black)),
                        ),
                      ],
                    ),
                  ),
                ),

                Container(
                  width: 200,
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    color: Colors.white,
                    elevation: 10,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        const ListTile(
                          leading: Icon(Icons.bedtime_sharp, size: 40),
                          title: Text('Rule 4', style: TextStyle(color: Colors.grey)),
                          subtitle: Text('If you can not get a sleep for a 100 breath then do something and try again. Think about feelings of your body',
                              style: TextStyle(color: Colors.black)),
                        ),
                      ],
                    ),
                  ),
                ),


              ],
            ),
          ),
        ),
      ],
    );

  }

}
