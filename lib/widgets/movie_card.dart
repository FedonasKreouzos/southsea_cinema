import 'package:flutter/material.dart';
import 'package:southsea_cinema/models/movie.dart';
import 'package:southsea_cinema/constants.dart';

class MovieCard extends StatelessWidget {
  final Movie movie;
  final VoidCallback onBookNow;

  const MovieCard({
    super.key,
    required this.movie,
    required this.onBookNow,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFF252D3A),
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.asset(
                movie.posterImagePath,
                height: 230,
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              movie.title,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF55D6E8),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Age Rating: ${movie.ageRating}',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              movie.synopsis,
              style: const TextStyle(
                color: Color(0xFFE0E5EC),
                fontSize: 15,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Screening Time: ${movie.screeningTime}',
              style: const TextStyle(color: Colors.white),
            ),
            const SizedBox(height: 6),
            Text(
              'Ticket Price: £${movie.ticketPrice.toStringAsFixed(2)}',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: cinemaBrand,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                onPressed: onBookNow,
                child: const Text(
                  'Book Now',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
