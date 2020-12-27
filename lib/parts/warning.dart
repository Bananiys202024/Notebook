
import 'package:flutter/material.dart';

Widget show_warning(String text, String title, context)
{
  var alert = AlertDialog(
    title: Text(title),
    content: Text(text),

    actions: [Text("To close info windows just press outside info icon")]

  );
  showDialog(context: context, builder: (BuildContext context) => alert);

}





