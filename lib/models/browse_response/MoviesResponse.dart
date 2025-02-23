// ignore_for_file: file_names

class MoviesResponse {
  List<Genres>? genres;

  MoviesResponse({this.genres});

  MoviesResponse.fromJson(Map<String, dynamic> json) {
    if (json['genres'] != null && json['genres'].length > 0) {
      genres = <Genres>[];
      json['genres'].forEach((v) {
        genres!.add(Genres.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (genres != null) {
      data['genres'] = genres!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Genres {
  int? id;
  String? name;
  String? backdropPath;

  Genres({this.id, this.name, this.backdropPath});

  Genres.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    backdropPath = json['backdrop_path'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['backdrop_path'] = backdropPath;
    return data;
  }
}

