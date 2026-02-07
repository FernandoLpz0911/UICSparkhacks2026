import 'package:app/widgets/navigate.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  final String title;

  /// create a homepage instance that refreshes
  const Home({Key? key, required this.title}) : super(key: key);

  /// create the private home type and return a private home ui page
  @override
  _Home createState() => _Home();
}

/// class for the private home instance that refreshes 
class _Home extends State<Home> {

  /// actual ui of the home page
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:const Text("HOME PAGE")),
      body: Center(
        child: NavigateButton(label: "Lobby", destination: Home(title: "Home",)
        ),
      )
    );
  }

}