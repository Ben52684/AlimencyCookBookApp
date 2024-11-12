import 'package:alimency_cook_book/src/view_models/pantry_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  static const routeName = '/home';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 197, 223, 50),
        appBar: AppBar(
          title: const Text("Alimency"),
          backgroundColor: const Color.fromARGB(255, 24, 24, 24),
          centerTitle: true,
          titleTextStyle: const TextStyle(color: Colors.white),
        ),
        body: Consumer<PantryViewModel>(
            builder: (context, pantryViewModel, child) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //Favourite Food Guides
                    Container(
                        child: Card(
                            child: SizedBox(
                      height: 200,
                      width: 200,
                      child: FloatingActionButton(
                          child: Icon(Icons.favorite), onPressed: () {}),
                    ))),
                    //Food Guide Forum
                    Container(
                        child: Card(
                            child: SizedBox(
                      height: 200,
                      width: 200,
                      child: FloatingActionButton(
                          child: Icon(Icons.library_books), onPressed: () {}),
                    )))
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //Meal Tracker and Expense Tracker
                    Container(
                        child: Card(
                            child: SizedBox(
                      height: 200,
                      width: 200,
                      child: FloatingActionButton(
                          child: Icon(Icons.history), onPressed: () {}),
                    ))),
                    //Users Pantry/Fridge
                    Container(
                        child: Card(
                            child: SizedBox(
                      height: 200,
                      width: 200,
                      child: FloatingActionButton(
                          child: Icon(Icons.food_bank),
                          onPressed: () {
                            Navigator.pushNamed(context, "/user_pantry");
                          }),
                    )))
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: SizedBox(
                        height: 100,
                        width: 100,
                        child: FloatingActionButton(
                          child: Icon(Icons.circle),
                          onPressed: () {},
                          shape: CircleBorder(),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          );
        }));
  }
}
