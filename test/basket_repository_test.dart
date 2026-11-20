import 'package:flutter_test/flutter_test.dart';
import 'package:southsea_cinema/models/movie.dart';
import 'package:southsea_cinema/repositories/basket_repository.dart';
import 'package:southsea_cinema/repositories/movie_repository.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late BasketRepository basketRepository;
  late MovieRepository movieRepository;
  late List<Movie> movies;

  setUp(() async {
    basketRepository = BasketRepository.instance;
    basketRepository.clear();

    movieRepository = MovieRepository();
    movies = await movieRepository.loadMoviesFromAsset();
  });

  test('Add a movie to the basket', () {
    final movie = movieRepository.getMovieById('1', movies)!;

    basketRepository.addItem(movie);

    expect(basketRepository.items.length, 1);
    expect(basketRepository.items.first.movie.title, 'Dracula');
    expect(basketRepository.items.first.quantity, 1);
  });

  test('Add more tickets for the same movie', () {
    final movie = movieRepository.getMovieById('1', movies)!;

    basketRepository.addItem(movie, quantity: 2);
    basketRepository.addItem(movie, quantity: 3);

    expect(basketRepository.items.length, 1);
    expect(basketRepository.items.first.quantity, 5);
  });

  test('Remove a movie from the basket', () {
    final movie = movieRepository.getMovieById('1', movies)!;

    basketRepository.addItem(movie);
    basketRepository.removeItem('1');

    expect(basketRepository.items, isEmpty);
  });

  test('Clear the basket', () {
    basketRepository.addItem(
      movieRepository.getMovieById('1', movies)!,
    );

    basketRepository.addItem(
      movieRepository.getMovieById('2', movies)!,
    );

    basketRepository.clear();

    expect(basketRepository.items, isEmpty);
  });

  test('Calculate the correct basket total', () {
    basketRepository.addItem(
      movieRepository.getMovieById('1', movies)!,
      quantity: 2,
    );

    basketRepository.addItem(
      movieRepository.getMovieById('2', movies)!,
      quantity: 1,
    );

    expect(basketRepository.total, 26.50);
  });
}