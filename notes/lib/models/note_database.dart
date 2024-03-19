import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:notes/models/note.dart';
import 'package:path_provider/path_provider.dart';

class NoteDatabase extends ChangeNotifier {
  static late Isar isar;

  //  I N I T I A L I Z E - D A T A B A S E
  static Future<void> initialize() async {
    final dir = await getApplicationDocumentsDirectory();
    isar =
        await Isar.open([NoteSchema, AppThemeModeSchema], directory: dir.path);

    final themeModeCount = await isar.appThemeModes.where().count();
    if (themeModeCount == 0) {
      final defaultThemeMode = AppThemeMode()..isDarkMode = true;
      await isar.writeTxn(() => isar.appThemeModes.put(defaultThemeMode));
    }
  }

  final List<Note> currentNotes = [];

  Future<void> addNote(String textFromUser) async {
    final newNote = Note()
      ..title = textFromUser
      ..data = "";
    await isar.writeTxn(() => isar.notes.put(newNote));
    fetchNotes();
  }

  // R E A D
  Future<void> fetchNotes() async {
    List<Note> fetchedNotes = await isar.notes.where().findAll();
    currentNotes.clear();
    currentNotes.addAll(fetchedNotes);
    notifyListeners();
  }

  Future<bool> getThemeMode() async {
    final themeMode = await isar.appThemeModes
        .get(0);

     // Assuming there's always an entry with ID 0
    return themeMode?.isDarkMode ?? true; // Default to true if not set
  }

  Future<void> updateThemeMode(bool isDarkMode) async {
  final themeMode = await isar.appThemeModes.get(0);
  themeMode?.isDarkMode = isDarkMode;
  await isar.writeTxn(() => isar.appThemeModes.put(themeMode!));
}

  // U P D A T E
  Future<void> updateNotes(int id, String newText) async {
    final existingNote = await isar.notes.get(id);
    if (existingNote != null) {
      existingNote.title = newText;
      await isar.writeTxn(() => isar.notes.put(existingNote));
      await fetchNotes();
    }
  }

  // D E L E T E
  Future<void> deleteNote(int id) async {
    await isar.writeTxn(() => isar.notes.delete(id));
    await fetchNotes();
  }

  Future<void> updateData(int id, String newData) async {
    final existingNote = await isar.notes.get(id);
    if (existingNote != null) {
      existingNote.data = newData;
      await isar.writeTxn(() => isar.notes.put(existingNote));
      await fetchNotes();
    }
  }
}
