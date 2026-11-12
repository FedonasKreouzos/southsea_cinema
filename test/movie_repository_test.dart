import 'package:flutter_test/flutter_test.dart';
import 'package:southsea_cinema/repositories/movie_repository.dart';

void main() {
  group('MovieRepository tests', () {
    final repository = MovieRepository();

    test('Returns a movie when the ID exists', () {
      final movies = repository.getMovies();
      final firstMovie = movies.first;

      final result = repository.getMovieById(firstMovie.id);

      expect(result, isNotNull);
      expect(result, firstMovie);
      expect(result!.id, firstMovie.id);
    });

    test('Returns null when the ID does not exist', () {
      final result = repository.getMovieById('missing-id');

      expect(result, isNull);
    });
  });
}
