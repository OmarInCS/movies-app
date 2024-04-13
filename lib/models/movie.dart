
/* 
// Example Usage
Map<String, dynamic> map = jsonDecode(<myJSONString>);
var myMovieNode = Movie.fromJson(map);
*/
class Movie {
  bool adult;
  String backdroppath;
  List<int> genreids;
  int id;
  String originallanguage;
  String originaltitle;
  String overview;
  double popularity;
  String posterpath;
  String releasedate;
  String title;
  bool video;
  double voteaverage;
  int votecount;

  Movie({required this.adult, required this.backdroppath, required this.genreids, required this.id, required this.originallanguage, required this.originaltitle, required this.overview, required this.popularity, required this.posterpath, required this.releasedate, required this.title, required this.video, required this.voteaverage, required this.votecount});

  factory Movie.fromJson(Map<String, dynamic> json) {
    var genreids = <int>[];
    json['genre_ids'].forEach((v) {
      genreids.add(v);
    });

    return Movie(
      adult : json['adult'],
      backdroppath : json['backdrop_path'],
      genreids: genreids,
      id : json['id'],
      originallanguage : json['original_language'],
      originaltitle : json['original_title'],
      overview : json['overview'],
      popularity : json['popularity'],
      posterpath : json['poster_path'],
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
    data['backdrop_path'] = backdroppath;
    data['genre_ids'] = genreids;
    data['id'] = id;
    data['original_language'] = originallanguage;
    data['original_title'] = originaltitle;
    data['overview'] = overview;
    data['popularity'] = popularity;
    data['poster_path'] = posterpath;
    data['release_date'] = releasedate;
    data['title'] = title;
    data['video'] = video;
    data['vote_average'] = voteaverage;
    data['vote_count'] = votecount;
    return data;
  }
}

