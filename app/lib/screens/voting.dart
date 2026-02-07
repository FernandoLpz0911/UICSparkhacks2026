import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: VotePage(),
  ));
}

class VotePage extends StatefulWidget {
  const VotePage({super.key});

  @override
  State<VotePage> createState() => _VotePageState();
}

class _VotePageState extends State<VotePage> {
  // Sample data
  final List<String> players = [
    'Fawaz',
    'Joseph',
    'Connie',
    'Fernando',
    'Sophie',
    'Liam',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 253, 247, 247),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 253, 247, 247),
        elevation: 0.0,
        centerTitle: true,
        actions: [
          // Chat Button
          GestureDetector(
            onTap: () => print("Chat clicked"),
            child: Container(
              margin: const EdgeInsets.only(right: 10, top: 5, bottom: 4),
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              decoration: BoxDecoration(
                color: Colors.deepOrange,
                borderRadius: BorderRadius.circular(40),
                border: Border.all(color: Colors.black, width: 2),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Icon(Icons.chat_bubble, size: 18, color: Colors.black),
                  SizedBox(width: 8),
                  Text(
                    "chat",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 30),

          // VOTE Banner
          Center(
            child: Container(
              width: 300,
              padding: const EdgeInsets.symmetric(vertical: 20),
              decoration: BoxDecoration(
                color: Colors.yellow,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.black, width: 3),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black,
                    offset: Offset(5, 3),
                    blurRadius: 0,
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    "VOTE",
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 2.0,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(width: 10),
                  Icon(
                    Icons.priority_high_rounded,
                    size: 40,
                    color: Colors.black,
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 20), 

          // --- SCROLLABLE LIST OF BUTTONS ---
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ListView.builder(
                itemCount: players.length,
                itemBuilder: (context, index) {
                  return playerButton(players[index]);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  // --- UPDATED: LIST ITEM IS NOW A BUTTON ---
  Widget playerButton(String name) {
    return GestureDetector(
      onTap: () {
        // This is where you handle the click!
        print("Voted for $name");
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFFEFEF6A), // Pale yellow
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: Colors.black, width: 2),
          // Added a small shadow to make it look "clickable"
          boxShadow: const [
             BoxShadow(
              color: Colors.black,
              offset: Offset(2, 2),
              blurRadius: 0,
            ),
          ]
        ),
        child: Row(
          children: [
            // Circle Avatar placeholder
            Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.black, width: 2),
                color: Colors.white,
              ),
            ),
            const SizedBox(width: 12),
            Text(
              name,
              style: const TextStyle(
                fontSize: 18, 
                fontWeight: FontWeight.bold,
                color: Colors.black
              ),
            ),
            const Spacer(), // Pushes arrow to the right
            const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.black),
          ],
        ),
      ),
    );
  }
}