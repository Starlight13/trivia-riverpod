import 'package:flutter/material.dart';
import 'package:trivia_riverpod/screens/category/category_list.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Trivia Categories')),
      body: const SafeArea(child: CategoryList()),
    );
  }
}
