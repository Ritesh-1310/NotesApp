import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import '../models/note.dart';

class ApiService {
  static String _baseUrl = "http://notesapp-env.eba-hirxnfpm.ap-south-1.elasticbeanstalk.com/notes";

  // Add a new note via API
  static Future<void> addNote(Note note) async {
    Uri requestUri = Uri.parse(_baseUrl + "/add");
    var response = await http.post(requestUri, body: note.toMap());
    var decoded = jsonDecode(response.body);
    log(decoded.toString()); // Log the decoded response
  }
  
  // Delete a note via API
  static Future<void> deleteNote(Note note) async {
    Uri requestUri = Uri.parse(_baseUrl + "/delete");
    var response = await http.post(requestUri, body: note.toMap());
    var decoded = jsonDecode(response.body);
    log(decoded.toString()); // Log the decoded response
  }

  // Fetch notes for a specific user via API
  static Future<List<Note>> fetchNotes(String userid) async {
    Uri requestUri = Uri.parse(_baseUrl + "/list");
    var response = await http.post(requestUri, body: { "userid": userid });
    var decoded = jsonDecode(response.body);
    
    List<Note> notes = [];
    for(var noteMap in decoded) {
      Note newNote = Note.fromMap(noteMap);
      notes.add(newNote);
    }

    return notes;
  }
}
