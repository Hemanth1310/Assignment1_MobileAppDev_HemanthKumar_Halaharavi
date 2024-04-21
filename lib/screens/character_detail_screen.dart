import 'package:flutter/material.dart';
import 'package:ue1_basisprojekt/db/character.dart';

class CharacterDetailScreen extends StatelessWidget {
  final Character character;
  final color = const Color(0xff86090A);
  const CharacterDetailScreen({
    required this.character,
    Key? key,
  }) : super(key: key);

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
                  padding: const EdgeInsets.all(20.0), child: Text(character.name,  style: TextStyle(
              color: Colors.white, // Set text color to white
            ),))
            ]),
       backgroundColor: color, 
      ),
      body: SafeArea(
        child: Center(
        /** Card Widget **/
        child:Padding(
            padding: const EdgeInsets.all(50.0),
        child: Card(
          elevation: 50,
          shadowColor: Colors.black,
          color: Color.fromARGB(255, 241, 180, 193),
          
          child: SizedBox(
            
            
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
              _buildTextRow('Gender', character.gender),
              SizedBox(height: 8),
              _buildTextRow('Aliases', character.aliases.join(', '))
            ],
          ),
        ),
      ),
    )))));
  }

  Widget _buildTextRow(String key, String value) {
    return Row(
      children: [
        Text(
          key,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 17,
          ),
        ),
        SizedBox(width: 8),
        Expanded(
          child: Text(
            value,
            style: TextStyle(fontSize: 17),
            overflow: TextOverflow.visible,
            textAlign: TextAlign.end,
          ),
        ),
      ],
    );
  }
}
