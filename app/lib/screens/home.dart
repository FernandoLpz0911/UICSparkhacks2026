import 'package:app/widgets/navigate.dart';
import 'package:flutter/material.dart';
import 'package:app/screens/lobby.dart';

class Home extends StatefulWidget {
	final String title;

	const Home({Key? key, required this.title}) : super(key: key);

	@override
	_HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: AppBar(title: Text(widget.title)),
			body: Center(
				child: NavigateButton(
					label: "Lobby",
					destination: Lobby(title: "Lobby"),
				),
			),
		);
	}
}

