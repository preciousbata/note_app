import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';
import 'package:note_app/firestore_database_service.dart';
import 'package:note_app/repository/archive_repository.dart';
import 'package:note_app/repository/note_repository.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerLazySingleton<NoteRepository>(
      () => NoteRepository(sl.get()));
  sl.registerSingleton(() => FirebaseFirestore.instance);
  // sl.registerSingleton<FirestoreDatabaseService>(
  //     () => FirestoreDatabaseService(sl.get()));
  sl.registerLazySingleton<ArchiveNoteRepository>(
      () => ArchiveNoteRepository(
            sl.get(),
          ));
}
