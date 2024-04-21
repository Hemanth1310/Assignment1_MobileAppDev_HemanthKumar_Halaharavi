import 'package:hive/hive.dart';
part 'character.g.dart';


@HiveType(typeId: 0)
class Character extends HiveObject {
  Character({
    required this.name,
    required this.gender,
    required this.aliases,
  });

  @HiveField(0)
  late String name;
  @HiveField(1)
  late String gender;
  @HiveField(2)
  late List<String> aliases;

  factory Character.fromJson(Map<String, dynamic> json) {
    // Assume 'traits' is a list of strings in the JSON
    List<String> aliasList = [];
    if (json['aliases'] != null) {
      // Iterate through the list of traits and add them to the list
      for (var trait in json['aliases']) {
        aliasList.add(trait.toString());
      }
    }

    return Character(
      name: json['name'] ?? '',
      gender: json['gender'] ?? '',
      aliases: aliasList,
    );
  }
}

