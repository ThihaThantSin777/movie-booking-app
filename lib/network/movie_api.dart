import 'package:dio/dio.dart';
import 'package:movie_booking_app/data/vos/movie_vo/movie_vo.dart';
import 'package:movie_booking_app/network/api_constant/api_constant.dart';
import 'package:movie_booking_app/network/response/cast_crew_response/cast_crew_response.dart';
import 'package:movie_booking_app/network/response/genre_response/genre_response.dart';
import 'package:movie_booking_app/network/response/movie_response/movie_response.dart';
import 'package:retrofit/http.dart';

part 'movie_api.g.dart';

@RestApi(baseUrl: BASE_URL_MOVIE)
abstract class MovieAPI {
  factory MovieAPI(Dio dio) = _MovieAPI;

  @GET(GET_NOW_PLAYING_END_POINT)
  Future<MovieResponse> getNowPlayingMovie(
    @Query(QUERY_PARMS_API_KEY) String apiKey,
    @Query(QUERY_PARMS_LANGUAGE) String language,
    @Query(QUERY_PARMS_PAGE) int page,
  );

  @GET(GENRE_END_POINT)
  Future<GenreResponse> getGenres(
    @Query(QUERY_PARMS_API_KEY) String apiKey,
    @Query(QUERY_PARMS_LANGUAGE) String language,
  );

  @GET(GET_COMING_SOON_MOVIE_END_POINT)
  Future<MovieResponse> getComingSoonMovie(
    @Query(QUERY_PARMS_API_KEY) String apiKey,
    @Query(QUERY_PARMS_LANGUAGE) String language,
    @Query(QUERY_PARMS_PAGE) int page,
  );

  @GET('$GET_MOVIE_DETAILS_END_POINT/{movie_id}')
  Future<MovieVO> getMovieDetails(
    @Path('movie_id') int movieID,
    @Query(QUERY_PARMS_API_KEY) String apiKey,
    @Query(QUERY_PARMS_LANGUAGE) String language,
  );

  @GET('/3/movie/{movie_id}/credits')
  Future<CastCrewResponse> getCreditsByMovie(
    @Path('movie_id') int movieID,
    @Query(QUERY_PARMS_API_KEY) String apiKey,
    @Query(QUERY_PARMS_LANGUAGE) String language,
  );
}
