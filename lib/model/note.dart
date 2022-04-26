 class Note {
  int? noteId;
  String? noteTitle;
  String? noteText;
  String? noteDate;
  int? noteColor;

  Note({this.noteId, this.noteTitle, this.noteText, this.noteDate, this.noteColor});

  Map<String, dynamic> toMap() => {'noteId':noteId,'noteTitle':noteTitle, 'noteText':noteText,'noteDate':noteDate, 'noteColor':noteColor};
  Note.fromMap(Map<String,dynamic> map){
    noteId = map['noteId'];
    noteTitle = map['noteTitle'];
    noteText = map['noteText'];
    noteDate= map['noteDate'];
    noteColor= map['noteColor'];
  }
}

