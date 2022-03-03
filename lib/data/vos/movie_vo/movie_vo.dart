import 'package:hive_flutter/adapters.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:movie_booking_app/data/vos/genre_vo/genre_vo.dart';
import 'package:movie_booking_app/data/vos/movie_vo/belongs_to_collection.dart';
import 'package:movie_booking_app/data/vos/movie_vo/production_companies.dart';
import 'package:movie_booking_app/data/vos/movie_vo/production_countries.dart';
import 'package:movie_booking_app/data/vos/movie_vo/spoken_languages.dart';
import 'package:movie_booking_app/persistance/hive_constant.dart';

part 'movie_vo.g.dart';

@JsonSerializable()
@HiveType(typeId: HIVE_TYPE_MOVIE_VO)
class MovieVO {
  @JsonKey(name: 'adult')
  @HiveField(0)
  bool? adult;

  @JsonKey(name: 'backdrop_path')
  @HiveField(1)
  String? backdropPath;

  @JsonKey(name: 'belongs_to_collection')
  @HiveField(2)
  BelongsToCollection? belongsToCollection;

  @JsonKey(name: 'budget')
  @HiveField(3)
  int? budget;

  @JsonKey(name: 'genres')
  @HiveField(4)
  List<GenreVO>? genres;

  @JsonKey(name: 'homepage')
  @HiveField(5)
  String? homePage;

  @JsonKey(name: 'genre_ids')
  @HiveField(6)
  List<int>? genreIDs;

  @JsonKey(name: 'id')
  @HiveField(7)
  int? id;

  @JsonKey(name: 'imdb_id')
  @HiveField(8)
  String? imdbID;

  @JsonKey(name: 'original_language')
  @HiveField(9)
  String? originalLanguage;

  @JsonKey(name: 'original_title')
  @HiveField(10)
  String? originalTitle;

  @JsonKey(name: 'overview')
  @HiveField(11)
  String? overview;

  @JsonKey(name: 'popularity')
  @HiveField(12)
  double? popularity;

  @JsonKey(name: 'poster_path')
  @HiveField(13)
  String? posterPath;

  @JsonKey(name: 'production_companies')
  @HiveField(14)
  List<ProductionCompanies>? productionCompanies;


  @JsonKey(name: 'production_countries')
  @HiveField(15)
  List<ProductionCountries>? productionCountries;


  @JsonKey(name: 'release_date')
  @HiveField(16)
  String? releaseDate;

  @JsonKey(name: 'revenue')
  @HiveField(17)
  int? revenue;

  @JsonKey(name: 'runtime')
  @HiveField(18)
  int? runtime;

  @JsonKey(name: 'spoken_languages')
  @HiveField(19)
  List<SpokenLanguages>? spokenLanguages;

  @JsonKey(name: 'status')
  @HiveField(20)
  String? status;

  @JsonKey(name: 'tagline')
  @HiveField(21)
  String? tagLine;

  @JsonKey(name: 'title')
  @HiveField(22)
  String? title;

  @JsonKey(name: 'video')
  @HiveField(23)
  bool? video;

  @JsonKey(name: 'vote_average')
  @HiveField(24)
  double? voteAverage;

  @JsonKey(name: 'vote_count')
  @HiveField(25)
  int? voteCount;

  @HiveField(26)
  late int order;

  @HiveField(27)
   bool ?isNowShowing;

  @HiveField(28)
   bool ?isComingSoon;

  MovieVO(
      this.adult,
      this.backdropPath,
      this.belongsToCollection,
      this.budget,
      this.genres,
      this.homePage,
      this.genreIDs,
      this.id,
      this.imdbID,
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
      this.tagLine,
      this.title,
      this.video,
      this.voteAverage,
      this.voteCount,
      {this.order=0,this.isNowShowing=false,this.isComingSoon=false}
      );

  MovieVO.normal();

  factory MovieVO.fromJson(Map<String, dynamic> json) =>
      _$MovieVOFromJson(json);

  Map<String, dynamic> toJson() => _$MovieVOToJson(this);

  List<String> getGenreListAsStringList() {
    return genres?.map((genre) => genre.name ?? "").toList() ?? [];
  }

  @override
  String toString() {
    return 'MovieVO{adult: $adult, backdropPath: $backdropPath, belongsToCollection: $belongsToCollection, budget: $budget, genres: $genres, homePage: $homePage, genreIDs: $genreIDs, id: $id, imdbID: $imdbID, originalLanguage: $originalLanguage, originalTitle: $originalTitle, overview: $overview, popularity: $popularity, posterPath: $posterPath, productionCompanies: $productionCompanies, productionCountries: $productionCountries, releaseDate: $releaseDate, revenue: $revenue, runtime: $runtime, spokenLanguages: $spokenLanguages, status: $status, tagLine: $tagLine, title: $title, video: $video, voteAverage: $voteAverage, voteCount: $voteCount, order: $order}';
  }
}
