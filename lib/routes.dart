import 'package:flutter/material.dart';
import 'package:note_app/screen/add_note_screen.dart';
import 'package:note_app/screen/archived_note_screen.dart';
import 'package:note_app/screen/edit_screen.dart';
import 'package:note_app/screen/note_details_screen.dart';
import 'package:note_app/screen/splash_screen.dart';
import 'package:note_app/screen/view_all_screen.dart';

import 'model/note_item_model.dart';

final Map<String, WidgetBuilder> routes = {
  AddNoteScreen.routeName: (context) =>
      const AddNoteScreen(),
  SplashScreen.routeName: (context) => const SplashScreen(),
  ArchivedNotesScreen.routeName: (context) =>
      const ArchivedNotesScreen(),
  AllNotesScreen.routeName: (context) =>
      const AllNotesScreen(),
  NoteDetailScreen.routeName: (context) => NoteDetailScreen(
      noteItem: ModalRoute.of(context)!.settings.arguments
          as NoteItem),
  EditScreen.routeName: (context) => EditScreen(
      noteItem: ModalRoute.of(context)!.settings.arguments
          as NoteItem),
};
