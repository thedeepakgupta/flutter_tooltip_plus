import 'package:flutter/material.dart';
import 'package:flutter_tooltip_plus/flutter_tooltip_plus.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Tooltip Demo',
      theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple)),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FlutterTooltip(
              background: Colors.amber,
              borderRadius: BorderRadius.circular(12),
              padding: EdgeInsets.all(12),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Tool tip content",
                    style: TextStyle(color: Colors.black),
                  ),
                ],
              ),
              child: Icon(Icons.info_outline_rounded),
            ),
          ],
        ),
      ),
    );
  }
}
