import 'package:flutter/material.dart';
import 'package:southsea_cinema/constants.dart';
import 'package:southsea_cinema/widgets/nav_drawer.dart';

class MovieListing extends StatefulWidget {
 const MovieListing({super.key});

  @override
  State<MovieListing> createState() => _MovieListingState();  
}

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
      child: Column(
        children: [
  Text('DRACULA (1931) (PG)'),
  Text('Southsea Cinema Room'),
  Text('Thursday 22 Oct 2026, 18:00 - ends at 19:14'),
  Text('A classic horror film shown at Southsea Cinema.'),
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
    ],
  ),
),
    );
  }
}
}