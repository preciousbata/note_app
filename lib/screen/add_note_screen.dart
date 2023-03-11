import 'package:flutter/material.dart';
import 'package:note_app/injection.dart';
import 'package:note_app/repository/note_repository.dart';

import '../utils/constant.dart';
import '../utils/hex_converter.dart';

class AddNoteScreen extends StatefulWidget {
  static String routeName = '/add_note';

  const AddNoteScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<AddNoteScreen> createState() =>
      _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  final titleController = TextEditingController();
  final contentController = TextEditingController();
  final noteRepository = sl.get<NoteRepository>();
  final _formKey = GlobalKey<FormState>();

  String _selectedColor = '';

  void _createNote(String title, String content) {
    if (_formKey.currentState!.validate()) {
      noteRepository.createNote(
          title, content, _selectedColor);
      final snackBar = SnackBar(
        content: const Text('Note Created Successfully'),
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
                  'Create New Note',
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
                        controller: titleController,
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
                            enabledBorder:
                                OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius
                                            .circular(10))),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      TextFormField(
                        keyboardType:
                            TextInputType.multiline,
                        controller: contentController,
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
                                _selectedColor =
                                    colors[index];
                              });
                            },
                            child: buildColorContainer(
                                colors[index]),
                          );
                        },
                      ),
                    ),
                  ],
                ),
                ElevatedButton(
                  onPressed: () {
                    final title =
                        titleController.value.text.trim();
                    final content =
                        contentController.value.text.trim();
                    _createNote(title, content);
                  },
                  child: const Text('Create New Note'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
