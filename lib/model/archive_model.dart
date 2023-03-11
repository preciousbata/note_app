import 'package:note_app/model/note_item_model.dart';

class ArchiveNote extends NoteItem {
  ArchiveNote(
      {required String id,
      required String title,
      required String content,
      required DateTime createdAt})
      : super(
            id: id,
            title: title,
            content: content,
            createdAt: createdAt);
}
