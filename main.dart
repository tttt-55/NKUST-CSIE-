import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '敲木魚遊戲',
      home: const CounterGame(),
    );
  }
}

class CounterGame extends StatefulWidget {
  const CounterGame({super.key});

  @override
  State<CounterGame> createState() => _CounterGameState();
}

class _CounterGameState extends State<CounterGame> {
  int _score = 0;
  int _timeLeft = 30;
  bool _isPlaying = false;
  Timer? _timer;
  double _scale = 1.0;
  bool _showPunish = false;
  final Random _random = Random();

  void _startGame() {
    setState(() {
      _score = 0;
      _timeLeft = 30;
      _isPlaying = true;
      _showPunish = false;
    });

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_timeLeft > 0) {
        setState(() {
          _timeLeft--;
        });
      } else {
        _endGame();
      }
    });
  }

  void _endGame() {
    _timer?.cancel();
    setState(() {
      _isPlaying = false;
    });
    _showGameOverDialog();
  }

  void _showGameOverDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('遊戲結束'),
          content: Text('你的分數是：$_score'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('確定'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _handleTap() async {
    if (_isPlaying) {
      setState(() {
        if (_showPunish) {
          _score = (_score >= 2) ? _score - 2 : 0;
        } else {
          _score++;
        }
        _scale = 1.2;
      });

      await Future.delayed(const Duration(milliseconds: 200));
      setState(() {
        _scale = 1.0;
        _showPunish = _random.nextDouble() < 0.15; // 15% 機率出現懲罰圖
      });
    }
  }

  void _skipPunishImage() {
    if (_isPlaying && _showPunish) {
      setState(() {
        _showPunish = false; // 換成正常圖
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('敲木魚遊戲'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '剩餘時間：$_timeLeft 秒',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Text(
              '分數：$_score',
              style: const TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 40),
            GestureDetector(
              onTap: _handleTap,
              child: AnimatedScale(
                scale: _scale,
                duration: const Duration(milliseconds: 200),
                child: Image.asset(
                  _showPunish ? 'assets/p2.png' : 'assets/p1.png',
                  width: 150,
                  height: 150,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 20),
            if (_showPunish)
              ElevatedButton(
                onPressed: _skipPunishImage,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                ),
                child: const Text('跳過貪念'),
              ),
            const SizedBox(height: 40),
            if (!_isPlaying)
              ElevatedButton(
                onPressed: _startGame,
                child: const Text('開始遊戲'),
              ),
          ],
        ),
      ),
    );
  }
}
