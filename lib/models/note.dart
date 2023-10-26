class Note {
  int id;
  String title;
  String content;
  DateTime modifiedTime;

  Note({
    required this.id,
    required this.title,
    required this.content,
    required this.modifiedTime,
  });
}

List<Note> sampleNotes = [
  Note(
    id: 0,
    title: 'Primary note',
    content: 'content',
    modifiedTime: DateTime(2023, 10, 26, 10, 5),
  ),
  Note(
      id: 1,
      title: 'title',
      content: 'content',
      modifiedTime: DateTime(2023, 10, 27, 5, 10))
];
