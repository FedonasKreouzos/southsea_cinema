import 'package:flutter/material.dart';
import 'package:southsea_cinema/repositories/basket_repository.dart';

class BasketView extends StatefulWidget {
  const BasketView({super.key});

  @override
  State<BasketView> createState() => _BasketViewState();
}

class _BasketViewState extends State<BasketView> {
  final BasketRepository _basketRepository = BasketRepository.instance;

  @override
  Widget build(BuildContext context) {
    final items = _basketRepository.items;

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Basket'),
      ),
      body: items.isEmpty
          ? const Center(
              child: Text('Your basket is empty'),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      final item = items[index];

                      return Card(
                        margin: const EdgeInsets.only(bottom: 12),
                        child: ListTile(
                          title: Text(item.movie.title),
                          subtitle: Text(
                            '${item.quantity} ticket(s) x ${item.movie.formattedPrice}\n'
                            'Subtotal: £${item.lineTotal.toStringAsFixed(2)}',
                          ),
                          isThreeLine: true,
                          trailing: IconButton(
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                            onPressed: () {
                              setState(() {
                                _basketRepository.removeItem(
                                  item.movie.id,
                                );
                              });
                            },
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Text(
                        'Total: £${_basketRepository.total.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}