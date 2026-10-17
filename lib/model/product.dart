class Product {
  final String name;
  final String description;
  final double price;
  final String imageUrl;

  const Product({
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
  });
}

final List<Product> dummyProducts = [
  Product(
    name: 'Toyota Land Cruiser',
    description: 'Powerful 4x4 luxury SUV built for rugged terrain.',
    price: 14500000.0,
    imageUrl: 'https://images.unsplash.com/photo-1650530579355-7ad9d4766043?w=500&auto=format&fit=crop&q=60',
  ),
  Product(
    name: 'Mercedes-Benz C-Class',
    description: 'Elegant executive sedan with premium interior styling.',
    price: 6800000.0,
    imageUrl: 'https://images.unsplash.com/photo-1686562483617-3cf08d81e117?q=80&w=1470&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
  ),
  Product(
    name: 'Subaru Impreza WRX STI',
    description: 'Rally-bred sport performance vehicle with all-wheel drive.',
    price: 4200000.0,
    imageUrl: 'https://images.unsplash.com/photo-1592501706475-0fa88c3a86c8?q=80&w=1887&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
  ),
  Product(
    name: 'Mazda CX-5',
    description: 'Fuel-efficient crossover SUV featuring sleek Kodo design.',
    price: 3500000.0,
    imageUrl: 'https://images.unsplash.com/photo-1643142313598-3f7469304623?q=80&w=1470&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
  ),
  Product(
    name: 'Nissan Navara',
    description: 'Heavy-duty double cabin pickup truck with superior payload capacity.',
    price: 5100000.0,
    imageUrl: 'https://images.unsplash.com/photo-1618782530124-fa5ddd7358df?q=80&w=764&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
  ),
  Product(
    name: 'Honda Civic Type R',
    description: 'High-performance hot hatch built for speed and handling.',
    price: 5800000.0,
    imageUrl: 'https://images.unsplash.com/photo-1654870645915-de8afa6b3b30?q=80&w=1470&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
  ),
];
