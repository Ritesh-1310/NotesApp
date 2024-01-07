import 'package:flutter/cupertino.dart';
import '../models/note.dart';
import '../services/api_service.dart';

class NotesProvider with ChangeNotifier {
  bool isLoading = true; // Flag to indicate if notes are currently loading
  List<Note> notes = []; // List to store fetched notes

  NotesProvider() {
    fetchNotes(); // Fetch notes upon provider initialization
  }

  // Filter notes based on a search query
  List<Note> getFilteredNotes(String searchQuery) {
    return notes.where((element) =>
        element.title!
            .toLowerCase()
            .contains(searchQuery.toLowerCase()) ||
        element.content!
            .toLowerCase()
            .contains(searchQuery.toLowerCase())).toList();
  }

  // Sort notes based on date added
  void sortNotes() {
    notes.sort((a, b) => b.dateadded!.compareTo(a.dateadded!));
  }

  // Add a new note to the list and notify listeners
  void addNote(Note note) {
    notes.add(note);
    sortNotes();
    notifyListeners();
    ApiService.addNote(note); // Add note via API service
  }

  // Update an existing note in the list and notify listeners
  void updateNote(Note note) {
    int indexOfNote =
        notes.indexOf(notes.firstWhere((element) => element.id == note.id));
    notes[indexOfNote] = note;
    sortNotes();
    notifyListeners();
    ApiService.addNote(note); // Update note via API service
  }

  // Delete a note from the list and notify listeners
  void deleteNote(Note note) {
    int indexOfNote =
        notes.indexOf(notes.firstWhere((element) => element.id == note.id));
    notes.removeAt(indexOfNote);
    sortNotes();
    notifyListeners();
    ApiService.deleteNote(note); // Delete note via API service
  }

  // Fetch notes from the API asynchronously
  void fetchNotes() async {
    notes = await ApiService.fetchNotes("Ritesh Ranjan");
    sortNotes();
    isLoading = false;
    notifyListeners();
  }
}
