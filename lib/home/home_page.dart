import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image.network(
            'https://m.yodycdn.com/blog/hinh-nen-thien-nhien-4k-yody-vn-51.jpg',
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Oceschinen Lake Campground',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    Text(
                      'Kandersteg, Switzerland',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 50),
                Row(
                  children: const [
                    Icon(Icons.star, size: 40, color: Colors.orange),
                  ],
                ),
                Column(
                  children: const [
                    Text(
                      '41',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: const [
              Column(
                children: [
                  Row(
                    children: [Icon(Icons.phone, size: 30, color: Colors.blue)],
                  ),
                  SizedBox(height: 10),
                  Text('CALL', style: TextStyle(fontSize: 16)),
                ],
              ),
              Column(
                children: [
                  Row(
                    children: [
                      Icon(Icons.near_me, size: 30, color: Colors.blue),
                    ],
                  ),
                  SizedBox(height: 10),
                  Text('ROUTE', style: TextStyle(fontSize: 16)),
                ],
              ),
              Column(
                children: [
                  Row(
                    children: [Icon(Icons.share, size: 30, color: Colors.blue)],
                  ),
                  SizedBox(height: 10),
                  Text('SHARE', style: TextStyle(fontSize: 16)),
                ],
              ),
            ],
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'The natural world offers a sanctuary from the bustle of everyday life, enveloping us in breathtaking landscapes and tranquil sounds. Imagine verdant forests, where sunlight filters through the leaves, and the air is alive with the chirping of birds. Towering mountains stand as silent guardians, their peaks touching the clouds, while crystal-clear rivers flow through valleys, their gentle murmurs a soothing melody. This serene beauty provides a much-needed escape, inviting us to connect with the earth and find peace in its timeless embrace.',
              style: TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
