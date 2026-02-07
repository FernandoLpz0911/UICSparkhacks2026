/// Home page work here
import 'package:flutter/material.dart';
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  //This is used to build the widget of the homepage app 
  Widget build(BuildContext context) {
    //This sets the basic design layou
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      //This is used to set the title
      appBar: AppBar(
        // 'leading' places a widget on the far left

        title: Text('Rehearsing Forever',
        style: TextStyle(fontSize:20,
        fontWeight: FontWeight.bold,
        color: const Color.fromARGB(255, 0, 0, 0),
        ),
        ),
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        elevation: 0.0, //Sets the shadow of the appbar
        centerTitle:true,

      ),
body: Center(
        child: Row( // Changed from Column to Row
          mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Centers them horizontally
          children: [
            GestureDetector(
              onTap: () {
                print("Box 1 was clicked!");
              },
              child: Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 227, 196, 57),
                  borderRadius: BorderRadius.circular(40),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(1.0), // Shadow color
                      spreadRadius: 2, // How wide the shadow spreads
                      blurRadius: 0,   // How soft the shadow looks
                      offset: const Offset(5, 3), // Moves shadow down by 3 pixels
                    ),
                  ],
                ),
                child: const Center(child: Text("Make a Lobby")),
              ),
            ),
            GestureDetector(
              onTap: () {
                print("Box 2 was clicked!");
              },
              child: Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 216, 136, 40),
                  borderRadius: BorderRadius.circular(40),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(1), // Shadow color
                      spreadRadius: 2, // How wide the shadow spreads
                      blurRadius: 0,   // How soft the shadow looks
                      offset: const Offset(5, 3), // Moves shadow down by 3 pixels
                    ),
                  ],
                ),
                child: const Center(child: Text("Join a Lobby")),
              ),
            ),
            // First Container
          ],
        ),
      ),
    );

  }
}