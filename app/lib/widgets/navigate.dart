import 'package:flutter/material.dart';

/// wrapper navigation button for routing
class NavigateButton extends StatelessWidget {
  final String label;
  final Widget destination; /// actual page destination

  /// default constructor for the navigate button
  const NavigateButton({
    super.key, 
    required this.label, 
    required this.destination,
  });

  /// the widget details
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: Text(label),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => destination),
        );
      },
    );
  }
}