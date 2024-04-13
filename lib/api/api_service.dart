

import 'dart:convert';

import '../models/movie.dart';
import 'api_constants.dart';
import 'package:http/http.dart' as http;


class APIService {

  static Future<List<Movie>> getPopularMovies() async {
    try {
      final uri = Uri.https(
        APIConstants.baseUrl,
        APIConstants.popularEndpoint,
        {
          "language": "en-US",
          "page": "1"
        }
      );
      final response = await http.get(uri, headers: {"Authorization": "Bearer ${APIConstants.accessToken}"});
      final json = jsonDecode(response.body);
      return [for(var o in json["results"]) Movie.fromJson(o)];
    } catch (error) {
      print(error);
      rethrow;
    }
  }

}