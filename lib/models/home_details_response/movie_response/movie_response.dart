class MovieResponseDetails {
  bool? adult;
  String? backdropPath;
  BelongsToCollection? belongsToCollection;
  int? budget;
  List<Genres>? genres;
  String? homepage;
  int? id;
  String? imdbId;
  List<String>? originCountry;
  String? originalLanguage;
  String? originalTitle;
  String? overview;
  double? popularity;
  String? posterPath;
  List<ProductionCompanies>? productionCompanies;
  List<ProductionCountries>? productionCountries;
  String? releaseDate;
  int? revenue;
  int? runtime;
  List<SpokenLanguages>? spokenLanguages;
  String? status;
  String? tagline;
  String? title;
  bool? video;
  double? voteAverage;
  int? voteCount;

  MovieResponseDetails(
      {this.adult,
      this.backdropPath,
      this.belongsToCollection,
      this.budget,
      this.genres,
      this.homepage,
      this.id,
      this.imdbId,
      this.originCountry,
      this.originalLanguage,
      this.originalTitle,
      this.overview,
      this.popularity,
      this.posterPath,
      this.productionCompanies,
      this.productionCountries,
      this.releaseDate,
      this.revenue,
      this.runtime,
      this.spokenLanguages,
      this.status,
      this.tagline,
      this.title,
      this.video,
      this.voteAverage,
      this.voteCount});

  MovieResponseDetails.fromJson(Map<String, dynamic> json) {
    adult = json['adult'];
    backdropPath = json['backdrop_path'];
    belongsToCollection = json['belongs_to_collection'] != null
        ? BelongsToCollection.fromJson(json['belongs_to_collection'])
        : null;
    budget = json['budget'];
    if (json['genres'] != null) {
      genres = <Genres>[];
      json['genres'].forEach((genre) {
        genres!.add(Genres.fromJson(genre));
      });
    }
    homepage = json['homepage'];
    id = json['id'];
    imdbId = json['imdb_id'];
    originCountry = json['origin_country']?.cast<String>();
    originalLanguage = json['original_language'];
    originalTitle = json['original_title'];
    overview = json['overview'];
    popularity = (json['popularity'] as num?)?.toDouble();
    posterPath = json['poster_path'];
    if (json['production_companies'] != null) {
      productionCompanies = <ProductionCompanies>[];
      json['production_companies'].forEach((company) {
        productionCompanies!.add(ProductionCompanies.fromJson(company));
      });
    }
    if (json['production_countries'] != null) {
      productionCountries = <ProductionCountries>[];
      json['production_countries'].forEach((country) {
        productionCountries!.add(ProductionCountries.fromJson(country));
      });
    }
    releaseDate = json['release_date'];
    revenue = json['revenue'];
    runtime = json['runtime'];
    if (json['spoken_languages'] != null) {
      spokenLanguages = <SpokenLanguages>[];
      json['spoken_languages'].forEach((language) {
        spokenLanguages!.add(SpokenLanguages.fromJson(language));
      });
    }
    status = json['status'];
    tagline = json['tagline'];
    title = json['title'];
    video = json['video'];
    voteAverage = (json['vote_average'] as num?)?.toDouble();
    voteCount = json['vote_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['adult'] = adult;
    data['backdrop_path'] = backdropPath;
    if (belongsToCollection != null) {
      data['belongs_to_collection'] = belongsToCollection!.toJson();
    }
    data['budget'] = budget;
    if (genres != null) {
      data['genres'] = genres!.map((v) => v.toJson()).toList();
    }
    data['homepage'] = homepage;
    data['id'] = id;
    data['imdb_id'] = imdbId;
    data['origin_country'] = originCountry;
    data['original_language'] = originalLanguage;
    data['original_title'] = originalTitle;
    data['overview'] = overview;
    data['popularity'] = popularity;
    data['poster_path'] = posterPath;
    if (productionCompanies != null) {
      data['production_companies'] =
          productionCompanies!.map((v) => v.toJson()).toList();
    }
    if (productionCountries != null) {
      data['production_countries'] =
          productionCountries!.map((v) => v.toJson()).toList();
    }
    data['release_date'] = releaseDate;
    data['revenue'] = revenue;
    data['runtime'] = runtime;
    if (spokenLanguages != null) {
      data['spoken_languages'] =
          spokenLanguages!.map((v) => v.toJson()).toList();
    }
    data['status'] = status;
    data['tagline'] = tagline;
    data['title'] = title;
    data['video'] = video;
    data['vote_average'] = voteAverage;
    data['vote_count'] = voteCount;
    return data;
  }
}

class BelongsToCollection {
  int? id;
  String? name;
  String? posterPath;
  String? backdropPath;

  BelongsToCollection({this.id, this.name, this.posterPath, this.backdropPath});

  BelongsToCollection.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    posterPath = json['poster_path'];
    backdropPath = json['backdrop_path'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['poster_path'] = posterPath;
    data['backdrop_path'] = backdropPath;
    return data;
  }
}

class Genres {
  int? id;
  String? name;

  Genres({this.id, this.name});

  Genres.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}

class ProductionCompanies {
  int? id;
  String? logoPath;
  String? name;
  String? originCountry;

  ProductionCompanies({this.id, this.logoPath, this.name, this.originCountry});

  ProductionCompanies.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    logoPath = json['logo_path'];
    name = json['name'];
    originCountry = json['origin_country'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['logo_path'] = logoPath;
    data['name'] = name;
    data['origin_country'] = originCountry;
    return data;
  }
}

class ProductionCountries {
  String? iso31661;
  String? name;

  ProductionCountries({this.iso31661, this.name});

  ProductionCountries.fromJson(Map<String, dynamic> json) {
    iso31661 = json['iso_3166_1'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['iso_3166_1'] = iso31661;
    data['name'] = name;
    return data;
  }
}

class SpokenLanguages {
  String? englishName;
  String? iso6391;
  String? name;

  SpokenLanguages({this.englishName, this.iso6391, this.name});

  SpokenLanguages.fromJson(Map<String, dynamic> json) {
    englishName = json['english_name'];
    iso6391 = json['iso_639_1'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['english_name'] = englishName;
    data['iso_639_1'] = iso6391;
    data['name'] = name;
    return data;
  }
}


// import 'production_country.dart';

// class MovieResponce {
//   final bool? adult;
//   final dynamic backdropPath;
//   final dynamic belongsToCollection;
//   final int? budget;
//   final List<dynamic>? genres;
//   final String? homepage;
//   final int? id;
//   final dynamic imdbId;
//   final List<String>? originCountry;
//   final String? originalLanguage;
//   final String? originalTitle;
//   final String? overview;
//   final double? popularity;
//   final String? posterPath;
//   final List<dynamic>? productionCompanies;
//   final List<ProductionCountry>? productionCountries;
//   final String? releaseDate;
//   final int? revenue;
//   final int? runtime;
//   final List<dynamic>? spokenLanguages;
//   final String? status;
//   final String? tagline;
//   final String? title;
//   final bool? video;
//   final int? voteAverage;
//   final int? voteCount;

//   const MovieResponce({
//     this.adult,
//     this.backdropPath,
//     this.belongsToCollection,
//     this.budget,
//     this.genres,
//     this.homepage,
//     this.id,
//     this.imdbId,
//     this.originCountry,
//     this.originalLanguage,
//     this.originalTitle,
//     this.overview,
//     this.popularity,
//     this.posterPath,
//     this.productionCompanies,
//     this.productionCountries,
//     this.releaseDate,
//     this.revenue,
//     this.runtime,
//     this.spokenLanguages,
//     this.status,
//     this.tagline,
//     this.title,
//     this.video,
//     this.voteAverage,
//     this.voteCount,
//   });

//   factory MovieResponce.fromJson(Map<String, dynamic> json) => MovieResponce(
//         adult: json['adult'] as bool?,
//         backdropPath: json['backdrop_path'] as dynamic,
//         belongsToCollection: json['belongs_to_collection'] as dynamic,
//         budget: json['budget'] as int?,
//         genres: json['genres'] as List<dynamic>?,
//         homepage: json['homepage'] as String?,
//         id: json['id'] as int?,
//         imdbId: json['imdb_id'] as dynamic,
//         originCountry: json['origin_country'] as List<String>?,
//         originalLanguage: json['original_language'] as String?,
//         originalTitle: json['original_title'] as String?,
//         overview: json['overview'] as String?,
//         popularity: (json['popularity'] as num?)?.toDouble(),
//         posterPath: json['poster_path'] as String?,
//         productionCompanies: json['production_companies'] as List<dynamic>?,
//         productionCountries: (json['production_countries'] as List<dynamic>?)
//             ?.map((e) => ProductionCountry.fromJson(e as Map<String, dynamic>))
//             .toList(),
//         releaseDate: json['release_date'] as String?,
//         revenue: json['revenue'] as int?,
//         runtime: json['runtime'] as int?,
//         spokenLanguages: json['spoken_languages'] as List<dynamic>?,
//         status: json['status'] as String?,
//         tagline: json['tagline'] as String?,
//         title: json['title'] as String?,
//         video: json['video'] as bool?,
//         voteAverage: json['vote_average'] as int?,
//         voteCount: json['vote_count'] as int?,
//       );

//   Map<String, dynamic> toJson() => {
//         'adult': adult,
//         'backdrop_path': backdropPath,
//         'belongs_to_collection': belongsToCollection,
//         'budget': budget,
//         'genres': genres,
//         'homepage': homepage,
//         'id': id,
//         'imdb_id': imdbId,
//         'origin_country': originCountry,
//         'original_language': originalLanguage,
//         'original_title': originalTitle,
//         'overview': overview,
//         'popularity': popularity,
//         'poster_path': posterPath,
//         'production_companies': productionCompanies,
//         'production_countries':
//             productionCountries?.map((e) => e.toJson()).toList(),
//         'release_date': releaseDate,
//         'revenue': revenue,
//         'runtime': runtime,
//         'spoken_languages': spokenLanguages,
//         'status': status,
//         'tagline': tagline,
//         'title': title,
//         'video': video,
//         'vote_average': voteAverage,
//         'vote_count': voteCount,
//       };
// }