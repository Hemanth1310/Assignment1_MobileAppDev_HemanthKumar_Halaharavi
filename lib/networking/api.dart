// The class is responsible to load the GoT characters from the GoTAPI (on https://anapioficeandfire.com/)
import 'dart:async';
import 'dart:convert';

import 'package:ue1_basisprojekt/db/character.dart';
import 'package:http/http.dart' as http;

class API {
  // Note: the documentation for the API can be found here: https://anapioficeandfire.com/Documentation
  final String _charactersRoute =
      "https://anapioficeandfire.com/api/characters";

  // Loads the list of GoT characters
  Future<List<Character>> fetchRemoteGoTCharacters(int pagenum) async {
    // TODO: Load GoT characters from the _charactersRoute and return them.
    // For the API calls we recommend to use the 'http' package
    Set<String> uniqueNames = Set<String>();
    List<Character> characters = [];

  //Go through different pages and fetch the characters
    for (int page = 1; page <= pagenum; page++) {
      final response = await http
          .get(Uri.parse(_charactersRoute + "?page=$page&pageSize=10"));
      if (response.statusCode == 200) {
        // If the server returns a 200 OK response, parse the JSON
        final List<dynamic> data = jsonDecode(response.body);

        // Iterate through the data and filter valid characters
        for (var characterData in data) {
          try {
            Character character = Character.fromJson(characterData);

            // Check if the character meets the criteria of task 1
            if (character.name.isNotEmpty &&
                character.gender.isNotEmpty &&
                character.aliases.isNotEmpty &&
                !uniqueNames.contains(character.name)) {
              characters.add(character);
              uniqueNames.add(character.name);
            }
          } catch (e) {
            // Invalid character data, skip it
            continue;
          }
        }
      } else {
        // If the server did not return a 200 OK response, throw an exception.
        throw Exception('Failed to load characters');
      }
    }
    return characters;
  }
}
