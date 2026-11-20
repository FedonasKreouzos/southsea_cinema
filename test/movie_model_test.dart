import 'package:flutter_test/flutter_test.dart';
import 'package:southsea_cinema/models/movie.dart';

void main() {
  group('Movie model tests', () {
    test('Movie constructor assigns properties correctly', () {
      const movie = Movie(
        id: '1',
        title: 'Dracula',
        synopsis: 'A vampire story',
        ageRating: 'PG',
        screeningTime: '18:00',
        ticketPrice: 8.0,
        posterImagePath: 'assets/images/dracula.webp',
      );

      expect(movie.id, '1');
      expect(movie.title, 'Dracula');
      expect(movie.synopsis, 'A vampire story');
      expect(movie.ageRating, 'PG');
      expect(movie.screeningTime, '18:00');
      expect(movie.ticketPrice, 8.0);
      expect(movie.posterImagePath, 'assets/images/dracula.webp');
    });

    test('formattedPrice displays whole pounds with two decimals', () {
      const movie = Movie(
        id: '1',
        title: 'Dracula',
        synopsis: 'A vampire story',
        ageRating: 'PG',
        screeningTime: '18:00',
        ticketPrice: 8.0,
        posterImagePath: 'assets/images/dracula.webp',
      );

      expect(movie.formattedPrice, '£8.00');
    });

    test('formattedPrice displays prices with pence', () {
      const movie = Movie(
        id: '2',
        title: 'Taken',
        synopsis: 'An action film',
        ageRating: '15',
        screeningTime: '20:00',
        ticketPrice: 9.5,
        posterImagePath: 'assets/images/taken.webp',
      );

      expect(movie.formattedPrice, '£9.50');
    });

    test('Movie.fromJson converts JSON into a Movie', () {
      final movie = Movie.fromJson({
        'id': '1',
        'title': 'Dracula',
        'synopsis': 'A classic horror film.',
        'ageRating': '15',
        'screeningTime': '18:00',
        'ticketPrice': 8.50,
        'posterImagePath': 'assets/images/dracula.webp',
      });

      expect(movie.id, '1');
      expect(movie.title, 'Dracula');
      expect(movie.synopsis, 'A classic horror film.');
      expect(movie.ageRating, '15');
      expect(movie.screeningTime, '18:00');
      expect(movie.ticketPrice, 8.50);
      expect(movie.posterImagePath, 'assets/images/dracula.webp');
    });

    test('Movie.fromJson accepts whole-number prices', () {
      final movie = Movie.fromJson({
        'id': '3',
        'title': 'Test Film',
        'synopsis': 'A test film.',
        'ageRating': '12',
        'screeningTime': '16:00',
        'ticketPrice': 8,
        'posterImagePath': 'assets/images/test.webp',
      });

      expect(movie.ticketPrice, 8.0);
      expect(movie.ticketPrice, isA<double>());
    });

    test('Movie.toJson converts a Movie into JSON', () {
      const movie = Movie(
        id: '2',
        title: 'Taken',
        synopsis: 'An action thriller.',
        ageRating: '15',
        screeningTime: '20:00',
        ticketPrice: 9.50,
        posterImagePath: 'assets/images/taken.webp',
      );

      final json = movie.toJson();

      expect(json['id'], '2');
      expect(json['title'], 'Taken');
      expect(json['synopsis'], 'An action thriller.');
      expect(json['ageRating'], '15');
      expect(json['screeningTime'], '20:00');
      expect(json['ticketPrice'], 9.50);
      expect(json['posterImagePath'], 'assets/images/taken.webp');
    });
  });
}