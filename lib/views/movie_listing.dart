import 'package:flutter/material.dart';
import 'package:southsea_cinema/constants.dart';
import 'package:southsea_cinema/widgets/nav_drawer.dart';

class MovieListing extends StatefulWidget {
 const MovieListing({super.key});
@override
State<MovieListing> createState() => _MovieListingState();  }

class _MovieListingState extends State<MovieListing> {
  int _ticketQuantity = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(appTitle, style: cinemaHeaderStyle),
        backgroundColor: cinemaSurface,
        iconTheme: const IconThemeData(color: cinemaBrand),
        elevation: 0,
      ),
      drawer: const NavDrawer(),
      body: Container(
      padding: const EdgeInsets.all(16),
      child: const Column(
        children: [
  Text('DRACULA (1931) (PG)'),
  Text('Southsea Cinema Room'),
  Text('Thursday 22 Oct 2026, 18:00 - ends at 19:14'),
  Text('A classic horror film shown at Southsea Cinema.'),
    ],
  ),
),
    );
  }
}
}