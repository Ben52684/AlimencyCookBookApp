

import 'package:flutter/material.dart';

class GeneratedRecipesView extends StatefulWidget {
  
  static const routeName = '/generated_recipes';
  
  const GeneratedRecipesView({super.key});
  
  @override
  GeneratedRecipesState createState() => GeneratedRecipesState();
}

class GeneratedRecipesState extends State<GeneratedRecipesView> {
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 197, 223, 50),
      appBar: AppBar(
        title: const Text("Alimency"),
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        centerTitle: true,
        titleTextStyle: const TextStyle(color: Colors.black),
      ),
      body: Column(
        children: [
          Card(
            child: ListTile(
              title: Text('data'),
            )
          ),
        ],
      )
    );
  }





}