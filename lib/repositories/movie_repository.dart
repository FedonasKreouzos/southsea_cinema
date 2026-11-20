import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:southsea_cinema/models/movie.dart';

class MovieRepository {
  Future<List<Movie>> loadMoviesFromAsset() async {
    final String jsonString =
        await rootBundle.loadString('assets/data/movies.json');

    final List<dynamic> jsonList = jsonDecode(jsonString) as List<dynamic>;

    return jsonList
        .map((json) => Movie.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  Movie? getMovieById(String id, List<Movie> movies) {
    for (final movie in movies) {
      if (movie.id == id) {
        return movie;
      }
    }

    return null;
  }
}