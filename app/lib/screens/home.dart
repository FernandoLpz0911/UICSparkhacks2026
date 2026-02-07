import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: HomePage(),
  ));
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        title: const Text(
          'Rehearsing Forever',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 0, 0, 0),
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        elevation: 0.0,
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            
            // --- NEW: ONE CONTAINER FOR ALL STARS ---
            Container(
              width: 350, // Matches the width of the bottom button
              height: 60, // Height of the star bar

              // Inside the container, we have a Row of 3 stars
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center, // Spaced evenly inside
                children: const [
                  Icon(Icons.star, size: 35, color: Colors.amber),
                  SizedBox(width:2),
                  Icon(Icons.star, size: 35, color: Colors.amber),
                  SizedBox(width:2),
                  Icon(Icons.star, size: 35, color: Colors.amber),
                ],
              ),
            ),

            const SizedBox(height: 15), // Spacing

            // --- MIDDLE BUTTONS (Make/Join) ---
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () => print("Make Lobby clicked"),
                  child: Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 227, 196, 57),
                      borderRadius: BorderRadius.circular(40),
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
                GestureDetector(
                  onTap: () => print("Join Lobby clicked"),
                  child: Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 216, 136, 40),
                      borderRadius: BorderRadius.circular(40),
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

            const SizedBox(height: 30),

            // --- BOTTOM BUTTON (How to Play) ---
            GestureDetector(
              onTap: () => print("How to play clicked"),
              child: Container(
                width: 350,
                height: 70,
                decoration: BoxDecoration(
                  color: Colors.white,
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
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Text(
                          "How to play",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(width: 8),
                        Icon(
                          Icons.local_fire_department,
                          color: Colors.black,
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