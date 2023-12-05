import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final String title;
  final double price;
  final String image;
  final Color color;

  const ProductCard({
    super.key,
    required this.title,
    required this.price,
    required this.image,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          '\$ ${price.toString()}',
          style: Theme.of(context).textTheme.bodySmall,
        ),
        Center(
          child: Image.asset(
            image,
            height: 175,
          ),
        ),
      ]),
    );
  }
}
