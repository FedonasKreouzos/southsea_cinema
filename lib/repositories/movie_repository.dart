import 'package:southsea_cinema/models/movie.dart';

class MovieRepository {
  List<Movie> getMovies() {
    return const [
      Movie(
        id: '1',
        title: 'Dracula',
        synopsis: 'A classic horror film.',
        ageRating: '15',
        screeningTime: '18:00',
        ticketPrice: 8.50,
        posterImagePath: 'assets/images/dracula.webp',
      ),
      Movie(
        id: '2',
        title: 'Taken',
        synopsis: 'An action thriller about a father searching for his daughter.',
        ageRating: '15',
        screeningTime: '20:00',
        ticketPrice: 9.50,
        posterImagePath: 'assets/images/taken.webp',
      ),
    ];
  }
        Movie? getMovieById(String id) {
        for (final movie in getMovies()) {
          if (movie.id == id) {
            return movie;
          }
        }

        return null;
      }
}