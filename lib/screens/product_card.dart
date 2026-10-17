import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vroom/model/product.dart';
import 'package:vroom/model/cart.dart';

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                product.imageUrl,
                width: 120,
                height: 120,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: 120,
                    height: 120,
                    color: Colors.grey.shade200,
                    child: const Icon(Icons.directions_car, color: Colors.deepPurple, size: 40),
                  );
                },
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    product.description,
                    style: TextStyle(color: Colors.grey.shade600),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Consumer<CartModel>(
                        builder: (context, cart, child) {
                          final cartItem = cart.items.firstWhere(
                            (item) => item.product.name == product.name,
                            orElse: () => CartItem(product: product, quantity: 0),
                          );
                          
                          final currentPrice = cartItem.quantity > 0 
                              ? cartItem.totalItemPrice 
                              : product.price;

                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'KES $currentPrice',
                                style: const TextStyle(fontWeight: FontWeight.w600, color: Colors.green),
                              ),
                              if (cartItem.quantity > 0)
                                Text(
                                  'Qty: ${cartItem.quantity}',
                                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                                ),
                            ],
                          );
                        },
                      ),
                      IconButton(
                        onPressed: () {
                          Provider.of<CartModel>(context, listen: false).addItem(product);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('${product.name} added to cart!'), duration: const Duration(seconds: 1)),
                          );
                        },
                        icon: const Icon(Icons.add_shopping_cart, color: Colors.deepPurple),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
