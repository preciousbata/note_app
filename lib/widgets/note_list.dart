import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:note_app/screen/edit_screen.dart';

import '../model/note_item_model.dart';
import '../utils/dialog.dart';
import '../utils/hex_converter.dart';

class NoteList extends StatelessWidget {
  final List<NoteItem> notes;
  final Function(NoteItem) onDeleteNote;
  final Function(NoteItem) onArchiveNote;

  const NoteList({
    Key? key,
    required this.notes,
    required this.onArchiveNote,
    required this.onDeleteNote,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        final note = notes[index];
        return NoteListItem(
          onArchiveNote: onArchiveNote,
          onDeleteNote: onDeleteNote,
          note: note,
          onPressed: (note) {},
        );
      },
      itemCount: notes.length,
    );
  }
}

class NoteListItem extends StatefulWidget {
  final NoteItem note;
  final void Function(NoteItem) onPressed;
  final Function(NoteItem) onDeleteNote;
  final Function(NoteItem) onArchiveNote;

  const NoteListItem({
    Key? key,
    required this.note,
    required this.onPressed,
    required this.onDeleteNote,
    required this.onArchiveNote,
  }) : super(key: key);

  @override
  State<NoteListItem> createState() => _NoteListItemState();
}

class _NoteListItemState extends State<NoteListItem> {
  late String whatHappened;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(
          context, EditScreen.routeName,
          arguments: widget.note),
      child: Card(
        color: Colors.transparent,
        elevation: 3,
        child: Dismissible(
          key: ValueKey(widget.note.id),
          secondaryBackground: Container(
            color: Colors.red,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  width: 100.0,
                  height: double.infinity,
                  child: Column(
                    mainAxisAlignment:
                        MainAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.delete,
                        color: Colors.white,
                        size: 25.0,
                      ),
                      Text(
                        'Delete',
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          background: Container(
            color: Colors.green,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: 100.0,
                  height: double.infinity,
                  child: Column(
                    mainAxisAlignment:
                        MainAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.archive_rounded,
                        color: Colors.white,
                        size: 25.0,
                      ),
                      Text(
                        'Archive',
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          onDismissed: (direction) {
            switch (direction) {
              case DismissDirection.endToStart:
                widget.onDeleteNote(widget.note);
                break;
              case DismissDirection.startToEnd:
                widget.onArchiveNote(widget.note);
                break;
              default:
                break;
            }
          },
          confirmDismiss:
              (DismissDirection dismissDirection) async {
            switch (dismissDirection) {
              case DismissDirection.endToStart:
                whatHappened = 'DELETED';
                return await showConfirmationDialog(
                        context, 'delete') ==
                    true;
              case DismissDirection.startToEnd:
                whatHappened = 'ARCHIVED';
                return await showConfirmationDialog(
                        context, 'archive') ==
                    true;
              default:
                assert(false);
                break;
            }
            return false;
          },
          child: Container(
            height: 123.0,
            width: 365,
            decoration: BoxDecoration(
                color: widget.note.colorHex.isEmpty
                    ? Colors.blueGrey
                    : HexColor(widget.note.colorHex),
                borderRadius: BorderRadius.circular(10)),
            padding: const EdgeInsets.symmetric(
                horizontal: 20, vertical: 10.0),
            child: Column(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        widget.note.title,
                        style: GoogleFonts.nunito(
                            fontSize: 25,
                            color: Colors.white,
                            fontWeight: FontWeight.w600),
                      ),
                      Flexible(
                        child: Text(
                          widget.note.content,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.nunito(
                              fontSize: 25,
                              color: Colors.white,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20.0,
                  child: Row(
                    mainAxisAlignment:
                        MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.calendar_month,
                        size: 20,
                        color: Colors.white,
                      ),
                      const SizedBox(
                        width: 12.0,
                      ),
                      Text(
                        DateFormat.yMMMEd()
                            .format(widget.note.createdAt),
                        style: const TextStyle(
                          fontSize: 12.0,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
