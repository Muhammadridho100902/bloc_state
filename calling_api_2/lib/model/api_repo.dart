import 'dart:convert';
import 'dart:math';

import 'package:calling_api_2/model/user_model.dart';
import 'package:http/http.dart';

class ApiRepository {
  final String mainApi = "https://reqres.in/api/users?page=2";

  Future<List<Usermodel>> getAllData() async{
    Response response = await get(Uri.parse(mainApi));

    if (response.statusCode == 200) {
      final List result = jsonDecode(response.body)['data'];
      return result.map((e) => Usermodel.fromJson(e)).toList();
    } else {
      throw Exception(response.reasonPhrase);
    }
  }
}