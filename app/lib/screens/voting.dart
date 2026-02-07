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
body: Column(
  children: [
    const SizedBox(height:30),

    Center(
      child:Container(
        width: 300,
        padding: const EdgeInsets.symmetric(vertical:20),
        decoration: BoxDecoration(
          color: Colors.yellow,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.black,width: 3),
          boxShadow: const[
            BoxShadow(
              color: Colors.black,
              offset: Offset(5,3),
              blurRadius: 0,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const[
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
              size:40,
              color: Colors.black
            ),
          ],
        ),
      ),
    ),
  ],
)
);
  }
}