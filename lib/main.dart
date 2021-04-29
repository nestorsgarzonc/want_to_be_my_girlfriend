import 'dart:math';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      theme: ThemeData.dark(),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final random = Random();
  double x;
  double y;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final size = MediaQuery.of(context).size;
    x = size.width * 0.4;
    y = size.height * 0.4;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: MouseRegion(
          onHover: onUpdatePosition,
          child: Stack(
            children: [
              Positioned(
                top: 50,
                width: size.width,
                child: Text(
                  '⭐ Do you want to be my girlfriend? ⭐',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
                ),
              ),
              AnimatedPositioned(
                left: x,
                top: y,
                height: 40,
                width: 80,
                child: ElevatedButton(
                  child: Text('NO'),
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(primary: Colors.blue[900]),
                ),
                duration: Duration(milliseconds: 250),
              ),
              Positioned(
                height: 40,
                width: 80,
                left: size.width * 0.6,
                top: size.height * 0.4,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Colors.blue[900]),
                  child: Text('YES'),
                  onPressed: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (ctx) => OhYeahScreen(),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void onUpdatePosition(PointerHoverEvent pos) {
    final size = MediaQuery.of(context).size;
    if (pos.position.dx > x - 40 &&
        pos.position.dx < x + 100 &&
        pos.position.dy > y - 40 &&
        pos.position.dy < y + 60) {
      print('rebuild Y');

      x = random.nextInt(size.width.toInt() - 80).toDouble().clamp(0, size.width);
      y = random.nextInt(size.height.toInt() - 80).toDouble().clamp(0, size.height);
      setState(() {});
    }
    print('dx: ${pos.position.dx}');
    print('dy: ${pos.position.dy}');
  }
}

class OhYeahScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BackButton(),
          SizedBox(width: double.infinity, height: 20),
          Image.network(
            'https://static.wikia.nocookie.net/memes-pedia/images/2/2c/89592b3392fee110134235e95d80dbf7.jpg/revision/latest?cb=20200527113030&path-prefix=es',
            height: size.height * 0.5,
          ),
          SizedBox(height: 30),
          Text('Oh Yeah!', style: TextStyle(fontSize: 30)),
        ],
      ),
    );
  }
}
