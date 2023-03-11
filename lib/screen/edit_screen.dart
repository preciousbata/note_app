import 'package:flutter/material.dart';

import '../injection.dart';
import '../model/note_item_model.dart';
import '../repository/note_repository.dart';
import '../utils/constant.dart';
import '../utils/hex_converter.dart';

class EditScreen extends StatefulWidget {
  final NoteItem noteItem;
  static String routeName = '/edit_note';

  const EditScreen({Key? key, required this.noteItem})
      : super(key: key);

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  final updateTitleController = TextEditingController();
  final updateContentController = TextEditingController();
  final noteRepository = sl.get<NoteRepository>();
  final _formKey = GlobalKey<FormState>();

  String _selectedColor = '';
  bool updateNoteColor = false;

  void _updateNote(String title, String content,
      String referenceId, String color) {
    if (_formKey.currentState!.validate()) {
      noteRepository.updateNote(
          title, content, referenceId, color);
      final snackBar = SnackBar(
        content: const Text('Note Edited Successfully'),
        backgroundColor: (Colors.black12),
        action: SnackBarAction(
          label: 'dismiss',
          onPressed: () {},
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      Navigator.pop(context);
    }
  }

  Widget buildColorContainer(String hex) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: HexColor(hex),
        shape: BoxShape.circle,
      ),
      child: _selectedColor == hex
          ? const Center(
              child: Icon(Icons.check, color: Colors.amber))
          : const SizedBox.shrink(),
    );
  }

  @override
  void initState() {
    updateContentController.text = widget.noteItem.content;
    updateTitleController.text = widget.noteItem.title;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.blueGrey,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(25, 80, 25, 0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Text(
                  'Edit Note',
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: primaryColor),
                ),
                const SizedBox(
                  height: 30,
                ),
                Form(
                  key: _formKey,
                  autovalidateMode:
                      AutovalidateMode.onUserInteraction,
                  child: Column(
                    children: [
                      TextFormField(
                        keyboardType: TextInputType.text,
                        controller: updateTitleController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'title cannot be empty';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: 'Title',
                          filled: true,
                          fillColor: Colors.white,
                          enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      TextFormField(
                        keyboardType:
                            TextInputType.multiline,
                        controller: updateContentController,
                        maxLines: 6,
                        decoration: InputDecoration(
                            labelText: 'Content',
                            fillColor: Colors.white,
                            filled: true,
                            enabledBorder:
                                OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius
                                            .circular(10))),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Pick a Note Colour',
                      style: TextStyle(
                          color: primaryColor,
                          fontSize: 18),
                    ),
                    SizedBox(
                      height: 100,
                      child: ListView.separated(
                        separatorBuilder: (_, __) =>
                            const SizedBox(width: 20),
                        scrollDirection: Axis.horizontal,
                        itemCount: colors.length,
                        itemBuilder: (_, int index) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                updateNoteColor = true;
                                _selectedColor =
                                    colors[index];
                              });
                            },
                            child: Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                color:
                                    HexColor(colors[index]),
                                shape: BoxShape.circle,
                              ),
                              child: updateNoteColor
                                  ? buildColorContainer(
                                      colors[index])
                                  : colors[index] ==
                                          widget.noteItem
                                              .colorHex
                                      ? const Center(
                                          child: Icon(
                                              Icons.check,
                                              color: Colors
                                                  .amber))
                                      : const SizedBox
                                          .shrink(),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
                ElevatedButton(
                  onPressed: () {
                    final title = updateTitleController
                        .value.text
                        .trim();
                    final content = updateContentController
                        .value.text
                        .trim();
                    final noteColor = _selectedColor;
                    _updateNote(
                        title,
                        content,
                        widget.noteItem.referenceId,
                        noteColor);
                  },
                  child: const Text('Update Note'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
