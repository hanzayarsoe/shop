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
    'Addidas',
    'Nike',
    'Bata',
  ];
  late String selectedBrand;

  List<Map<String, dynamic>> filteredProducts = [];
  void filterProducts(String brand, String searchText) {
    // Apply brand filter
    if (brand == 'All') {
      filteredProducts = List.from(products);
    } else {
      filteredProducts =
          products.where((product) => product['company'] == brand).toList();
    }

    // Apply search text filter
    if (searchText.isNotEmpty) {
      filteredProducts = filteredProducts
          .where((product) => product['title']
              .toString()
              .toLowerCase()
              .contains(searchText.toLowerCase()))
          .toList();
    }
  }

  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    selectedBrand = brands[0];
    filterProducts(selectedBrand, '');
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
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
                Expanded(
                  child: TextField(
                    controller: searchController,
                    decoration: InputDecoration(
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color.fromARGB(141, 255, 82, 82),
                        ),
                      ),
                      hintText: 'Search',
                      prefixIcon: const Icon(Icons.search),
                      suffixIcon: searchController.text.isNotEmpty
                          ? IconButton(
                              icon: const Icon(Icons.clear),
                              onPressed: () {
                                setState(() {
                                  // Clear the text field and update the filtered products
                                  searchController.clear();
                                  filterProducts(selectedBrand, '');
                                });
                              },
                            )
                          : null,
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.horizontal(
                          left: Radius.circular(30),
                        ),
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {
                        filterProducts(selectedBrand, value);
                      });
                    },
                  ),
                )
              ],
            ),
            SizedBox(
              height: 50,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: brands.length,
                itemBuilder: (context, index) {
                  final brand = brands[index];
                  return Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedBrand = brand;
                          filterProducts(selectedBrand, '');
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
                },
              ),
            ),
            Expanded(
              child: LayoutBuilder(builder: (context, constraints) {
                if (constraints.maxWidth > 1080) {
                  return GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 1.95,
                    ),
                    itemCount: filteredProducts.length,
                    itemBuilder: (context, index) {
                      final product = filteredProducts[index];
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
                    },
                  );
                } else {
                  return ListView.builder(
                      keyboardDismissBehavior:
                          ScrollViewKeyboardDismissBehavior.onDrag,
                      itemCount: filteredProducts.length,
                      itemBuilder: (context, index) {
                        final product = filteredProducts[index];
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
                      });
                }
              }),
            )
          ],
        ),
      ),
    );
  }
}
