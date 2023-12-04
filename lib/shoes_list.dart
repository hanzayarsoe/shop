import 'package:flutter/material.dart';
import 'package:shop/product_details_page.dart';
import 'package:shop/product_widget.dart';
import 'package:shop/products.dart';

class ShoesListPage extends StatefulWidget {
  const ShoesListPage({super.key});

  @override
  State<ShoesListPage> createState() => _ShoesListPageState();
}

class _ShoesListPageState extends State<ShoesListPage> {
  final List<String> brands = const [
    'All',
    'Adidas',
    'Nike',
    'Converse',
    'Skechers',
  ];
  late String selectedBrand;

  @override
  void initState() {
    super.initState();
    selectedBrand = brands[0];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    'Shoes\nCollections',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                const Expanded(
                    child: TextField(
                  decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                        color: Colors.black12,
                      )),
                      hintText: 'Search',
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.horizontal(
                        left: Radius.circular(30),
                      ))),
                ))
              ],
            ),
            SizedBox(
              height: 60,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: brands.length,
                  itemBuilder: (context, index) {
                    final brand = brands[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 0),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedBrand = brand;
                          });
                        },
                        child: Chip(
                          backgroundColor: selectedBrand == brand
                              ? Theme.of(context).colorScheme.primary
                              : Colors.white54,
                          label: Text(
                            brand,
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                      ),
                    );
                  }),
            ),
            Expanded(
              child: ListView.builder(
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    final product = products[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return ProductDetailPage(product: product);
                        }));
                      },
                      child: ProductCard(
                        title: product['title'] as String,
                        price: product['price'] as double,
                        image: product['imageUrl'] as String,
                        color: index.isEven
                            ? const Color.fromARGB(199, 101, 157, 255)
                            : const Color.fromARGB(190, 250, 52, 52),
                      ),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}
