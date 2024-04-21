import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:ue1_basisprojekt/db/character.dart';
import 'package:ue1_basisprojekt/screens/characters_list_screen.dart';
// import 'package:hive/hive.dart';
// import 'package:path_provider/path_provider.dart' as path_provider;
void main() async{
  // WidgetsFlutterBinding.ensureInitialized();
  // final appDocumentDir = await path_provider.getApplicationDocumentsDirectory();
  // Hive.init(appDocumentDir.path);
  // await Hive.initFlutter();
  // var box = await Hive.openBox('myBox');
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter(); // Initialize Hive Flutter

  // Register the adapter for the Character class
  Hive.registerAdapter(CharacterAdapter());

  // Open Hive box
  await Hive.openBox<Character>('characters');

  runApp(
    MaterialApp(
      title: 'GoT Characters',
      theme: ThemeData(
        primarySwatch: Colors.red,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: CharactersListScreen(),
    ),
  );
}
