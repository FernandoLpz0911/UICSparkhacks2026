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
          leading: IconButton(
          icon: const Icon(Icons.notifications),
          color: Colors.black, // Set the icon color
          //Functionality to be added
          onPressed: () {
            // Add what happens when you click it
          },
        ),
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
          mainAxisAlignment: MainAxisAlignment.center, // Centers them horizontally
          children: [
            // First Container
            Container(
              width: 150,
              height: 150,
              decoration:BoxDecoration(
              color:const Color.fromARGB(255, 227, 196, 57),
              borderRadius: BorderRadius.circular(20)),
              child: const Center(child: Text("Make a Lobby")),
            ),

            const SizedBox(width: 20), // Changed height to width for horizontal spacing

            // Second Container
            Container(
              width: 150,
              height: 150,
              
              decoration:BoxDecoration(
              color: const Color.fromARGB(255, 216, 136, 40),
              borderRadius: BorderRadius.circular(20),),
              child: const Center(child: Text("Join a Lobby")),
            ),
          ],
        ),
      ),
    );

  }
}