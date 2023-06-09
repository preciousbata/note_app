import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:note_app/utils/constant.dart';

import '../injection.dart';
import '../model/note_item_model.dart';
import '../repository/archive_repository.dart';
import '../widgets/archive_list.dart';
import '../widgets/custom_appbar.dart';

class ArchivedNotesScreen extends StatefulWidget {
  static String routeName = '/archivedNotes';

  const ArchivedNotesScreen({Key? key}) : super(key: key);

  @override
  State<ArchivedNotesScreen> createState() =>
      _ArchivedNoteState();
}

class _ArchivedNoteState
    extends State<ArchivedNotesScreen> {
  final archiveNoteRepository =
      sl.get<ArchiveNoteRepository>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<List<NoteItem>>(
        stream: archiveNoteRepository.archiveNotes,
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
                  titleText: 'Archives',
                  icon: Icons.search,
                  secondIcon: Icons.close_rounded,
                  onPressed: () => Navigator.pop(context),
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
                            'No archived note yet !',
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
                          child: ArchivedList(
                              notes: notes,
                              onRestoreNote: (notes) =>
                                  archiveNoteRepository
                                      .restoreNote(notes),
                              onDeleteNote: (notes) =>
                                  archiveNoteRepository
                                      .deleteNoteFromArchive(
                                          notes)),
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
    );
  }
}
