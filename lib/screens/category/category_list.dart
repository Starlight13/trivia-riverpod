import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trivia_riverpod/providers/categories_provider.dart';

class CategoryList extends ConsumerWidget {
  const CategoryList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categories = ref.watch(categoriesProvider);

    return switch (categories) {
      AsyncData(:final value) => ListView.builder(
          itemCount: value.length,
          itemBuilder: (context, index) {
            final category = value[index];
            return ListTile(title: Text(category.name));
          },
        ),
      AsyncError(:final error) => Center(
          child: Text('Error: $error'),
        ),
      _ => const Center(
          child: CircularProgressIndicator(),
        ),
    };
  }
}
