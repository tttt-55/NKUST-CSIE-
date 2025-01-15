import 'package:flutter/material.dart';
import 'dart:async';

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
  int _score = 0; // 玩家得分
  int _timeLeft = 30; // 倒數計時（秒）
  bool _isPlaying = false; // 遊戲是否正在進行
  Timer? _timer; // 計時器
  double _scale = 1.0; // 圖片的縮放比例

  void _startGame() {
    setState(() {
      _score = 0;
      _timeLeft = 30;
      _isPlaying = true;
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

  Future<void> _incrementScore() async {
    if (_isPlaying) {
      setState(() {
        _score++;
        _scale = 1.2; // 放大圖片
      });

      // 等待 0.2 秒後恢復原大小
      await Future.delayed(const Duration(milliseconds: 200));
      setState(() {
        _scale = 1.0; // 恢復原大小
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
            // 使用 AnimatedScale 包裹圖片，實現縮放動畫
            GestureDetector(
              onTap: _incrementScore,
              child: AnimatedScale(
                scale: _scale,
                duration: const Duration(milliseconds: 200),
                child: Image.network(
                  'https://drive.google.com/uc?export=view&id=1R4_DxNn822B7KMFCQQNeFluoosdlXRHB',
                  width: 150,
                  height: 150,
                  fit: BoxFit.cover,
                ),
              ),
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

