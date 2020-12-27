import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:notebook/add_note.dart';
import 'package:notebook/model/note.dart';
import 'package:notebook/parts/drawer.dart';

class MainPage extends StatefulWidget {
  MainPage({Key key}) : super(key: key);

  final String title = "Notebook";
  List<Note> notes =  [Note("0","empty","empty", "infinwefewfewfewfewfewfewfewfity", "empty")];

   @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  static const platformMethodChannel = const MethodChannel('flutter.call.java');

  void initState() {
    super.initState();
    _init_starting_list();
  }

    Future<Null> _init_starting_list() async {
    List<Note> notes_list = List<Note>();

    try {
      var list_of_objects = await platformMethodChannel.invokeMethod('read_all_no');
      if(list_of_objects != null) {
        final max = list_of_objects.length;
        for (var i = 0; i < max; i++) {
          Map<String, dynamic> note = jsonDecode(list_of_objects[i]);

          Note model = new Note("${note['id']}", "${note['title']}", "${note['note']}",
              "${note['date_of_add']}", "${note['user']}");


          notes_list.add(model);

        }
      }
    } on PlatformException catch (e) {
      debugPrint("Can't do native stuff ${e.message}.");
    }

    setState(() {
      widget.notes = notes_list;
    });

  }

  Future<Null> edit_note(id, title, date_of_edit, note) async {
    try {

      String model_json = '{"id":'+id+', "title":"'+title+'", "note":"'+note+'", "date_of_add":"'+date_of_edit+'"}';
      final String json = "edit_note__ "+model_json;

      final String result_model = await platformMethodChannel.invokeMethod(json);


    } on PlatformException catch (e) {
      debugPrint("Can't do native stuff ${e.message}.");
    }
  }

  Future<Null> delete_note(id) async {
    try {

      var message = "delete_note "+id;

      var result_model = await platformMethodChannel.invokeMethod(message);

    } on PlatformException catch (e) {
      debugPrint("Can't do native stuff ${e.message}.");
    }
  }

  int _counter = 0;
  final _formKey = GlobalKey<FormState>();
  Future<Null> load_setting_future;

  Future _getThingsOnStartup() async {
    await Future.delayed(Duration(seconds: 2));
  }

  Future _navigation_to_create_note(context) async {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => AddnotePage()));
  }

  Future _refresh(context) async {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => MainPage()));
  }


  void _show_edit_form(id, title, note, date_of_edit, scaffold) {
    TextEditingController _controller_title = new TextEditingController(
        text: title);
    TextEditingController _controller_note = new TextEditingController(
        text: note);


    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Stack(
              overflow: Overflow.visible,
              children: <Widget>[
                Positioned(
                  right: -40.0,
                  top: -40.0,
                  child: InkResponse(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: CircleAvatar(
                      child: Icon(Icons.close),
                      backgroundColor: Colors.red,
                    ),
                  ),
                ),
                Form(
                  key: _formKey,

                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.all(8.0),
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
                          padding: EdgeInsets.all(8.0),
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
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: RaisedButton(
                            child: Text("Submit"),
                            onPressed: () {

                              edit_note(id, _controller_title.text, date_of_edit, _controller_note.text);
                              _init_starting_list();

                              Navigator.pop(context, 'Result.');

                              if (_formKey.currentState.validate()) {
                                _formKey.currentState.save();
                              }
                              scaffold
                                  .showSnackBar(
                                  SnackBar(content: Text('Finish edit')));
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }


  Future<void> _ask_confirmation_of_edit(id, title, note, date_of_add, scaffold) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirmation'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Are you sure you wanna edit this note?'),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Confirm edit'),
              onPressed: () {
                Navigator.of(context).pop();
                _show_edit_form(id, title, note, date_of_add, scaffold);
                scaffold.showSnackBar(SnackBar(content: Text('Finish edit')));

              },
            ),

            FlatButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),

          ],
        );
      },
    );
  }


  Future<void> _ask_confirmation_of_delete(id, scaffold) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirmation'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Are you sure you wanna delete this note?'),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Confirm delete'),
              onPressed: () {

                delete_note(id);
                _init_starting_list();
                Navigator.of(context).pop();
                scaffold
                    .showSnackBar(SnackBar(content: Text('Finish delete')));
              },
            ),

            FlatButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),

          ],
        );
      },
    );
  }


  @override
  Widget build(BuildContext context)  {
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
      body: Center(
          child: ListView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: widget.notes.length,
              itemBuilder: (context, pos) {
                final Note item = widget.notes[pos];

                //format of date 24 Mar 2020
                final number_of_date = item.date_of_add.substring(0, 3);
                final month_of_date = item.date_of_add.substring(4, 8);
                final year_of_date = item.date_of_add.substring(9);

                return new Column(
                  children: <Widget>[
                    Card(
                      child: ListTile(
                        leading:
                        Text.rich(
                          TextSpan(
                            children: <TextSpan>[
                              TextSpan(text: number_of_date + "\n\n",
                                  style: TextStyle(height: 0.8,
                                      fontSize: 24,
                                      fontStyle: FontStyle.italic)),
                              TextSpan(text: " " + month_of_date + "\n\n",
                                  style: TextStyle(height: 0,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold)),
                              TextSpan(text: year_of_date,
                                  style: TextStyle(height: 0.3,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),

                        title: Text(item.title,
                          style: TextStyle(fontWeight: FontWeight.w500 ),
                        ),
                        subtitle: Text(item.note),
                        trailing: Column(
                            children: <Widget>[
                              Expanded(
                                child:
                                FlatButton(
                                  onPressed: () {
                                    _ask_confirmation_of_edit(
                                        item.id, item.title, item.note, item.date_of_add, Scaffold.of(context));
                                  },
                                  child: Text(
                                    "Edit",
                                  ),
                                ),

                              ),

                              Expanded(

                                child:
                                FlatButton(
                                  onPressed: () {
                                    _ask_confirmation_of_delete(
                                        item.id, Scaffold.of(context));
                                  },
                                  child: Text(
                                    "Delete",
                                  ),
                                ),

                              ),


                            ]
                        ),


                      ),
                    ),

                  ],
                );
              })
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _navigation_to_create_note(context);
//            _managePower();

        },
        tooltip: 'add note',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
