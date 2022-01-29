// ignore_for_file: deprecated_member_use

import 'dart:convert';

import 'package:flutter/material.dart';

import '../Model/SceneModel.dart';

import 'package:http/http.dart' as http;

class addScene extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return addSceneState();
  }
}

Future<SceneModel> addScenes( String titre, String description, String image,BuildContext context) 
async {
  var Url = "localhost:9087/addscene";
  var response = await http.post(Url,
      headers: <String, String>{"Content-type": "application/json"},
      body: jsonEncode(<String, String>{
        "titre": titre,
        "description": description,
        "image": image,
      }));
  String responseString = response.body;
  if (response.statusCode == 200) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext dialogContext) {
        return  MyAlertDialog(title: 'Backend Response', content: response.body);
      },
    );
  }
}

class MyAlertDialog extends StatelessWidget {
  final String title;
  final String content;
  final List<Widget> actions;

  MyAlertDialog({
    required this.title,
  required   this.content,
   this.actions = const [],
  });


  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        this.title,
        style: Theme.of(context).textTheme.titleLarge,
      ),
      actions: this.actions,
      content: Text(
        this.content,
        style: Theme.of(context).textTheme.bodyLarge,
      ),
    );
  }
}

}

class addSceneState extends State<addScene> {
  final minimumPadding = 5.0;
  TextEditingController titreontoller = TextEditingController();
  TextEditingController discContoller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    TextStyle? textStyle = Theme.of(context).textTheme.subtitle2;
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Scene"),
      ),
      body: Form(
        child: Padding(
          padding: EdgeInsets.all(minimumPadding * 2),
          child: ListView(
            children: <Widget>[
              Padding(
                  padding: EdgeInsets.only(
                      top: minimumPadding, bottom: minimumPadding),
                  child: TextFormField(
                    style: textStyle,
                    controller: titreontoller,
                    validator: (String? value) {
                      if (value != null && value.isEmpty) {
                        return 'enter le titre de Scene';
                      }
                    },
                    decoration: InputDecoration(
                        labelText: "Titre de Scene",
                        hintText: "entre le titre de Scene",
                        labelStyle: textStyle,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0))),
                  )),
              Padding(
                  padding: EdgeInsets.only(
                      top: minimumPadding, bottom: minimumPadding),
                  child: TextFormField(
                    style: textStyle,
                    controller: discContoller,
                    validator: (String? value) {
                      if (value != null && value.isEmpty) {
                        return 'enter le discreption de Scene';
                      }
                    },
                    decoration: InputDecoration(
                        labelText: "discreption de Scene",
                        hintText: "entre le discreption de Scene",
                        labelStyle: textStyle,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0))),
                  )),
              Padding(
                  padding: EdgeInsets.only(
                      top: minimumPadding, bottom: minimumPadding),
                  child: TextFormField(
                    style: textStyle,
                    controller: discContoller,
                    validator: (String? value) {
                      if (value != null && value.isEmpty) {
                        return 'selectionner limage de Scene';
                      }
                    },
                    decoration: InputDecoration(
                        labelText: "Image de Scene",
                        hintText: "entre le discreption de Scene",
                        labelStyle: textStyle,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0))),
                  )),
              RaisedButton(
                child: Text('Save'),
                onPressed: () {},
              )
            ],
          ),
        ),
      ),
    );
  }
}
