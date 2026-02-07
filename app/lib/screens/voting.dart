import 'package:flutter/material.dart';
void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: VotePage(),
  ));
}

class VotePage extends StatelessWidget {
  const VotePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 253, 247, 247),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 253, 247, 247),
        elevation: 0.0,
        centerTitle: true,
        actions: [
          GestureDetector(
            onTap: (){
              print("Chat clicked");
            },
            child: Container( 
            margin: const EdgeInsets.only(right: 10,top:5,bottom: 4),
            padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 5),
            decoration: BoxDecoration(
              color: Colors.deepOrange,
              borderRadius: BorderRadius.circular(40),
              border: Border.all(color: Colors.black,width:2),
            ),
child: Row(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Icon(
                    Icons.chat_bubble, 
                    size: 18, 
                    color: Colors.black
                  ),
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
        // ------------------------
      ),
    );
  }
}