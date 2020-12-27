
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:notebook/model/note.dart';
import 'package:notebook/parts/drawer.dart';
import 'package:notebook/parts/warning.dart';

class Settings extends StatefulWidget {
  Settings({Key key}) : super(key: key);

  final String title = "Notebook";

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {

  final _formKey = GlobalKey<FormState>();
  TextEditingController _controller_email = new TextEditingController();
  static const platformMethodChannel = const MethodChannel('flutter.call.java');
  final String warning_setting_text = "Remember you need point database in next format: IamEmail@gmail.com . App support only gmail. If you point wrong gmail you will be not able to get export database. App will not display result about operation of install of gmail.";

  Future _refresh(context) async {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => Settings()));
  }

  @override
  Widget build(BuildContext context) {



    return Scaffold(
        drawer: NavDrawer(),
        appBar: AppBar(
            title: Text(widget.title),
            actions: <Widget>[
              Center(
                child: Ink(
                  decoration: const ShapeDecoration(
                    color: Colors.transparent,
                    shape: CircleBorder(),
                  ),
                  child: IconButton(
                    icon: Icon(Icons.refresh),
                    color: Colors.white,
                    onPressed: () {
                      _refresh(context);
                    },
                  ),
                ),
              ),
            ]
        ),
        body:
        Form(
        key: _formKey,
        child: SingleChildScrollView(
        child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
        Padding(
        padding: const EdgeInsets.symmetric(
        vertical: 8.0, horizontal: 20.0),
        child: TextFormField(
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          hintText: 'Notebook@gmail.com',
          labelText: 'email',
          helperText: "If you wanna you can point gmail to  export database, "+warning_setting_text,
        ),
        controller: _controller_email,

        validator: (value) {
          if (value.isEmpty) {
            return 'Please enter email';
          }
          return null;
        },
      ),
    ),

    Center(
    child: Padding(
    padding: const EdgeInsets.symmetric(vertical: 16.0),
    child: RaisedButton(
    onPressed: () async {
    // Validate returns true if the form is valid, or false
    // otherwise.

    if (_formKey.currentState.validate()) {
      final String result_model = await platformMethodChannel.invokeMethod("create_new_"+_controller_email.text);
    }
    },
    child: Text('Submit'),
    ),
    ),
    ),
    ],
    ),
    ),
    ),

    );

  }

}