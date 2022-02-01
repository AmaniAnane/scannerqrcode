import 'package:flutter/material.dart';
import 'package:scannerqrcode/screens/AddDataScene.dart';

import 'package:scannerqrcode/screens/scanqr.dart';
import 'package:dio/dio.dart';

Future<void> main() async {
  runApp(const MyApp());
  var dio = Dio();
  final response = await dio.get('http://10.0.2.2:9087/getalluser');
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Scanner app',
      theme: ThemeData(
        primarySwatch: Colors.brown,
      ),
      home: const MyHomePage(title: 'Scanner app'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  final minimumPadding = 5.0;
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
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (ctx) => CreateScreen()));
                },
                child: Text('create QR CODE')),
            ElevatedButton(
                onPressed: () {
                  print('read QR CODE');
                },
                child: Text('read QR CODE'))
          ],
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.only(top: minimumPadding, bottom: minimumPadding),
          children: <Widget>[
            DrawerHeader(
              child: Text('Scenes configuration'),
              decoration: BoxDecoration(
                color: Colors.brown,
              ),
            ),
            ListTile(
              title: Text('Register des Scenes'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AddDataScene()));
              },
            ),
            ListTile(
              title: Text('Get Scenes'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AddDataScene()));
              },
            )
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
