import 'package:flutter/material.dart';
import 'main.dart';

class ShoppingCartPage extends StatefulWidget {
  final List<Product> cartProducts;

  const ShoppingCartPage({super.key, required this.cartProducts});

  @override _ShoppingCartPageState createState() => _ShoppingCartPageState();
}

class _ShoppingCartPageState extends State<ShoppingCartPage> {
  void _incrementQuantity(Product product) {
    setState(() {
      product.quantity++;
    });
  }

  void _decrementQuantity(Product product) {
    setState(() {
      if (product.quantity > 1) {
        product.quantity--;
      }
    });
  }

  void _removeProduct(Product product) {
    setState(() {
      widget.cartProducts.remove(product);
    });
  }

  @override Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Корзина'),
      ),
      body: widget.cartProducts.isEmpty ? const Center(child: Text('Корзина пуста'))
          : ListView.builder(
              itemCount: widget.cartProducts.length,
              itemBuilder: (context, index) {
                final product = widget.cartProducts[index];
                return Dismissible(
                  key: Key(product.name),
                  direction: DismissDirection.endToStart,
                  onDismissed: (direction) {
                    _removeProduct(product);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('${product.name} удален из корзины')),
                    );
                  },
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),
                  child: ListTile(
                    title: Text(product.name),
                    subtitle: Text('Цена: \$${product.price}'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.remove),
                          onPressed: () => _decrementQuantity(product),
                        ),
                        Text('${product.quantity}'),
                        IconButton(
                          icon: const Icon(Icons.add),
                          onPressed: () => _incrementQuantity(product),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
