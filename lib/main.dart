import 'package:day4/provider/changeColor.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'notesPage.dart';

void main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ChangeColor>(create: (context)=> ChangeColor(), child: MaterialApp(
      debugShowCheckedModeBanner: false,
      home: NotesPage(),
    ));
  }
}

