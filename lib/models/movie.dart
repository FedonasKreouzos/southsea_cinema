class Movie {
  final String id;
  final String title;
  final String synopsis;
  final String ageRating;
  final String screeningTime;
  final double ticketPrice;
  final String posterImagePath;
  String get formattedPrice => '£${ticketPrice.toStringAsFixed(2)}';

  const Movie({
    required this.id,
    required this.title,
    required this.synopsis,
    required this.ageRating,
    required this.screeningTime,
    required this.ticketPrice,
    required this.posterImagePath,
  });
}