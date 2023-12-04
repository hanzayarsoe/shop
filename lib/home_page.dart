import 'package:flutter/material.dart';
import 'package:shop/cart.dart';
import 'package:shop/shoes_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var currenPage = 0;
  final List<Widget> pages = const [ShoesListPage(), CartPage()];
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
        body: IndexedStack(
          index: currenPage,
          children: pages,
        ),
        bottomNavigationBar: BottomNavigationBar(
            selectedFontSize: 0,
            unselectedFontSize: 0,
            iconSize: 30,
            currentIndex: currenPage,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.shopping_cart),
                label: '',
              )
            ],
            onTap: (index) {
              setState(() {
                currenPage = index;
              });
            }));
  }
}
