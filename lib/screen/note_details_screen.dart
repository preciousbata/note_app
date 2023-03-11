import 'package:flutter/material.dart';

import '../model/note_item_model.dart';
import 'edit_screen.dart';

class NoteDetailScreen extends StatefulWidget {
  final NoteItem noteItem;
  static String routeName = '/note_detail';

  const NoteDetailScreen({
    Key? key,
    required this.noteItem,
  }) : super(key: key);

  @override
  State<NoteDetailScreen> createState() =>
      _NoteDetailScreenState();
}

class _NoteDetailScreenState
    extends State<NoteDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.noteItem.title.toUpperCase()),
          centerTitle: true,
          actions: [
            IconButton(
                onPressed: () => Navigator.pushNamed(
                    context, EditScreen.routeName,
                    arguments: widget.noteItem),
                icon: const Icon(Icons.edit))
          ],
        ),
        body: Container(
            margin:
                const EdgeInsets.symmetric(horizontal: 12),
            child: Text(
              widget.noteItem.content,
              style: const TextStyle(fontSize: 20),
            )));
  }
}
