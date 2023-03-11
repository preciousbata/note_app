import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:note_app/repository/note_repository.dart';

import '../firestore_database_service.dart';
import '../model/note_item_model.dart';

// this should be marked as a repository

const _collectionPath = 'archived';
const _notePath = 'notes';

class ArchiveNoteRepository {
  final NoteRepository _noteRepository;
  final FirestoreDatabaseService _fireStoreDb =
      FirestoreDatabaseService(FirebaseFirestore.instance);

  ArchiveNoteRepository(this._noteRepository);

  Stream<List<NoteItem>> get archiveNotes {
    return _fireStoreDb.getCollections(_collectionPath).map(
        (event) => event.docs
            .map((e) => NoteItem.fromJson(e.data()))
            .toList());
  }

  // you should separate this into two functions
  // one to add an archived note and one to get it and possibly to delete

  void saveNoteToArchive(NoteItem noteItem) async {
    final reference = await _fireStoreDb.saveToCollection(
        _collectionPath, noteItem.toJson());
    reference.update({"referenceId": reference.id});
    await _noteRepository.deleteNote(noteItem.referenceId);
  }

  void deleteNoteFromArchive(NoteItem note) async {
    try {
      debugPrint('referenceId is ${note.referenceId}');
      _fireStoreDb.deleteCollection(
          _collectionPath, note.referenceId);
    } catch (exception) {
      debugPrint(
          'exception caught is ${exception.toString()}');
    }
  }

  void restoreNote(NoteItem noteItem) async {
    final reference = await _fireStoreDb.saveToCollection(
        _notePath, noteItem.toJson());
    reference.update({"referenceId": reference.id});
    _fireStoreDb.deleteCollection(
        _collectionPath, noteItem.referenceId);
  }
}
