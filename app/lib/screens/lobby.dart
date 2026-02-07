import 'package:app/widgets/navigate.dart';
import 'package:flutter/material.dart';
import 'package:app/screens/home.dart';

class Lobby extends StatefulWidget {
  final String title;

  /// create a homepage instance that refreshes
  const Lobby({super.key, required this.title});

  /// create the private home type and return a private home ui page
  @override
  _Lobby createState() => _Lobby();
}

/// class for the private lobby instance that refreshes 
class _Lobby extends State<Lobby> {

  /// actual ui of the lobby page
 @override
Widget build(BuildContext context) {
  return Container(
    width: 200,
    height: 200,
    decoration: BoxDecoration(
      color: Colors.orange,
      shape: BoxShape.circle,
      border: Border.all(
        color: Colors.black,
        width: 2,
      ),
    ),
  );
}
}