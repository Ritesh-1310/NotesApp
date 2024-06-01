import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import '../models/note.dart';
import '../providers/notes_provider.dart';
import '../providers/theme_provider.dart';

class AddNewNotePage extends StatefulWidget {
  final bool isUpdate;
  final Note? note;

  const AddNewNotePage({Key? key, required this.isUpdate, this.note})
      : super(key: key);

  @override
  _AddNewNotePageState createState() => _AddNewNotePageState();
}

class _AddNewNotePageState extends State<AddNewNotePage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();
  FocusNode noteFocus = FocusNode();

  void addNewNote() {
    // Create a new note instance and add it to the provider
    Note newNote = Note(
      id: const Uuid().v1(),
      userid: "Ritesh Ranjan",
      title: titleController.text,
      content: contentController.text,
      dateadded: DateTime.now(),
    );
    Provider.of<NotesProvider>(context, listen: false).addNote(newNote);
    Navigator.pop(context); // Return to the previous screen
  }

  void updateNote() {
    // Update the existing note and notify the provider
    widget.note!.title = titleController.text;
    widget.note!.content = contentController.text;
    widget.note!.dateadded = DateTime.now();
    Provider.of<NotesProvider>(context, listen: false).updateNote(widget.note!);
    Navigator.pop(context); // Return to the previous screen
  }

  @override
  void initState() {
    super.initState();
    // Populate text fields if it's an update operation
    if (widget.isUpdate) {
      titleController.text = widget.note!.title!;
      contentController.text = widget.note!.content!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return Scaffold(
          appBar: AppBar(
            actions: [
              IconButton(
                onPressed: () {
                  // Save changes when the checkmark icon is pressed
                  if (widget.isUpdate) {
                    updateNote();
                  } else {
                    addNewNote();
                  }
                },
                icon: const Icon(Icons.check), 
              ),
            ],
          ),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextFormField(
                    controller: titleController,
                    autofocus: (widget.isUpdate == true) ? false : true,
                    onFieldSubmitted: (val) {
                      if (val != "") {
                        noteFocus.requestFocus();
                      }
                    },
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: themeProvider.getTheme().textTheme.bodyLarge?.color,
                    ),
                    decoration: InputDecoration(
                      hintText: "Title", // Placeholder text for title input
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      hintStyle: TextStyle(
                        color: themeProvider.getTheme().hintColor,
                      ),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: TextFormField(
                      controller: contentController,
                      focusNode: noteFocus,
                      maxLines: null,
                      style: TextStyle(
                        fontSize: 20,
                        color: themeProvider.getTheme().textTheme.bodyLarge?.color,
                      ),
                      decoration: InputDecoration(
                        hintText: "Note", // Placeholder text for note input
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        hintStyle: TextStyle(
                          color: themeProvider.getTheme().hintColor,
                        ),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
