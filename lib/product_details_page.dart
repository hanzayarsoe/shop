import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/cart_provider.dart';

class ProductDetailPage extends StatefulWidget {
  final Map<String, dynamic> product;

  const ProductDetailPage({super.key, required this.product});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  var selectedSize = 0;

  void addToCart() {
    if (selectedSize != 0) {
      Provider.of<CartProvider>(context, listen: false).addProduct({
        'title': widget.product['title'],
        'price': widget.product['price'],
        'imageUrl': widget.product['imageUrl'],
        'company': widget.product['company'],
        'id': widget.product['id'],
        'size': selectedSize
      });
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Product added to cart successfully'),
      ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Please select a size'),
      ));
    }
  }

  @override
  void initState() {
    super.initState();
    selectedSize;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Details'),
      ),
      body: Column(
        children: [
          Text(widget.product['title'],
              style: Theme.of(context).textTheme.titleLarge),
          const Spacer(),
          Image.asset(widget.product['imageUrl']),
          const Spacer(),
          Container(
            height: 200,
            padding: const EdgeInsets.only(top: 20),
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 194, 190, 190),
              borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
            ),
            child: Column(
              children: [
                Text(
                  '\$ ${widget.product['price']}',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                SizedBox(
                  height: 70,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: widget.product['sizes'].length,
                      itemBuilder: (context, index) {
                        final size = widget.product['sizes'][index];
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedSize = size;
                              });
                            },
                            child: Chip(
                                backgroundColor: selectedSize == size
                                    ? Theme.of(context).colorScheme.primary
                                    : Colors.white54,
                                label: Text(
                                  widget.product['sizes'][index].toString(),
                                )),
                          ),
                        );
                      }),
                ),
                SizedBox(
                  width: double.infinity,
                  child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              Theme.of(context).colorScheme.primary,
                        ),
                        onPressed: addToCart,
                        icon: const Icon(
                          Icons.add_shopping_cart_outlined,
                          size: 20,
                          color: Colors.black,
                        ),
                        label: const Text(
                          'Add to cart',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      )),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
