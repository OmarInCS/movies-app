

import 'dart:convert';
import 'dart:typed_data';

import '../models/genre.dart';
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

  static Future<Uint8List> getBackdropImage(String imagePath) async {
    try {
      final uri = Uri.https(
          APIConstants.mediaBaseUrl,
          APIConstants.backdropEndpoint + imagePath
      );
      final response = await http.get(uri, headers: {"Authorization": "Bearer ${APIConstants.accessToken}"});

      return response.bodyBytes;
    } catch (error) {
      print(error);
      rethrow;
    }
  }

  static Future<Uint8List> getPosterImage(String imagePath) async {
    try {
      final uri = Uri.https(
          APIConstants.mediaBaseUrl,
          APIConstants.posterEndpoint + imagePath
      );
      final response = await http.get(uri, headers: {"Authorization": "Bearer ${APIConstants.accessToken}"});

      return response.bodyBytes;
    } catch (error) {
      print(error);
      rethrow;
    }
  }

  static Future<List<Movie>> getUpcomingMovies() async {
    try {
      final uri = Uri.https(
          APIConstants.baseUrl,
          APIConstants.upcomingEndpoint,
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

  static Future<List<Movie>> getTopRatedMovies() async {
    try {
      final uri = Uri.https(
          APIConstants.baseUrl,
          APIConstants.topRatedEndpoint,
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

  static Future<Movie> getMovieDetails(int movieId) async {
    try {
      final uri = Uri.https(
          APIConstants.baseUrl,
          APIConstants.movieDetailsEndpoint.replaceAll("{movie_id}", movieId.toString()),
          {
            "language": "en-US",
          }
      );
      final response = await http.get(uri, headers: {"Authorization": "Bearer ${APIConstants.accessToken}"});
      final json = jsonDecode(response.body);
      return Movie.fromJson(json);
    } catch (error) {
      print(error);
      rethrow;
    }
  }

  static Future<List<Movie>> getSimilarMovies(int movieId) async {
    try {
      final uri = Uri.https(
          APIConstants.baseUrl,
          APIConstants.similarEndpoint.replaceAll("{movie_id}", movieId.toString()),
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


  static Future<List<Movie>> getSearchedMovies(String query) async {
    try {
      final uri = Uri.https(
          APIConstants.baseUrl,
          APIConstants.searchEndpoint,
          {
            "language": "en-US",
            "page": "1",
            "query": query
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

  static Future<List<Genre>> getGenres() async {
    try {
      final uri = Uri.https(
          APIConstants.baseUrl,
          APIConstants.genresEndpoint,
          {
            "language": "en-US",
          }
      );
      final response = await http.get(uri, headers: {"Authorization": "Bearer ${APIConstants.accessToken}"});
      final json = jsonDecode(response.body);
      return [for(var o in json["genres"]) Genre.fromJson(o)];
    } catch (error) {
      print(error);
      rethrow;
    }
  }

  static Future<List<Movie>> getMoviesOfGenre(int genreId) async {
    try {
      final uri = Uri.https(
          APIConstants.baseUrl,
          APIConstants.discoverEndpoint,
          {
            "language": "en-US",
            "page": "1",
            "with_genres": "$genreId"
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