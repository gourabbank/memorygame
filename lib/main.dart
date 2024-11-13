import 'package:flutter/material.dart';
import 'package:memorygame/screens/game_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Memory Game',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: DifficultySelectionScreen(),
    );
  }
}

class DifficultySelectionScreen extends StatelessWidget {
  void _startGame(BuildContext context, int gridSize) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => GameScreen(gridSize: gridSize),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Alberto")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => _startGame(context, 2), // Easy (2x2 grid)
              child: Text("Easy"),
            ),
            ElevatedButton(
              onPressed: () => _startGame(context, 4), // Medium (4x4 grid)
              child: Text("Medium"),
            ),
            ElevatedButton(
              onPressed: () => _startGame(context, 6), // Hard (6x6 grid)
              child: Text("Difficult"),
            ),
          ],
        ),
      ),
    );
  }
}