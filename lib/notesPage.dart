import 'package:day4/data/local/db.dart';
import 'package:flutter/material.dart';
import 'model/note.dart';
import 'noteForm.dart';

class NotesPage extends StatefulWidget {
  @override
  _NotesPageState createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  bool visible= false;
  List<Note> notes= [];

  @override
  void initState(){
    showNotes();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    showNotes();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple.shade900,
        title: const Text("Notes"),
      ),
      body: Container(
        margin: const EdgeInsets.all(20),
        child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisSpacing: 20,
                crossAxisCount: 2),
            itemCount: notes.length,
            itemBuilder: (context, index) {
              return Card(
                color: Color(notes[index].noteColor!),
                child: Container(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row( mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(notes[index].noteTitle!, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),),
                          Container(child: Row(
                            children: [
                              GestureDetector(child: Icon(Icons.edit), onTap: (){
                                openEditDialog(notes[index]);
                              },),
                              GestureDetector(child: Icon(Icons.delete), onTap: (){
                                deleteNote(notes[index].noteId!);
                              },),
                            ],
                          ))
                        ],
                      ),
                      Text(notes[index].noteText!, style: TextStyle(color: Colors.white)),
                      Text(notes[index].noteDate!, style: TextStyle(color: Colors.white)),
                    ],
                  ),
                ),
              );
            }),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepPurple.shade900,
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder:(context)=> new NoteForm()));
        },
        child: const Text("Add"),
      ),
    );
  }


  openEditDialog(Note note)
  {
    GlobalKey<FormState> _dialogFormKey = GlobalKey();
    TextEditingController _textController =
    TextEditingController(text: note.noteText!);
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title:  Text(note.noteTitle!),
          content: SizedBox(
            height: 130,
            child: Form(
              key: _dialogFormKey,
              child: TextFormField(
                keyboardType: TextInputType.text,
                validator: (value) =>
                value!.isEmpty ? 'Write your note' : null,
                controller: _textController,
              ),
            ),
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
            const SizedBox(
              width: 8,
            ),
            TextButton(
                onPressed: () {
                  if (_dialogFormKey.currentState!.validate()) {
                    note.noteText= _textController.value.text;
                    updateNote(note);
                    Navigator.pop(context);
                  }
                },
                child: const Text('Update'))
          ],
        ));
  }

  showNotes()
  {
    DbHelper.dbHelper.getNotes().then((value)
    {
      setState(() {
        notes= value;
      });
    });
  }

  updateNote(Note note)
  {
    DbHelper.dbHelper.updateNotes(note).then((value) =>
    value > 0 ? print('Note updated') : print('something went wrong'));
    showNotes();
  }

  deleteNote(int noteId)
  {
    DbHelper.dbHelper.deleteNote(noteId).then((value) =>
    value > 0 ? print('Note deleted') : print('something went wrong'));
    showNotes();
  }
}
