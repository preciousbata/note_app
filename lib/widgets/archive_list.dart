import 'package:flutter/material.dart';

import '../model/note_item_model.dart';
import '../utils/dialog.dart';
import '../utils/hex_converter.dart';

class ArchivedList extends StatelessWidget {
  final List<NoteItem> notes;
  final Function(NoteItem) onDeleteNote;
  final Function(NoteItem) onRestoreNote;

  const ArchivedList({
    Key? key,
    required this.notes,
    required this.onRestoreNote,
    required this.onDeleteNote,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          final note = notes[index];
          return ArchivedListItem(
            onRestoreNote: onRestoreNote,
            onDeleteNote: onDeleteNote,
            note: note,
            onPressed: (note) {},
          );
        },
        childCount: notes.length,
      ),
    );
  }
}

class ArchivedListItem extends StatefulWidget {
  final NoteItem note;
  final void Function(NoteItem) onPressed;
  final Function(NoteItem) onDeleteNote;
  final Function(NoteItem) onRestoreNote;

  const ArchivedListItem({
    Key? key,
    required this.note,
    required this.onPressed,
    required this.onDeleteNote,
    required this.onRestoreNote,
  }) : super(key: key);

  @override
  State<ArchivedListItem> createState() =>
      _ArchivedListItemState();
}

class _ArchivedListItemState
    extends State<ArchivedListItem> {
  late String whatHappened;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => widget.onPressed(widget.note),
      child: Card(
        color: Colors.blue,
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
                        Icons.restore_from_trash_rounded,
                        color: Colors.white,
                        size: 25.0,
                      ),
                      Text(
                        'Restore',
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
                widget.onRestoreNote(widget.note);
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
                whatHappened = 'RESTORED';
                return await showConfirmationDialog(
                        context, 'restore') ==
                    true;
              default:
                assert(false);
                break;
            }
            return false;
          },
          child: Container(
            height: 100.0,
            color: widget.note.colorHex.isEmpty
                ? Colors.blueGrey
                : HexColor(widget.note.colorHex),
            padding: const EdgeInsets.symmetric(
                horizontal: 20, vertical: 10.0),
            child: Column(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        widget.note.title,
                        maxLines: 2,
                        style: const TextStyle(
                            overflow: TextOverflow.fade,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.white),
                      ),
                      Flexible(
                        child: Text(
                          widget.note.content,
                          maxLines: 2,
                          softWrap: true,
                          style: const TextStyle(
                              overflow:
                                  TextOverflow.ellipsis,
                              color: Colors.white),
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
                        size: 12,
                      ),
                      const SizedBox(
                        width: 20.0,
                      ),
                      Text(
                        widget.note.createdAt.toString(),
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
