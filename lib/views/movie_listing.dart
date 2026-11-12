import 'package:flutter/material.dart';
import 'package:southsea_cinema/constants.dart';
import 'package:southsea_cinema/models/movie.dart';
import 'package:southsea_cinema/widgets/nav_drawer.dart';

class MovieListing extends StatefulWidget {
  final Movie movie;

  const MovieListing({
    super.key,
    required this.movie,
  });

  @override
  State<MovieListing> createState() => _MovieListingState();
}

class _MovieListingState extends State<MovieListing> {
  int _ticketQuantity = 0;
  String _feedback = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.movie.title, style: cinemaHeaderStyle),
        backgroundColor: cinemaSurface,
        iconTheme: const IconThemeData(color: cinemaBrand),
        elevation: 0,
      ),
      drawer: const NavDrawer(),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Image.asset(
              widget.movie.posterImagePath,
              height: 200,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 16),

            Text(
              '${widget.movie.title} (${widget.movie.ageRating})',
            ),
            const Text('Southsea Cinema Room'),
            Text('Screening Time: ${widget.movie.screeningTime}'),
            Text(widget.movie.synopsis),
            Text(
            'Ticket Price: ${widget.movie.formattedPrice}',          
            ),

            const SizedBox(height: 16),

            DropdownMenu<int>(
              initialSelection: 0,
              onSelected: (int? value) {
                if (value != null) {
                  setState(() {
                    _ticketQuantity = value;
                  });
                }
              },
              dropdownMenuEntries: [
                DropdownMenuEntry(value: 0, label: '0'),
                DropdownMenuEntry(value: 1, label: '1'),
                DropdownMenuEntry(value: 2, label: '2'),
                DropdownMenuEntry(value: 3, label: '3'),
                DropdownMenuEntry(value: 4, label: '4'),
                DropdownMenuEntry(value: 5, label: '5'),
              ],
            ),

            const SizedBox(height: 12),

            ElevatedButton(
              onPressed: () {
                setState(() {
                  _feedback =
                      '$_ticketQuantity ticket(s) added to order';
                });
              },
              child: const Text('Add to Order'),
            ),

            Text(_feedback),
          ],
        ),
      ),
    );
  }
}