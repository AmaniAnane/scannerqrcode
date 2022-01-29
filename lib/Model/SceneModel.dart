import 'dart:convert';

SceneModel sceneModelJson(String str) => SceneModel.formJson(jsonDecode(str));
String sceneModelToJson(SceneModel data) => jsonEncode(data.toJson());

class SceneModel {
  int id;
  String titre;
  String description;
  String image;
  SceneModel(
      {required this.id,
      required this.description,
      required this.titre,
      required this.image});
  factory SceneModel.formJson(Map<String, dynamic> json) => SceneModel(
      id: json["id"],
      titre: json["titre"],
      description: json["description"],
      image: json["image"]);
  Map<String, dynamic> toJson() => {
        'id': id,
        "titre": titre,
        "description": description,
        "image": image,
      };
  String get gettitre => titre;

  String get getdescription => description;
  String get getimage => image;
}
