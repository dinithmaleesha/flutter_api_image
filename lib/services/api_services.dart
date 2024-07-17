import 'dart:convert';
import 'package:api_request/model/dog.dart';
import 'package:http/http.dart' as http;

class ApiServices {
  final String apiUrl = 'https://dog.ceo/api/breeds/image/random';

  Future<Dog> fetchDog() async {
    final response = await http.get(Uri.parse(apiUrl));

    if(response.statusCode == 200) {
      return Dog.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load album');
    }
  }

}