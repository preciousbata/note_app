import 'package:flutter/cupertino.dart';
import 'package:note_app/firestore_database_service.dart';
import 'package:note_app/model/note_item_model.dart';

const _notes = 'notes';

class NoteRepository {
  final FirestoreDatabaseService _fireStoreDb;

  NoteRepository(this._fireStoreDb);

  Stream<List<NoteItem>> get notes => _fireStoreDb
      .getCollections(_notes)
      .map((event) => event.docs
          .map((e) => NoteItem.fromJson(e.data()))
          .toList());

  Future<void> deleteNote(String referenceId) async {
    try {
      debugPrint('referenceId is $referenceId');
      _fireStoreDb.deleteCollection(_notes, referenceId);
    } catch (exception) {
      debugPrint(
          'exception caught is ${exception.toString()}');
    }
  }

  void createNote(String noteTitle, String noteContent,
      String colorHex) async {
    try {
      final currentDate = DateTime.now();
      final note = NoteItem(
          id: currentDate.millisecondsSinceEpoch.toString(),
          title: noteTitle,
          content: noteContent,
          createdAt: currentDate,
          colorHex: colorHex);
      final reference = await _fireStoreDb.saveToCollection(
          _notes, note.toJson());
      note.referenceId = reference.id;
      debugPrint('document reference is ${reference.id}');
      await _fireStoreDb.updateCollection(
          collectionPath: _notes,
          referenceId: reference.id,
          data: note.toJson());
    } catch (exception) {
      debugPrint(
          'exception caught is ${exception.toString()}');
    }
  }

  Future<void> updateNote(String referenceId, String title,
      String content, String color) async {
    try {
      await _fireStoreDb.updateCollection(
          collectionPath: _notes,
          referenceId: referenceId,
          data: {
            "title": title,
            "content": content,
            "color": color
          });
    } catch (exception) {
      debugPrint(
          'exception caught is ${exception.toString()}');
    }
  }
}
