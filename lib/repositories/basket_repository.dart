import 'package:southsea_cinema/models/cart_item.dart';
import 'package:southsea_cinema/models/movie.dart';

class BasketRepository {
  BasketRepository._internal();

  static final BasketRepository instance =
      BasketRepository._internal();

  final List<CartItem> _items = [];

  List<CartItem> get items => List.unmodifiable(_items);

  double get total {
    return _items.fold(0, (sum, item) => sum + item.lineTotal);
  }

  void addItem(Movie movie, {int quantity = 1}) {
    if (quantity <= 0) return;

    final index = _items.indexWhere(
      (item) => item.movie.id == movie.id,
    );

    if (index != -1) {
      final existingItem = _items[index];

      _items[index] = CartItem(
        movie: movie,
        quantity: existingItem.quantity + quantity,
      );
    } else {
      _items.add(
        CartItem(
          movie: movie,
          quantity: quantity,
        ),
      );
    }
  }

  void removeItem(String movieId) {
    _items.removeWhere(
      (item) => item.movie.id == movieId,
    );
  }

  void clear() {
    _items.clear();
  }
}