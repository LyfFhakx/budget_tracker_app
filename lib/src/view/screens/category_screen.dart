import 'package:flutter/material.dart';
import '../widgets/category_body/category_fetcher.dart';
import '../widgets/operation_form.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  static const name = '/category_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Категории'),
      ),
      body: const CategoryBody(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (_) => const OperationForm(),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
