/// Home page work here
import 'package:flutter/material.dart';
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  //This is used to build the widget of the homepage app 
  Widget build(BuildContext context) {
    //This sets the basic design layou
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 230, 249, 168),
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
        backgroundColor: const Color.fromARGB(255, 230, 249, 168),
        elevation: 0.0, //Sets the shadow of the appbar
        centerTitle:true,

      ),

    );

  }
}