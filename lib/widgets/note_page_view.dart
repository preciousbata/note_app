import 'package:flutter/material.dart';

import '../model/note_item_model.dart';
import '../screen/note_details_screen.dart';
import '../utils/hex_converter.dart';

class NotePageView extends StatefulWidget {
  final List<NoteItem> notes;
  final Function(NoteItem) onDeleteNote;
  final Function(NoteItem) onArchiveNote;

  const NotePageView({
    Key? key,
    required this.notes,
    required this.onArchiveNote,
    required this.onDeleteNote,
  }) : super(key: key);

  @override
  State<NotePageView> createState() => _NotePageViewState();
}

class _NotePageViewState extends State<NotePageView> {
  final pageController =
      PageController(viewportFraction: 0.8);
  int pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: double.infinity,
      child: Column(
        children: [
          const SafeArea(
            child: Padding(
              padding: EdgeInsets.only(top: 68.0),
              child: Text(
                'Notes',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
              ),
            ),
          ),
          Expanded(
            child: PageView.builder(
              controller: pageController,
              itemCount: widget.notes.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8.0),
                  child: NotePage(
                    note: widget.notes[index],
                  ),
                );
              },
              onPageChanged: (currentIndex) {
                setState(() {
                  pageIndex = currentIndex;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}

class NotePage extends StatefulWidget {
  final NoteItem note;

  const NotePage({Key? key, required this.note})
      : super(key: key);

  @override
  State<NotePage> createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  bool isExpanded = false;

  void onPanUpdate(DragUpdateDetails details) {
    if (details.delta.dy < 0) {
      setState(() {
        isExpanded = true;
      });
    } else if (details.delta.dy > 0) {
      setState(() {
        isExpanded = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Stack(
      children: [
        AnimatedPositioned(
          bottom: isExpanded ? 150 : 200,
          width: isExpanded
              ? size.width * 0.68
              : size.width * 0.68,
          height: isExpanded
              ? size.height * 0.3
              : size.height * 0.29,
          duration: const Duration(milliseconds: 300),
          child: ExpandedContent(
            note: widget.note,
          ),
        ),
        AnimatedPositioned(
          duration: const Duration(milliseconds: 300),
          bottom: isExpanded ? 220 : 200,
          child: GestureDetector(
            onPanUpdate: onPanUpdate,
            onTap: () => Navigator.pushNamed(
                context, NoteDetailScreen.routeName,
                arguments: widget.note),
            child: Container(
              height: size.height * 0.3,
              width: size.width * 0.7,
              // padding: EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(
                    Radius.circular(10)),
                color: widget.note.colorHex.isEmpty
                    ? Colors.grey
                    : HexColor(widget.note.colorHex),
              ),
              child: Center(
                child: Text(
                  widget.note.title,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      color: Colors.white),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class ExpandedContent extends StatelessWidget {
  final NoteItem note;

  const ExpandedContent({Key? key, required this.note})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Flexible(
            child: Text(
              note.content,
              maxLines: 2,
              softWrap: true,
              style: const TextStyle(
                  overflow: TextOverflow.ellipsis,
                  color: Colors.black,
                  fontSize: 20),
            ),
          )
        ],
      ),
    );
  }
}
