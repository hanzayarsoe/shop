import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/cart_provider.dart';
import 'package:shop/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CartProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Shoes Shop',
        theme: ThemeData(
            useMaterial3: true,
            fontFamily: 'lato',
            colorScheme: ColorScheme.fromSeed(
              seedColor: const Color.fromARGB(255, 253, 159, 18),
              primary: const Color.fromARGB(255, 231, 172, 8),
            ),
            inputDecorationTheme: const InputDecorationTheme(
              hintStyle: TextStyle(
                  fontFamily: 'lato',
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
            textTheme: const TextTheme(
              titleMedium: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              bodySmall: TextStyle(
                fontSize: 16,
              ),
              titleLarge: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            appBarTheme: const AppBarTheme(
                centerTitle: true,
                elevation: 0,
                titleTextStyle: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                ))),
        home: const HomePage(),
      ),
    );
  }
}
