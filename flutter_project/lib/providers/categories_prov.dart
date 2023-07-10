import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../const_values.dart';
import '../moudels/catigores_image.dart';

class CategoryProv extends ChangeNotifier {
  List<CategoriesModel> listCategoriesModel = [];
  List<CategoriesModel> listCategoriesModelAdmin = [];

  getCategories() async {
    final response = await http.get(
      Uri.parse("${ConsValues.BASEURL}getCategories.php"),
    );
    if (response.statusCode == 200) {
      var jsonBody = jsonDecode(response.body);
      var categories = jsonBody['Categories'];
      for (Map i in categories) {
        listCategoriesModel.add(CategoriesModel.fromJson(i));
      }
      notifyListeners();
    }
  }

  getCategoriesAdmin() async {
    listCategoriesModelAdmin = [];
    final response = await http.get(
      Uri.parse("${ConsValues.BASEURL}getCategoriesAdmin.php"),
    );
    if (response.statusCode == 200) {
      var jsonBody = jsonDecode(response.body);
      var categories = jsonBody['Categories'];
      for (Map i in categories) {
        listCategoriesModelAdmin.add(CategoriesModel.fromJson(i));
      }
      notifyListeners();
    }
  }

  Future addNewCategories({
    required File image,
    required String name,
    required String Id_statustypes,
  }) async {
    var request = http.MultipartRequest(
        "POST", Uri.parse("${ConsValues.BASEURL}addNewCategory.php"));
    var pic = await http.MultipartFile.fromPath("fileToUpload", image.path);
    request.fields['Name'] = name;
    request.fields['Id_statustypes'] = Id_statustypes;
    request.files.add(pic);
    var response = await request.send();
    var responseData = await response.stream.toBytes();
    var responseString = String.fromCharCodes(responseData);
    var jsonBody = jsonDecode(responseString);
    var data = jsonBody['data'];
    listCategoriesModelAdmin.add(CategoriesModel.fromJson(data));
    notifyListeners();
  }
}
