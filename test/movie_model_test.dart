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
  });
}
