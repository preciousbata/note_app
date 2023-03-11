import 'package:flutter/material.dart';
import 'package:note_app/injection.dart';
import 'package:note_app/model/note_item_model.dart';
import 'package:note_app/repository/archive_repository.dart';
import 'package:note_app/repository/note_repository.dart';
import 'package:note_app/screen/add_note_screen.dart';
import 'package:note_app/widgets/note_list.dart';
import 'package:note_app/widgets/sliver_appbar.dart';

class AllNotesScreen extends StatefulWidget {
  static String routeName = '/viewAllNotes';

  const AllNotesScreen({Key? key}) : super(key: key);

  @override
  State<AllNotesScreen> createState() =>
      _AllNotesScreenState();
}

class _AllNotesScreenState extends State<AllNotesScreen> {
  final noteRepository = sl.get<NoteRepository>();
  final archiveNoteRepository =
      sl.get<ArchiveNoteRepository>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<List<NoteItem>>(
        stream: noteRepository.notes,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text('Something went wrong!');
          } else if (snapshot.hasData) {
            final notes = snapshot.data!;
            notes.sort((a, b) =>
                b.createdAt.compareTo(a.createdAt));
            return CustomScrollView(
              slivers: [
                const AppSliverAppBar(
                  titleText: 'Notes',
                ),
                SliverPadding(
                  padding: const EdgeInsets.all(10.0),
                  sliver:
                      // NoteGrid(notes: notes),
                      NoteList(
                    notes: notes,
                    onDeleteNote: (note) => noteRepository
                        .deleteNote(note.referenceId),
                    onArchiveNote: (note) => {
                      debugPrint(
                          'note to archive is $note'),
                      archiveNoteRepository
                          .saveNoteToArchive(note)
                    },
                  ),
                ),
              ],
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(
            context, AddNoteScreen.routeName),
        elevation: 0,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
