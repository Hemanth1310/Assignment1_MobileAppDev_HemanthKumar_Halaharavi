import 'package:flutter/material.dart';
import 'package:ue1_basisprojekt/db/character.dart';
import 'package:ue1_basisprojekt/db/database.dart';
import 'package:ue1_basisprojekt/networking/api.dart';
import './character_detail_screen.dart';

class CharactersListScreen extends StatefulWidget {
  @override
  _CharactersListScreenState createState() => _CharactersListScreenState();
}

class _CharactersListScreenState extends State<CharactersListScreen> {
  List<Character>? characters;
  final color = const Color(0xff86090A);
  @override
  void initState() {
    // first the characters are loaded from the database and displayed

    //Load charectors from the database which works as a cache with only limited number of charaters
    Database().getCharacters().then((characters){
       setState(() {
        // the setState method re-renders the UI
        this.characters = characters;
      });
    });

    // then the characters are loaded from the API and displayed as soon as they are there
      //Fetch characters from the first 75 pages 
    API().fetchRemoteGoTCharacters(75).then((characters) {
      setState(() {
        // the setState method re-renders the UI
        this.characters = characters;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                  Image.asset(
                 'asset/images/gotlogo.png',
                  fit: BoxFit.contain,
                  height: 32,
              ),
              Container(
                  padding: const EdgeInsets.all(20.0), child: Text('Game Of Thrones',  style: TextStyle(
              color: Colors.white, // Set text color to white
            ),))
            ]),
       backgroundColor: color,
      

       
      ),
      body: SafeArea(
        
        child: ListView.separated(
          itemBuilder: (context, index) => _buildCharacterListTile(index),
          separatorBuilder: (_, __) => Divider(),
          itemCount: characters?.length ?? 0,
          
        ),
      ),
    );
  }

  Widget _buildCharacterListTile(int index) {
    final Character character = characters![index];
    return ListTile(
      title: Text(
        '${index + 1}. ${character.name}',
        style: TextStyle(fontSize: 17),
      ),
      trailing: Icon(Icons.arrow_forward_ios_outlined),
      onTap: () {
        //TODO: open the CharacterDetailScreen with the character.
         Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CharacterDetailScreen(character: character)),
        );
      },
    );
  }
}
