import 'package:flutter/material.dart';
import 'package:vroom/model/cart.dart';
import 'package:vroom/model/product.dart';
import 'package:vroom/screens/product_card.dart';
import 'package:vroom/screens/card_cart.dart'; 
import 'package:provider/provider.dart';
import 'package:vroom/view_model/auth_view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<String> _titles = ['Home', 'Orders', 'Profile', 'Cart'];

  void _onTabClicked(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(_titles[_selectedIndex]),
            Consumer<CartModel>(
              builder: (context, cart, child) {
                final totalItems = cart.items.fold<int>(0, (sum, item) => sum + item.quantity);
                return Text(
                  'Total Items: $totalItems',
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                );
              },
            ),
          ],
        ),
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          _HomeTab(), 
          _OrdersTab(), 
          _ProfileTab(), 
          const CardCart() 
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.grey,
        currentIndex: _selectedIndex,
        onTap: _onTabClicked,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag_outlined),
            activeIcon: Icon(Icons.shopping_bag),
            label: 'Orders',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_2_outlined),
            activeIcon: Icon(Icons.person_2),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            activeIcon: Icon(Icons.shopping_cart),
            label: 'Cart',
          ),
        ],
      ),
    );
  }
}

class _HomeTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: dummyProducts.length,
      itemBuilder: (context, index) {
        final product = dummyProducts[index];
        return ProductCard(product: product);
      },
    );
  }
}

class _OrdersTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<CartModel>(
      builder: (context, cart, child) {
        if (cart.items.isEmpty) {
          return const Center(child: Text('Your cart is empty'));
        }
        return ListView.builder(
          itemCount: cart.items.length,
          itemBuilder: (context, index) {
            final cartItem = cart.items[index];
            return ProductCard(product: cartItem.product);
          },
        );
      },
    );
  }
}

class _ProfileTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Consumer<AuthView>(
        builder: (context, authView, child) {
          return ElevatedButton(
            onPressed: () async {
              await authView.logout();
            },
            child: const Text('Logout'),
          );
        },
      ),
    );
  }
}




