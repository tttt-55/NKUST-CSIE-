import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const SelfIntroductionPage(),
    );
  }
}

class SelfIntroductionPage extends StatefulWidget {
  const SelfIntroductionPage({super.key});

  @override
  State<SelfIntroductionPage> createState() => _SelfIntroductionPageState();
}

class _SelfIntroductionPageState extends State<SelfIntroductionPage> {
  // 照片和文字的數據
  final List<Map<String, dynamic>> _content = [
    {
      'image': 'https://drive.google.com/uc?export=view&id=16OifO2SwMi4AmOzPcKC0sTYADO5IXcon',
      'text': '我是 **小夜**，一個 **水瓶座男孩**，總是追逐著屬於自己的世界。\n'
          '孤獨的我，喜歡 **騎車看風景**，那些 **日落與山巒**，似乎才是對我的回應。\n'
          '或許，我是一個不被人注意的 **旅人**，但每一次孤獨的旅途，總讓我找到屬於自己的溫暖。',
      'alignment': Alignment.centerLeft, // 調整人物偏左對齊
    },
    {
      'image': 'https://drive.google.com/uc?export=view&id=1y7ntmOx_II3oVPzgQl64--y-kpVm9dCD',
      'text': '我是 **街拍攝影師**，總是用鏡頭捕捉 **城市角落的故事**。\n'
          '在這些光影交錯的瞬間，我找到了和這個世界對話的方式。\n'
          '但孤獨，總是如影隨形。也許，只有 **快門按下的那刻**，我才感覺被世界擁抱。',
      'alignment': Alignment.center, // 預設居中
    },
    {
      'image': 'https://drive.google.com/uc?export=view&id=19jd0RHf0Rk0je_GwDROVZDWS3Q8GWX1V',
      'text': '寂寞的時候，我會望著自己的作品。\n'
          '每一張照片，都是我與這個世界的獨白。\n'
          '**孤單** 並不可怕，可怕的是 **找不到自己的歸屬**。\n'
          '幸好，我有相機，它讓我能將孤獨變成永恆的記錄。',
      'alignment': Alignment.center, // 預設居中
    },
    {
      'image': 'https://drive.google.com/uc?export=view&id=1U599GCprH0d5_VGcZ6Rlmd9WntO0fFF3',
      'text': '我的生活不止於拍照，還有 **打工**。\n'
          '日復一日，我將時間耗在工作中，朋友的邀約，也變成了無聲的沉默。\n'
          '**忙碌的現實** 讓我與世界越走越遠，但我知道，\n'
          '**相機**，將永遠是我心靈的歸宿，\n'
          '**風景**，將永遠是我孤單的夥伴。',
      'alignment': Alignment.center, // 預設居中
    },
  ];

  int _currentIndex = 0; // 當前內容的索引

  // 方法：切換內容
  void _nextContent() {
    setState(() {
      _currentIndex = (_currentIndex + 1) % _content.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // 背景顏色
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 圖片部分
            Container(
              padding: const EdgeInsets.all(10), // 裱框間距
              decoration: BoxDecoration(
                color: Colors.grey[300], // 裱框顏色
                borderRadius: BorderRadius.circular(15), // 圓角
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10), // 圖片圓角
                child: Image.network(
                  _content[_currentIndex]['image'], // 動態圖片
                  width: 300, // 圖片寬度
                  height: 400, // 圖片高度
                  fit: BoxFit.cover, // 圖片填充
                  alignment: _content[_currentIndex]['alignment'], // 動態調整圖片對齊方式
                ),
              ),
            ),
            const SizedBox(height: 20), // 與文字的間距
            // 自我介紹文字部分
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: _content[_currentIndex]['text'],
                      style: const TextStyle(
                        fontSize: 18, // 字體大小
                        fontWeight: FontWeight.normal, // 標準字體
                        color: Colors.black87, // 字體顏色
                      ),
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 30), // 與按鈕的間距
            // 按鈕部分
            ElevatedButton(
              onPressed: _nextContent,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                textStyle: const TextStyle(fontSize: 18),
              ),
              child: const Text('下一頁'),
            ),
          ],
        ),
      ),
    );
  }
}
