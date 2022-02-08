import 'dart:convert';
import 'dart:io';
import 'package:flutter/src/widgets/editable_text.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';

class DataBaseHelper {
  //Funcion para agregar un producto a la BD
  Future<Response> addDataScene(String titreController,
      String descriptionController, String imageController) async {
    var url = 'localhost:9087/addscene';

    Map data = {
      'titre': '$titreController',
      'description': '$descriptionController',
      'image': '$imageController',
    };
    //encode Map to JSON
    var body = json.encode(data);
    var dio = Dio();

    var response = await dio.post(
      'http://10.0.2.2:9087/addscene',
      options: Options(headers: {
        HttpHeaders.contentTypeHeader: "application/json",
      }),
      data: body,
    );

    print("${response.statusCode}");
    print("${response.data}");
    return response;
  }
  //affichage

  //function for update or put
  Future<http.Response> editarScene(String id, String titreController,
      String descriptionController, String imageController) async {
    int a = int.parse(id);
    print(a);
    var url = 'localhost:9087/updatescene';

    Map data = {
      'id': '$a',
      'name': '$titreController',
      'quantity': '$descriptionController',
      'price': '$imageController',
    };
    //encode Map to JSON
    var body = json.encode(data);

    var response = await http.put(Uri(path: url),
        headers: {"Content-Type": "application/json"}, body: body);
    print("${response.statusCode}");
    print("${response.body}");
    return response;
  }

  Future<http.Response> removeRegister(String id) async {
    int a = int.parse(id);
    print(a);
    var url = 'localhost:9087/removescene/$a';

    var response = await http
        .delete(Uri(path: url), headers: {"Content-Type": "application/json"});
    print("${response.statusCode}");
    return response;
  }

//
  Future<Response> singup(
      String emailController, String passwordController) async {
    var url = 'localhost:9087/register';

    Map data = {
      'email': '$emailController',
      'password': '$passwordController',
    };
    //encode Map to JSON
    var body = json.encode(data);
    var dio = Dio();

    var response = await dio.post(
      'http://10.0.2.2:9087/register',
      options: Options(headers: {
        HttpHeaders.contentTypeHeader: "application/json",
      }),
      data: body,
    );

    print("${response.statusCode}");
    print("${response.data}");
    return response;
  }
}
