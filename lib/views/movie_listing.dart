import 'package:flutter/material.dart';
import 'package:southsea_cinema/constants.dart';
import 'package:southsea_cinema/widgets/nav_drawer.dart';

class MovieListing extends StatelessWidget {
  const MovieListing({super.key});

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
        Text(
          'DRACULA (1931) (PG)',
        ),
         Text(
          'A classic horror film shown at Southsea Cinema.',
      ),
    ],
  ),
),
    );
  }
}