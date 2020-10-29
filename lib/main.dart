import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Counter(title: 'Counter 1'),
            Counter(title: 'Counter 2'),
          ],
        ),
      ),
    );
  }
}

class CounterDisplay extends StatelessWidget {
  CounterDisplay({Key key, this.count}) : super(key: key);

  final int count;

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Count: $count',
            style: Theme.of(context).textTheme.bodyText2,
          ),
        ]);
  }
}

class CounterIncrementor extends StatelessWidget {
  CounterIncrementor({Key key, this.onPressed}) : super(key: key);

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: onPressed, child: Icon(Icons.add));
  }
}

class Counter extends StatefulWidget {
  Counter({Key key, this.title}) : super(key: key);

  final String title;

  @override
  State<StatefulWidget> createState() => _CounterState();
}

class _CounterState extends State<Counter> {
  int _counter = 0;

  void _increment() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          '${widget.title}',
          style: Theme.of(context).textTheme.bodyText1,
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            CounterIncrementor(onPressed: _increment),
            SizedBox(
              width: 8.0,
            ),
            CounterDisplay(count: _counter),
          ],
        ),
      ],
    );
  }
}
