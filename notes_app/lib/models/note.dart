// Class representing a Note entity
class Note {
  String? id; // Unique identifier for the note
  String? userid; // Identifier for the user associated with the note
  String? title; // Title of the note
  String? content; // Content or description of the note
  DateTime? dateadded; // Date when the note was added

  // Constructor for creating a Note object
  Note({this.id, this.userid, this.title, this.content, this.dateadded});

  // Factory method to create a Note object from a map
  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(
      id: map["id"], // Assign value from the "id" key in the map
      userid: map["userid"], // Assign value from the "userid" key in the map
      title: map["title"], // Assign value from the "title" key in the map
      content: map["content"], // Assign value from the "content" key in the map
      dateadded: DateTime.tryParse(map["dateadded"]), // Parse and assign value as DateTime
    );
  }

  // Method to convert the Note object to a map
  Map<String, dynamic> toMap() {
    return {
      "id": id, // Map key-value pair for the note id
      "userid": userid, // Map key-value pair for the user id
      "title": title, // Map key-value pair for the note title
      "content": content, // Map key-value pair for the note content
      "dateadded": dateadded!.toIso8601String() // Map key-value pair for the note's date added
    };
  }
}
