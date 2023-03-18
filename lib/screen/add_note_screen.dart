import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 13,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16.0),
                child: Row(
                  mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        height: 50,
                        width: 50,
                        margin: const EdgeInsets.only(
                            right: 10),
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(15),
                            color: lightGray),
                        child: const Center(
                          child: Icon(
                            Icons.close_rounded,
                            color: white,
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        final title = titleController
                            .value.text
                            .trim();
                        final content = contentController
                            .value.text
                            .trim();
                        _createNote(title, content);
                      },
                      child: Container(
                        height: 50,
                        width: 50,
                        margin: const EdgeInsets.only(
                            right: 10),
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(15),
                            color: lightGray),
                        child: const Center(
                          child: Icon(
                            Icons.save_as,
                            color: white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Form(
                key: _formKey,
                autovalidateMode:
                    AutovalidateMode.onUserInteraction,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 18.0),
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
                            hintText: 'Title',
                            hintStyle: GoogleFonts.nunito(
                                fontSize: 40,
                                fontWeight: FontWeight.w400,
                                color: lightGray),
                            filled: true,
                            fillColor: white,
                            border: InputBorder.none),
                      ),
                      const SizedBox(
                        height: 22,
                      ),
                      TextFormField(
                        keyboardType:
                            TextInputType.multiline,
                        controller: contentController,
                        maxLines: 17,
                        decoration: InputDecoration(
                            hintText: 'Type something...',
                            hintStyle: GoogleFonts.nunito(
                                fontSize: 23,
                                color: lightGray),
                            fillColor: Colors.white,
                            filled: true,
                            border: InputBorder.none),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              Text(
                'Pick a Note Colour',
                style: GoogleFonts.nunito(
                  fontSize: 23,
                  color: white,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 28.0),
                child: SizedBox(
                  height: 100,
                  child: ListView.separated(
                    separatorBuilder: (_, __) =>
                        const SizedBox(width: 20),
                    scrollDirection: Axis.horizontal,
                    itemCount: noteColors.length,
                    itemBuilder: (_, int index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedColor =
                                noteColors[index];
                          });
                        },
                        child: buildColorContainer(
                            noteColors[index]),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
