import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'pages/home_page.dart';
import 'providers/notes_provider.dart';
import 'providers/theme_provider.dart';

void main() {
  runApp(MyApp()); // Run the application
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // Provide the NotesProvider using ChangeNotifierProvider
        ChangeNotifierProvider(create: (context) => NotesProvider()),
        // Provide the ThemeProvider using ChangeNotifierProvider
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false, // Hide debug banner in the app
            theme: themeProvider.getTheme(), // Apply the theme provided by ThemeProvider
            home: const HomePage(), // Set HomePage as the initial route
          );
        },
      ),
    );
  }
}
