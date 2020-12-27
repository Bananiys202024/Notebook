import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:notebook/my_home_page.dart';

import 'package:flutter/widgets.dart';
import 'package:notebook/parts/warning.dart';
import 'package:notebook/settings.dart';

class NavDrawer extends StatelessWidget {

  static const platformMethodChannel = const MethodChannel('flutter.call.java');

  final String warning_export_text = "You did export database. If you did not get letter then may be you did point wrong gmail. Please, check your gmail again or may be high load on gmail account. May be you need try later to export database.";
  final String warning_import_text = "You did import database.If you did not import database may be you did choose wrong one file for import";

  Future<Null> export_database()  async
  {
    String result = await platformMethodChannel.invokeMethod('export_data');
  }

  Future<Null> import_database()  async
  {
    //pick file of database
    FilePickerResult result = await FilePicker.platform.pickFiles();

    if(result != null) {
      PlatformFile file = result.files.first;
      String send_message = await platformMethodChannel.invokeMethod('import_data'+file.path);
    } else {
      print("choosen file is null");
    }


  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text(
              '',//side menu text
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
           decoration: BoxDecoration(
               color: Colors.green,
               image: DecorationImage(
                   fit: BoxFit.fill,
                   image: AssetImage('assets/images/drawer_image.jpg')
               )
           )

    ),


          ListTile(
            leading: Icon(Icons.addchart_rounded),
            title: Text('Notes'),
            onTap: () =>
            {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => MainPage())),
            },
          ),

          ListTile(
            leading: Icon(Icons.input),
            title: Text('Export database'),
            onTap: () =>
    {
            export_database(),
            Navigator.of(context).pop(),
            show_warning(warning_export_text, "Export database", context),
    },
          ),
          ListTile(
            leading: Icon(Icons.add),
            title: Text('Import database'),
            onTap: () => {
              import_database(),
              Navigator.of(context).pop(),
              show_warning(warning_import_text, "Import database", context),

            },
          ),

          ListTile(
            leading: Icon(Icons.app_settings_alt),
            title: Text('Settings'),
            onTap: () => {

              Navigator.push(
            context, MaterialPageRoute(builder: (context) => Settings())),
            },


          ),
        ],
      ),
    );
  }
}