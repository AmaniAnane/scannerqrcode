import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

import '../controllers/databasehelpers.dart';

import 'package:image_picker/image_picker.dart';
import 'package:adaptive_dialog/adaptive_dialog.dart';

class AddDataScene extends StatefulWidget {
  AddDataScene({Key? key, this.titre}) : super(key: key);
  final String? titre;

  @override
  State<StatefulWidget> createState() => AddDataSceneState();
}

class AddDataSceneState extends State<AddDataScene> {
  DataBaseHelper databaseHelper = new DataBaseHelper();
  File? file;
  Future pickercamera() async {
    final myfile = await ImagePicker().pickImage(source: ImageSource.camera);
    setState(() {
      file = File(myfile!.path);
    });
  }

  Future upload() async {
    if (file == null) return;
    String base64 = base64Encode(file!.readAsBytesSync());
    String imagename = file!.path.split("/").last;
  }

  final TextEditingController titreController = new TextEditingController();
  final TextEditingController descriptionController =
      new TextEditingController();
  final TextEditingController imageController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Add Scenes',
      home: Scaffold(
        // appBar: AppBar(
        //   title: Text('Add Product'),
        // ),
        body: Container(
          child: ListView(
            padding: const EdgeInsets.only(
                top: 62, left: 12.0, right: 12.0, bottom: 12.0),
            children: <Widget>[
              Container(
                height: 50,
                child: new TextField(
                  controller: titreController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'titre',
                    hintText: 'Scene titre',
                  ),
                ),
              ),
              Container(
                height: 50,
                child: new TextField(
                  controller: descriptionController,
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                    labelText: 'desciption',
                    hintText: 'scene description',
                  ),
                ),
              ),
              new Padding(
                padding: new EdgeInsets.only(top: 44.0),
              ),
              Container(
                  height: 50,
                  child: RaisedButton(
                      child: Text('Importer image'), onPressed: pickercamera)),
              new Padding(
                padding: new EdgeInsets.only(top: 44.0),
              ),
              Container(
                height: 50,
                child: RaisedButton(
                  onPressed: () {
                    if (file == null) {
                      alert(context);
                    } else {
                      String base64 = base64Encode(file!.readAsBytesSync());

                      databaseHelper.addDataScene(titreController.text.trim(),
                          descriptionController.text.trim(), base64.trim());
                      Navigator.pop(context, true);
                    }
                  },
                  color: Colors.brown,
                  child: new Text(
                    'Add',
                    style: new TextStyle(
                        color: Colors.white, backgroundColor: Colors.blue),
                  ),
                ),
              ),
              Center(
                child: file == null
                    ? Text("no Image selected")
                    : Image.file(file!),
              )
            ],
          ),
        ),
      ),
    );
  }
}

void alert(BuildContext context) {
  var alertDialog = AlertDialog(
    title: Text('add image'),
    content: Text('merci dajouter un image'),
  );
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return alertDialog;
      });
}
