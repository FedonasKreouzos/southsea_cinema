import 'package:flutter_test/flutter_test.dart';
import 'package:southsea_cinema/repositories/movie_repository.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('MovieRepository tests', () {
    final repository = MovieRepository();

    test('Loads all movies from the JSON asset', () async {
      final movies = await repository.loadMoviesFromAsset();

      expect(movies.length, 2);
      expect(movies[0].title, 'Dracula');
      expect(movies[1].title, 'Taken');
    });

    test('Loads all movie fields correctly', () async {
      final movies = await repository.loadMoviesFromAsset();

      final dracula = movies.first;

      expect(dracula.id, '1');
      expect(dracula.title, 'Dracula');
      expect(dracula.synopsis, 'A classic horror film.');
      expect(dracula.ageRating, '15');
      expect(dracula.screeningTime, '18:00');
      expect(dracula.ticketPrice, 8.50);
      expect(dracula.posterImagePath, 'assets/images/dracula.webp');
    });

    test('Returns a movie when the ID exists', () async {
      final movies = await repository.loadMoviesFromAsset();

      final result = repository.getMovieById('1', movies);

      expect(result, isNotNull);
      expect(result!.title, 'Dracula');
    });

    test('Returns null when the ID does not exist', () async {
      final movies = await repository.loadMoviesFromAsset();

      final result = repository.getMovieById('missing-id', movies);

      expect(result, isNull);
    });
  });
}