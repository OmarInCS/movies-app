
/* 
// Example Usage
Map<String, dynamic> map = jsonDecode(<myJSONString>);
var myMovieNode = Movie.fromJson(map);
*/
import 'dart:typed_data';

class Movie {
  bool adult;
  String? backdropPath;
  List<int> genreids;
  int id;
  String originallanguage;
  String originaltitle;
  String overview;
  double popularity;
  String? posterPath;
  String releasedate;
  String title;
  bool video;
  double voteaverage;
  int votecount;

  Uint8List? backdrop;
  Uint8List? poster;
  List<String>? genres;

  Movie({required this.adult, required this.backdropPath, required this.genreids, required this.id, required this.originallanguage, required this.originaltitle, required this.overview, required this.popularity, required this.posterPath, required this.releasedate, required this.title, required this.video, required this.voteaverage, required this.votecount, this.genres});

  factory Movie.fromJson(Map<String, dynamic> json) {
    var genreids = <int>[];
    List<String>? genres;
    if(json['genre_ids'] != null) {
      json['genre_ids'].forEach((v) {
        genreids.add(v);
      });
    }
    else {
      genres = [];
      json['genres'].forEach((v) {
        genreids.add(v["id"]);
        genres!.add(v["name"]);
      });
    }

    return Movie(
      adult : json['adult'],
      backdropPath : json['backdrop_path'],
      genreids: genreids,
      genres: genres,
      id : json['id'],
      originallanguage : json['original_language'],
      originaltitle : json['original_title'],
      overview : json['overview'],
      popularity : json['popularity'],
      posterPath : json['poster_path'],
      releasedate : json['release_date'],
      title : json['title'],
      video : json['video'],
      voteaverage : json['vote_average'],
      votecount : json['vote_count'],
    );
  }

  Map<String, dynamic> toJson() {
    final data = Map<String, dynamic>();
    data['adult'] = adult;
    data['backdrop_path'] = backdropPath;
    data['genre_ids'] = genreids;
    data['id'] = id;
    data['original_language'] = originallanguage;
    data['original_title'] = originaltitle;
    data['overview'] = overview;
    data['popularity'] = popularity;
    data['poster_path'] = posterPath;
    data['release_date'] = releasedate;
    data['title'] = title;
    data['video'] = video;
    data['vote_average'] = voteaverage;
    data['vote_count'] = votecount;
    return data;
  }
}

