import 'package:day4/data/local/db.dart';
import 'package:day4/provider/changeColor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'model/note.dart';
import 'package:provider/provider.dart';

class NoteForm extends StatelessWidget {
  var titleController = TextEditingController();
  var textController = TextEditingController();
  var dateController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    DbHelper.dbHelper.getDbInstance();
    List colors = [
      Colors.red,
      Colors.green,
      Colors.blue,
      Colors.grey,
      Colors.deepOrange,
      Colors.blue.shade900,
      Colors.brown,
      Colors.brown.shade900,
      Colors.pink.shade900
    ];

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepPurple.shade900,
          actions: [
            Consumer<ChangeColor>(builder: (context, color, child) {
              return TextButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      Note note = Note(
                          noteText: textController.text,
                          noteTitle: titleController.text,
                          noteDate: dateController.text,
                          noteColor: color.selectedColor!.value);
                      saveNote(note, context);
                    }
                  },
                  child: Icon(
                    Icons.check,
                    color: Colors.white,
                  ));
            })
          ],
          title: Text("New Note"),
        ),
        body: Form(
          key: _formKey,
          child: Container(
            margin: EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 250,
                  child: Column(
                    children: [
                      TextFormField(
                        validator: (value) =>
                        value!.isEmpty ? 'Write note title' : null,
                        controller: titleController,
                        decoration: const InputDecoration(
                          label: Text("Note Title"),
                        ),
                      ),
                      TextFormField(
                        validator: (value) =>
                        value!.isEmpty ? 'Write note text' : null,
                        controller: textController,
                        decoration: const InputDecoration(
                          label: Text("Note Text"),
                        ),
                      ),
                      TextFormField(
                        validator: (value) =>
                        value!.isEmpty ? 'Write note date' : null,
                        controller: dateController,
                        onTap: () {
                          showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime.now(),
                              lastDate: DateTime(2022, 4, 30))
                              .then((value) => dateController.text =
                          "${value?.month}/${value?.day}/${value?.year}");
                          print(dateController.text);
                        },
                        decoration: const InputDecoration(
                          label: Text("Note Date"),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 40,
                 // margin: EdgeInsets.only(top: 330),
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: colors.length,
                      itemBuilder: (context, index) {
                        return Container(
                          width: 38,
                          height: 40,
                          color: colors[index],
                          child: TextButton(
                              onPressed: () {
                                ChangeColor color =
                                    Provider.of(context, listen: false);
                                color.changeColor(index);
                              },
                              child: const Text("")),
                        );
                      }),
                )
              ],
            ),
          ),
        ));
  }
}

saveNote(Note note, BuildContext context) {
  DbHelper.dbHelper
      .InsertToDB(note)
      .then((value) => {Navigator.pop(context)})
      .catchError((err) => print(err));
}
