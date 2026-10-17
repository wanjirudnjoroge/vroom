import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vroom/model/cart.dart';

class CardCart extends StatelessWidget {
  const CardCart({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CartModel>(
      builder: (context, cart, child) {
        if (cart.items.isEmpty) {
          return const Center(child: Text('Your cart is empty'));
        }
        return Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: cart.items.length,
                itemBuilder: (context, index) {
                  final cartItem = cart.items[index];
                  return Card(
                    margin: const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(
                              cartItem.product.imageUrl,
                              width: 80,
                              height: 80,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) => Container(
                                width: 80,
                                height: 80,
                                color: Colors.grey.shade200,
                                child: const Icon(Icons.directions_car, color: Colors.deepPurple),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(cartItem.product.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                                const SizedBox(height: 4),
                                Text('KES ${cartItem.totalItemPrice}', style: const TextStyle(color: Colors.green, fontWeight: FontWeight.w600)),
                              ],
                            ),
                          ),
                          Row(   
                            children: [
                              IconButton(
                                icon: const Icon(Icons.remove, color: Colors.red),
                                onPressed: () {
                                  cart.removeItem(cartItem.product);
                                },
                              ),
                              Text('${cartItem.quantity}', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                              IconButton(
                                icon: const Icon(Icons.add_circle_outline, color: Colors.green),
                                onPressed: () {
                                  cart.addItem(cartItem.product);
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    spreadRadius: 1,
                    blurRadius: 10,
                    offset: const Offset(0, -5),
                  ),
                ],
              ),
              child: SafeArea(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Total Price:',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Ksh ${cart.totalCartPrice}',
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.green),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
