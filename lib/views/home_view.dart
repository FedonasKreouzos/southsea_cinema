import 'package:flutter/material.dart';
import 'package:southsea_cinema/repositories/movie_repository.dart';
import 'package:southsea_cinema/models/movie.dart';
import 'package:southsea_cinema/widgets/movie_card.dart';
import 'package:southsea_cinema/views/movie_listing.dart';
import 'package:southsea_cinema/widgets/nav_drawer.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final MovieRepository _movieRepository = MovieRepository();

  List<Movie> _movies = [];
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadMovies();
  }

  Future<void> _loadMovies() async {
    try {
      final movies = await _movieRepository.loadMoviesFromAsset();

      if (!mounted) return;

      setState(() {
        _movies = movies;
        _isLoading = false;
        _errorMessage = null;
      });
    } catch (error) {
        debugPrint('MOVIE LOADING ERROR: $error');
        
      if (!mounted) return;

      setState(() {
        _isLoading = false;
        _errorMessage = 'Unable to load movies. Please try again.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Southsea Cinema'),
      ),
      drawer: const NavDrawer(),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (_errorMessage != null) {
      return Center(
        child: Text(_errorMessage!),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _movies.length,
      itemBuilder: (context, index) {
        final movie = _movies[index];

        return MovieCard(
          movie: movie,
          onBookNow: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MovieListing(
                  movie: movie,
                ),
              ),
            );
          },
        );
      },
    );
  }
}