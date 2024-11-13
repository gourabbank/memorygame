import 'dart:async';
import 'package:flutter/material.dart';
import 'score_screen.dart';

class GameScreen extends StatefulWidget {
  final int gridSize;
  GameScreen({required this.gridSize});

  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  late List<String> _cards;
  late List<bool> _cardRevealed;
  int _clicks = 0;
  int? _firstCardIndex;
  bool _isChecking = false;

  @override
  void initState() {
    super.initState();
    _initializeGame();
  }

  void _initializeGame() {
    _cards = List.generate(widget.gridSize * widget.gridSize ~/ 2, (index) => 'Card $index')
        .expand((e) => [e, e]).toList()
      ..shuffle();
    _cardRevealed = List.filled(_cards.length, false);
    _clicks = 0;
  }

  void _onCardTap(int index) {
    if (_isChecking || _cardRevealed[index]) return;

    setState(() {
      _cardRevealed[index] = true;
      _clicks++;
    });

    if (_firstCardIndex == null) {
      _firstCardIndex = index;
    } else {
      _isChecking = true;
      if (_cards[_firstCardIndex!] == _cards[index]) {
        // Matched
        _firstCardIndex = null;
        _isChecking = false;
        if (_cardRevealed.every((revealed) => revealed)) {
          _endGame();
        }
      } else {
        // Not Matched
        Timer(Duration(seconds: 1), () {
          setState(() {
            _cardRevealed[_firstCardIndex!] = false;
            _cardRevealed[index] = false;
          });
          _firstCardIndex = null;
          _isChecking = false;
        });
      }
    }
  }

  void _endGame() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ScoreScreen(clicks: _clicks),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Memory Game")),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: widget.gridSize,
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
        ),
        padding: const EdgeInsets.all(16.0),
        itemCount: _cards.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => _onCardTap(index),
            child: Container(
              color: Colors.blue,
              child: Center(
                child: Text(
                  _cardRevealed[index] ? _cards[index] : "",
                  style: TextStyle(fontSize: 24, color: Colors.white),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}