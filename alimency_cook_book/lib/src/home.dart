import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  static const routeName = '/home';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 197, 223, 50),
      appBar: AppBar(title: const Text("Alimency"), backgroundColor: const Color.fromARGB(255, 24, 24, 24), centerTitle: true, titleTextStyle: TextStyle(color: Colors.white),),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    child: Card(
                        child: SizedBox(
                  height: 200,
                  width: 200,
                  child: FloatingActionButton(
                      child: Icon(Icons.favorite), onPressed: () {}),
                ))),
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
                Container(
                    child: Card(
                        child: SizedBox(
                  height: 200,
                  width: 200,
                  child: FloatingActionButton(
                      child: Icon(Icons.history), onPressed: () {}),
                ))),
                Container(
                    child: Card(
                        child: SizedBox(
                  height: 200,
                  width: 200,
                  child: FloatingActionButton(
                      child: Icon(Icons.food_bank), onPressed: () {}),
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
      ),
    );
  }
}
