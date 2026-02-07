import 'package:flutter/material.dart';
// There are the files required for the authentication to process and work in the app
import 'package:firebase_core/firebase_core.dart';
import 'package:app/firebase_options.dart';

void main() async {
  // Remove this after setting up authenticaton
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 173, 183, 58)),
      ),
      home: const TutorialPage(title: 'Flutter Demo Home Page'),
    );
  }
}


class TutorialPage extends StatefulWidget {
  const TutorialPage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<TutorialPage> createState() => _TutorialPageState();
}

class _TutorialPageState extends State<TutorialPage> {
  int _currentStep = 0;


  final List<String> tutorialTexts = [
  'Each player is given a secret genre.\n\nYou have 60 seconds to write one sentence that fits your genre.\n\nOne player is the Impostor.',
  'All sentences are combined into one story.\n\nAn AI arranges them to flow naturally.\n\nOne line will feel off.',
  'Read the story.\nDiscuss with your friends.\n\nVote for the line that does not belong.\n\nFind the Impostor.',
  ];

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the TutorialPage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          //
          // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
          // action in the IDE, or press "p" in the console), to see the
          // wireframe for each widget.
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              tutorialTexts[_currentStep],
              textAlign: TextAlign.center,
              style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(tutorialTexts.length, (index) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                  _currentStep = index;
                  });
                },
                child: Container( //Circular buttons for user to move through text
                  margin: const EdgeInsets.all(6),
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _currentStep == index ? Colors.black : Colors.grey,
                  ),
                ),
              );
            }),
            ),
            const SizedBox(height: 20),
            _currentStep < tutorialTexts.length - 1
              ? FloatingActionButton(
              onPressed: () {
              setState(() {
                _currentStep++;
              });
            },
            child: const Icon(Icons.arrow_forward), //forward button for user to move through text
          )
          : ElevatedButton(
            onPressed: () {
              //go to lobby/home
            },
            child: const Text('Play'),
          ),
          ],
        ),
      ),
    );
  }
}
