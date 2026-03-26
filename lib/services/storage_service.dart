import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/note.dart';

class StorageService {
  static const String notesKey = "notes";
  static const String pinKey = "pin";

  static Future<void> saveNotes(List<Note> notes) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> encoded =
        notes.map((n) => jsonEncode(n.toJson())).toList();
    await prefs.setStringList(notesKey, encoded);
  }

  static Future<List<Note>> getNotes() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> raw = prefs.getStringList(notesKey) ?? [];

    return raw.map((e) => Note.fromJson(jsonDecode(e))).toList();
  }

  static Future<void> savePin(String pin) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(pinKey, pin);
  }

  static Future<String?> getPin() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(pinKey);
  }

  static Future<bool> hasPin() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey(pinKey);
  }
}