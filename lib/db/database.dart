//The class shall be responsible to store the GoT characters loaded from the API in a database
import 'package:ue1_basisprojekt/db/character.dart';
import 'package:ue1_basisprojekt/networking/api.dart';
import 'package:hive_flutter/hive_flutter.dart';
class Database {
  //This method will Check if database already has charetors else fetch some characters and return charecters at the end
  Future<List<Character>> getCharacters() async {

  final charactersBox = await Hive.openBox<Character>('characters');

  //Check is database is empty. If empty then fetch characters to store in database. Return Characters List at the end 
  if (charactersBox.isEmpty) {
     API().fetchRemoteGoTCharacters(3).then((characters) {
        this.save(characters: characters);
    });
     return charactersBox.values.toList();
  }
  else{
     return charactersBox.values.toList();
  }
 

}

  //The method is to store a list of GoT characters in a database
  void save({required List<Character> characters}) async{
    if (characters.isNotEmpty) {
      //TODO: save `characters` into a real database.

    //push the characters from Api into database  
    final charactersBox = await Hive.openBox<Character>('characters');
      for (var character in characters) {
        charactersBox.put(character.name, character);
      }

      print(charactersBox.values.toList());
    }
  }
}
