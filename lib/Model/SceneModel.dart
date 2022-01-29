import 'dart:convert';

SceneModel sceneModelJson(String str) => SceneModel.formJson(jsonDecode(str));
String sceneModelToJson(SceneModel data) => jsonEncode(data.toJson());

class SceneModel {
  int id;
  String titre;
  String description;
  String image;
  SceneModel({this.id, this.description, this.titre, this.image});
  factory SceneModel.formJson(Map<String, dynamic> json) => SceneModel(
      id: json["id"],
      titre: json["titre"],
      description: json["description"],
      image: json["image"]);
  Map<String, dynamic> toJson() => {
        'id': id,
        "titre": titre,
        "description": description,
      };
  String get gettitre => titre;

  String get getdescription => description;
}