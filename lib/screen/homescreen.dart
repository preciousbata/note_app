import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:note_app/injection.dart';
import 'package:note_app/model/note_item_model.dart';
import 'package:note_app/repository/archive_repository.dart';
import 'package:note_app/repository/note_repository.dart';
import 'package:note_app/screen/add_note_screen.dart';
import 'package:note_app/screen/archived_note_screen.dart';
import 'package:note_app/utils/constant.dart';
import 'package:note_app/widgets/custom_appbar.dart';
import 'package:note_app/widgets/note_list.dart';

class HomeScreen extends StatefulWidget {
  static String routeName = '/viewAllNotes';

  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
            return Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                CustomAppBar(
                  titleText: 'Notes',
                  icon: Icons.search,
                  secondIcon: Icons.archive_rounded,
                  onPressed: () => Navigator.pushNamed(
                      context,
                      ArchivedNotesScreen.routeName),
                ),
                notes.isEmpty
                    ? Column(
                        children: [
                          const SizedBox(
                            height: 100,
                          ),
                          SizedBox(
                            width: 350,
                            height: 300,
                            child: Image.asset(
                              'assets/new_note.png',
                              fit: BoxFit.contain,
                            ),
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          Text(
                            'Create your first note !',
                            style: GoogleFonts.nunito(
                                fontSize: 20,
                                color: white,
                                fontWeight:
                                    FontWeight.w300),
                          )
                        ],
                      )
                    : Expanded(
                        child: Padding(
                          padding:
                              const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 8),
                          child: NoteList(
                              notes: notes,
                              onArchiveNote: (notes) =>
                                  archiveNoteRepository
                                      .saveNoteToArchive(
                                          notes),
                              onDeleteNote: (notes) =>
                                  noteRepository.deleteNote(
                                      notes.referenceId)),
                        ),
                      )
              ],
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(
            context, AddNoteScreen.routeName),
        elevation: 2,
        backgroundColor: lightGray,
        child: const Icon(
          Icons.add,
          size: 28,
          color: Colors.white,
        ),
      ),
    );
  }
}
