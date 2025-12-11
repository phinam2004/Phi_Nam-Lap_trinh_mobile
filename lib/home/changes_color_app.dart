import 'dart:math';
import 'package:flutter/material.dart';

class ChangesColorApp extends StatefulWidget {
  const ChangesColorApp({super.key});

  @override
  State<ChangesColorApp> createState() => _ChangesColorAppState();
}

class _ChangesColorAppState extends State<ChangesColorApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Color Changer'),
          backgroundColor: Colors.green,
        ),
        body: _buildBody(),
      ),
    );
  }

  Color _bgcolor = Colors.pink;

  String bgcolorName = 'Hồng';

  List<Color> colors = [
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.yellow,
    Colors.orange,
    Colors.purple,
    Colors.pink,
    Colors.brown,
    Colors.cyan,
    Colors.lime,
  ];

  List<String> colorNames = [
    'Đỏ',
    'Xanh lá',
    'Xanh dương',
    'Vàng',
    'Da cam',
    'Tím',
    'Hồng',
    'Nâu',
    'Xanh da trời',
    'xanh non',
  ];

  void _changesColor() {
    var rand = Random();
    var i = rand.nextInt(colors.length);
    setState(() {
      _bgcolor = colors[i];
      bgcolorName = colorNames[i];
    });
  }

  Widget _buildBody() {
    return Container(
      decoration: BoxDecoration(
        color: _bgcolor,
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            bgcolorName,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          const Text(
            'Click button to change color',
            style: TextStyle(fontSize: 20),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: _changesColor,
                child: const Text('Change color'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
