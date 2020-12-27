import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:notebook/main.dart';
import 'package:notebook/model/note.dart';
import 'package:notebook/my_home_page.dart';

class MyCustomForm extends StatefulWidget {
  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}


// Create a corresponding State class.
// This class holds data related to the form.
class MyCustomFormState extends State<MyCustomForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();
  TextEditingController _controller_title = new TextEditingController();
  TextEditingController _controller_note = new TextEditingController();
  static const platformMethodChannel = const MethodChannel('flutter.call.java');

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _controller_title.dispose();
    _controller_note.dispose();
    super.dispose();
  }

  Future _navigation_to_home_page(context) async {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => MainPage()));
  }

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.

    return
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
                    hintText: 'title',
                    labelText: 'title',
                  ),
                  controller: _controller_title,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 8.0, horizontal: 20.0),


                child: TextFormField(
                  textAlign: TextAlign.center,

                  maxLines: null,
                  keyboardType: TextInputType.multiline,

                  decoration: InputDecoration(
                      hintText: 'note',
                      labelText: 'note'
                  ),
                  controller: _controller_note,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: RaisedButton(
                    onPressed: () {
                      // Validate returns true if the form is valid, or false
                      // otherwise.

                      if (_formKey.currentState.validate()) {

                        // If the form is valid, display a Snackbar.
                        Scaffold.of(context)
                            .showSnackBar(SnackBar(content: Text(
                            'Processing Data')));

                        Note note = new Note("0",_controller_title.text, _controller_note.text, "0", "Banan");
                        create_note(note);

                        _navigation_to_home_page(context);
                      }
                    },
                    child: Text('Submit'),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
  }


  Future<Null> create_note(Note note) async {
    try {

    String notes = note.note
                          .replaceAll('\'', '\'')
                          .replaceAll('"', '\\"');

    String json_model = ' {"title":"'+note.title+'" , "note":"'+notes+'"} ';

    print("JSON MODEL----"+json_model);
    var message = 'create_note '+json_model;

    final String result_model = await platformMethodChannel.invokeMethod(message);

    } on PlatformException catch (e) {
      debugPrint("Can't do native stuff ${e.message}.");
    }
  }
}
