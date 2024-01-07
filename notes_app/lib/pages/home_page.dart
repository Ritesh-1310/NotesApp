import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/note.dart';
import '../providers/notes_provider.dart';
import '../providers/theme_provider.dart';
import 'add_new_note.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer2<NotesProvider, ThemeProvider>(
      builder: (context, notesProvider, themeProvider, child) {
        String searchQuery = "";

        return Scaffold(
          appBar: AppBar(
            title: const Text("Notes App"), // Display the app title in the app bar
            centerTitle: true, // Center-align the app title in the app bar
            actions: [
              IconButton(
                icon: const Icon(Icons.lightbulb), // Icon for toggling theme
                onPressed: () {
                  themeProvider.toggleTheme(); // Toggle between light and dark themes
                },
              ),
            ],
          ),
          body: (notesProvider.isLoading == false) ? SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    onChanged: (val) {
                      searchQuery = val; // Update searchQuery on text change
                    },
                    decoration: InputDecoration(
                      hintText: "Search", // Hint text for search input
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                    ),
                  ),
                ),
                Expanded(
                  child: (notesProvider.notes.isNotEmpty) ? GridView.builder(
                    padding: const EdgeInsets.all(8),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: _getCrossAxisCount(context), // Determine cross-axis count
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    itemCount: notesProvider.getFilteredNotes(searchQuery).length,
                    itemBuilder: (context, index) {
                      Note currentNote = notesProvider.getFilteredNotes(searchQuery)[index];

                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AddNewNotePage(
                                isUpdate: true,
                                note: currentNote,
                              ),
                            ),
                          );
                        },
                        onLongPress: () {
                          notesProvider.deleteNote(currentNote); // Delete note on long press
                        },
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 4,
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            constraints: BoxConstraints(
                              minHeight: 100,
                              minWidth: 100,
                              maxWidth: _getContainerWidth(context),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  currentNote.title!,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color: themeProvider.getTheme().textTheme.bodyText1?.color,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 8),
                                Flexible(
                                  child: Text(
                                    currentNote.content!,
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: themeProvider.getTheme().textTheme.bodyLarge?.color,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 5,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ) : Center(
                    child: Text(
                      "No notes found!", // Display message for empty notes
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: themeProvider.getTheme().textTheme.bodyLarge?.color,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ) : const Center(
            child: CircularProgressIndicator(), // Show loading indicator when notes are loading
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  fullscreenDialog: true,
                  builder: (context) => const AddNewNotePage(
                    isUpdate: false, // Set flag to indicate new note creation
                  ),
                ),
              );
            },
            child: const Icon(Icons.add), // Icon for adding a new note
          ),
        );
      },
    );
  }

  // Determine the number of columns for the GridView based on screen width
  int _getCrossAxisCount(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return (screenWidth > 600) ? 4 : 2; // Adjust the cross axis count as needed
  }

  // Determine the container width for each note card based on screen width
  double _getContainerWidth(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return (screenWidth > 600) ? screenWidth / 4 - 20 : double.infinity;
    // Change the value 4 to adjust the number of columns for desktop
  }
}
