import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/cart_provider.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cartItems = Provider.of<CartProvider>(context).cart;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          children: [
            if (cartItems.isEmpty)
              const Center(child: Text('Your cart is empty')),
            if (cartItems.isNotEmpty)
              Expanded(
                child: ListView.builder(
                    itemCount: cartItems.length,
                    itemBuilder: (context, index) {
                      final cart = cartItems[index];
                      return ListTile(
                        title: Text('${cart['title']}'),
                        subtitle: Text('${cart['price']}'),
                        leading: CircleAvatar(
                          radius: 40,
                          backgroundImage:
                              AssetImage(cart['imageUrl'] as String),
                        ),
                        trailing: IconButton(
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                        title: Text(
                                          'Delete Product',
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium,
                                        ),
                                        content: const Text(
                                            'Are you sure you want to delete?'),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: const Text(
                                              'Cancel',
                                              style:
                                                  TextStyle(color: Colors.blue),
                                            ),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              Provider.of<CartProvider>(context,
                                                      listen: false)
                                                  .removeProduct(cart);
                                              Navigator.of(context).pop();
                                            },
                                            child: const Text(
                                              'Delete',
                                              style:
                                                  TextStyle(color: Colors.red),
                                            ),
                                          )
                                        ]);
                                  });
                            },
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.red,
                            )),
                      );
                    }),
              ),
            if (cartItems.isNotEmpty)
              ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      double totalPrice = calculateTotalPrice(cartItems);
                      return AlertDialog(
                        title: const Text('Total Price'),
                        content: Text(
                            'Thank you for your purchase\nThe total price of your items is \$${totalPrice.toStringAsFixed(2)} \n the delivery will be made within 3 days'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Provider.of<CartProvider>(context, listen: false)
                                  .clearCart();
                              Navigator.of(context).pop(); // Close the dialog
                            },
                            child: const Text('OK'),
                          ),
                        ],
                      );
                    },
                  );
                },
                child: const Text(
                  'Buy Now',
                  style: TextStyle(color: Colors.black),
                ),
              ),
          ],
        ),
      ),
    );
  }

  double calculateTotalPrice(List<Map<String, dynamic>> cartItems) {
    double totalPrice = 0.0;

    for (var item in cartItems) {
      double itemPrice = item['price'] ?? 0.0;
      int quantity =
          item['quantity'] ?? 1; // If quantity is not specified, default to 1
      totalPrice += itemPrice * quantity;
    }

    return totalPrice;
  }
}
