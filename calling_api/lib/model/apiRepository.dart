import 'dart:convert';

import 'package:calling_api/model/user_model.dart';
import 'package:http/http.dart';

class ApiRepository  {
  String endPoint = "https://reqres.in/api/users?page=2";

  Future<List<Usermodel>> getCallApi() async{
    Response response = await get(Uri.parse(endPoint));

    if (response.statusCode == 200) {
      final List result = jsonDecode(response.body)['data'];
      return result.map((e) => Usermodel.fromJson(e)).toList();
    } else {
      throw Exception(response.reasonPhrase);
    }
  }
}