import 'package:flutter/material.dart';
import 'package:southsea_cinema/models/movie.dart';

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
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              movie.posterImagePath,
              width: double.infinity,
              height: 200,
              fit: BoxFit.contain,
            ),

            const SizedBox(height: 12),

            Text(
              movie.title,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            Text('Age Rating: ${movie.ageRating}'),

            const SizedBox(height: 8),

            Text(movie.synopsis),

            const SizedBox(height: 8),

            Text('Screening Time: ${movie.screeningTime}'),

            Text(
              'Ticket Price: £${movie.ticketPrice.toStringAsFixed(2)}',
            ),

            const SizedBox(height: 12),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: onBookNow,
                child: const Text('Book Now'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}