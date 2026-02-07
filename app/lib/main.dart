import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'dart:math';
import 'services/firebase_firestore.dart';
import 'screens/lobby.dart';
import 'package:app/widgets/joinLobbyOverlay.dart';

import 'package:flutter/material.dart';
import 'package:app/services/firebase_firestore.dart';
import 'package:app/services/authentication.dart';
import 'package:app/screens/lobby.dart';

void showJoinLobbyOverlay(BuildContext context) {
  final TextEditingController codeController = TextEditingController();
  final FirestoreService _firestoreService = FirestoreService();
  final AuthService _authService = AuthService();

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text("Join a Lobby"),
        content: TextField(
          controller: codeController,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            hintText: "Enter 6-digit code",
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () async {
              int? lobbyCode = int.tryParse(codeController.text);
              var user = _authService.currentUser;

              if (lobbyCode != null && user != null) {
                // Add player to Firestore ServerLobby collection
                await _firestoreService.addPlayer(
                  lobbyCode: lobbyCode,
                  userId: user.uid.hashCode, // Using hash as int ID based on service signature
                  name: user.displayName ?? "Anonymous",
                );

                if (context.mounted) {
                  Navigator.pop(context); // Close overlay
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Lobby(lobbyCode: lobbyCode)
                    )
                  );
                }
              }
            },
            child: const Text("Join"),
          ),
        ],
      );
    },
  );
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SparkHacks 2026',
      theme: ThemeData(
        fontFamily: 'Winkle',
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
   HomePage({super.key});

  final FirestoreService _firestoreService = FirestoreService();

  Future<void> _handleMakeLobby(BuildContext context) async {
    
    /// generate random code using math Random function
    int randomCode = Random().nextInt(900000) + 100000;
    int mockHostId = 12345;
    String defaultGenre = "Horror";

    try {

      /// create the lobby
      await _firestoreService.createLobby(
        lobbyCode: randomCode,
        genre: defaultGenre,
        hostUserId: mockHostId,
      );

      // if we were able to make the lobby then we can go to the lobby screne
      if (context.mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Lobby(lobbyCode: randomCode),
          ),
        );
      }

      /// error handling
    } catch (e) {
      print("Error creating lobby: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 253, 247, 247),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 253, 247, 247),
        elevation: 0.0,
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/titlescreen.gif'), // Ensure this path is in pubspec.yaml
            const SizedBox(height: 20),
            
            // Star Container
            SizedBox(
              width: 350,
              height: 60,
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.star, size: 35, color: Colors.amber),
                  SizedBox(width: 2),
                  Icon(Icons.star, size: 35, color: Colors.amber),
                  SizedBox(width: 2),
                  Icon(Icons.star, size: 35, color: Colors.amber),
                ],
              ),
            ),

            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildMenuButton(
                  text: "Make a \nLobby",
                  color: const Color.fromARGB(255, 227, 196, 57),
                  onTap: () => _handleMakeLobby(context),
                ),
                
                _buildMenuButton(
                  text: "Join a\nLobby",
                  color: const Color.fromARGB(255, 216, 136, 40),
                  onTap: () => showJoinLobbyOverlay(context),
                ),
              ],
            ),

            const SizedBox(height: 30),

            // How to Play Button
            GestureDetector(
              onTap: () => print("How to play clicked"),
              child: Container(
                width: 350,
                height: 70,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.black, width: 3),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black,
                      offset: Offset(5, 3),
                    ),
                  ],
                ),
                child: const Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Row(
                    children: [
                      Text(
                        "How to play",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(width: 8),
                      Icon(Icons.local_fire_department, color: Colors.black, size: 24),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuButton({required String text, required Color color, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 150,
        height: 150,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(40),
          border: Border.all(color: Colors.black, width: 3),
          boxShadow: const [
            BoxShadow(
              color: Colors.black,
              offset: Offset(5, 3),
            ),
          ],
        ),
        child: Center(
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: GoogleFonts.permanentMarker(
              fontSize: 26,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}