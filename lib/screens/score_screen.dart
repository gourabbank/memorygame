import 'package:flutter/material.dart';
import 'game_screen.dart';

class ScoreScreen extends StatelessWidget {
  final int clicks;

  ScoreScreen({required this.clicks});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Game Over")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Game Over!", style: TextStyle(fontSize: 24)),
            Text("Total Clicks: $clicks", style: TextStyle(fontSize: 20)),
            ElevatedButton(
              onPressed: () => Navigator.popUntil(context, (route) => route.isFirst),
              child: Text("Back to Home"),
            ),
          ],
        ),
      ),
    );
  }
}