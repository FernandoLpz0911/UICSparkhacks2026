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
        child: Column( // 1. Use Column to stack vertically
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            
            // --- TOP SECTION: The two side-by-side buttons ---
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Button 1
                GestureDetector(
                  onTap: () => print("Make Lobby clicked"),
                  child: Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 227, 196, 57),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(1),
                          spreadRadius: 3,
                          blurRadius: 0,
                          offset: const Offset(5, 3),
                        ),
                      ],
                    ),
                    child: const Center(child: Text("Make a Lobby")),
                  ),
                ),

                // Button 2
                GestureDetector(
                  onTap: () => print("Join Lobby clicked"),
                  child: Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 216, 136, 40),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(1),
                          spreadRadius: 3,
                          blurRadius: 0,
                          offset: const Offset(5, 3),
                        ),
                      ],
                    ),
                    child: const Center(child: Text("Join a Lobby")),
                  ),
                ),
              ],
            ),

            // 2. Add Space between the top row and the bottom button
            const SizedBox(height: 30), 

            // --- BOTTOM SECTION: The long horizontal button ---
            GestureDetector(
              onTap: () => print("How to play clicked"),
              child: Container(
                width: 350, // 3. Make this wide (Horizontal)
                height: 70, // Keep height smaller than width
                decoration: BoxDecoration(
                  color: Colors.white, // Give it a distinct color
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(1),
                      spreadRadius: 3,
                      blurRadius: 0,
                      offset: const Offset(5, 3),
                    ),
                  ],
                ),
child: Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20),
                    
                    // CHANGED: Using a Row to combine Text + Icon
                    child: Row(
                      mainAxisSize: MainAxisSize.min, // Keeps the row tight to the content
                      children: const [
                        Text(
                          "How to play",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(width: 8), // Space between text and icon
                        Icon(
                          Icons.local_fire_department, // The Fire Icon
                          color: Colors.black, // Now we can make it black!
                          size: 24,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}