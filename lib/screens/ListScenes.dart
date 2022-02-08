import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'AddDataScene.dart';

class ListScenes extends StatefulWidget {
  @override
  _ListScenesState createState() => _ListScenesState();
}

class _ListScenesState extends State<ListScenes> {
  List? data;

  Future<List?> getData() async {
    //encode Map to JSON

    var dio = Dio();

    var response = await dio.get('http://10.0.2.2:9087/getallscene');

    return response.data;
  }

  _navigateAndDisplaySelection(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddDataScene()),
    );

    if (result) {
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    this.getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text("Listviews Scenes"),
        automaticallyImplyLeading: false, //evita que muestre flecha de regresar
        actions: [
          RaisedButton(
            color: Colors.black12,
            child: Icon(Icons.add),
            onPressed: () => _navigateAndDisplaySelection(context),
          ),
        ],
      ),
      body: new FutureBuilder<List?>(
        future: getData(),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);
          return snapshot.hasData
              ? new ItemList(
                  list: snapshot.data,
                )
              : new Center(
                  child: new CircularProgressIndicator(),
                );
        },
      ),
    );
  }
}

class ItemList extends StatelessWidget {
  final List? list;
  ItemList({this.list});

  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
      itemCount: list! == null ? 0 : list!.length,
      itemBuilder: (context, i) {
        String base64string = list![i]['image'];
        Uint8List decodedbytes = base64.decode(base64string);
        return Card(
          child: ListTile(
            title: Text(list![i]['titre'].toString()),
            subtitle: Text(list![i]['description'].toString()),
            leading: Image.memory(
              decodedbytes,
              fit: BoxFit.cover,
            ),
            trailing: Icon(Icons.arrow_forward_rounded),
          ),
        );
        /* return Column(
          children: [
            new Container(
              padding: const EdgeInsets.all(10.0),
              child: new GestureDetector(
                /*  onTap: () => Navigator.of(context).push(
                 
                );*/
                child: Container(
                  //color: Colors.black,
                  height: 100.3,
                  child: new Card(
                    color: Colors
                        .primaries[Random().nextInt(Colors.primaries.length)],
                    child: Column(
                      mainAxisSize: MainAxisSize.min, // add this
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            children: [
                              Container(
                                child: Text(
                                  list![i]['titre'].toString(),
                                  style: TextStyle(
                                      fontSize: 20.0, color: Colors.black87),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            children: [
                              Container(
                                child: Text(
                                  list![i]['description'].toString(),
                                  style: TextStyle(
                                      fontSize: 20.0, color: Colors.black87),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        );*/
      },
    );
  }
}
