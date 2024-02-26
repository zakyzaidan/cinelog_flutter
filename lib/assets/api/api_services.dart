import 'dart:convert';

import 'package:cinelog/features/detail/model/detail_movies_youtube_model.dart';
import 'package:http/http.dart' as http;
import '../../features/detail/model/actor_detail_movies.dart';
import '../../features/detail/model/detail_movies.dart';
import '../../features/home/model/popular_movies.dart';

class ApiServices {
  static const String accept = 'application/json';
  static const String authorization =
      'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI2ZmEyOWQxYmFhZDBjNzMyNWU0NDFlYWQ0NzFiMTZiYyIsInN1YiI6IjY1M2I1MDNiYmMyY2IzMDBjOTdkNjhkYyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.oh0R2f40YB7OJsR2PLBaIQn3kelF08Yw2pXs9Wk3qp4';
  String baseUrlImage = 'https://image.tmdb.org/t/p/w500';
  Map<String, String> headers = {
    'Accept': accept,
    'Authorization': authorization
  };

  Future<ListMovies> getPopularMovies(int index) async {
    final response = await http.get(
        Uri.parse(
            'https://api.themoviedb.org/3/movie/popular?language=en-US&page=$index'),
        headers: headers);
    if (response.statusCode == 200) {
      return ListMovies.fromJson(json.decode(response.body));
    } else {
      throw Exception("Failed to load popular movies");
    }
  }

  Future<ListMovies> getTopRatedMovies(int index) async {
    final response = await http.get(
        Uri.parse(
            'https://api.themoviedb.org/3/movie/top_rated?language=en-US&page=$index'),
        headers: headers);
    if (response.statusCode == 200) {
      return ListMovies.fromJson(json.decode(response.body));
    } else {
      throw Exception("Failed to load top rated movies");
    }
  }

  Future<DetailMovies> getDetailMovies(int id) async {
    final response = await http.get(
        Uri.parse('https://api.themoviedb.org/3/movie/$id'),
        headers: headers);
    if (response.statusCode == 200) {
      return DetailMovies.fromJson(json.decode(response.body));
    } else {
      throw Exception("Failed to load detail movies");
    }
  }

  Future<ActorDetailMovies> getActorDetailMovies(int id) async {
    final response = await http.get(
        Uri.parse('https://api.themoviedb.org/3/movie/$id/credits'),
        headers: headers);
    if (response.statusCode == 200) {
      return ActorDetailMovies.fromJson(json.decode(response.body));
    } else {
      throw Exception("Failed to load actor detail movies");
    }
  }

  Future<DetailMoviesYoutubeModel> getYoutubeTrailerDetailMovies(int id) async {
    final response = await http.get(
        Uri.parse('https://api.themoviedb.org/3/movie/$id/videos'),
        headers: headers);
    if (response.statusCode == 200) {
      return DetailMoviesYoutubeModel.fromJson(json.decode(response.body));
    } else {
      throw Exception("Failed to load actor detail movies");
    }
  }

  Future<ListMovies> getSearchMoviesByQuery(String query, int index) async {
    final response = await http.get(
        Uri.parse(
            'https://api.themoviedb.org/3/search/movie?query=$query&include_adult=false&language=en-US&page=$index'),
        headers: headers);
    if (response.statusCode == 200) {
      return ListMovies.fromJson(json.decode(response.body));
    } else {
      throw Exception("Failed to load actor detail movies");
    }
  }
}
