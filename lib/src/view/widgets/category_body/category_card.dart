import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../data.dart';
import '../../screens/operation_screen.dart';

class CategoryCard extends StatelessWidget {
  final OperationCategory category;
  const CategoryCard(this.category, {super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Navigator.of(context).pushNamed(
          OperationScreen.name,
          arguments: category.title,
        );
      },
      leading: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Icon(category.icon),
      ),
      title: Text(category.title),
      subtitle: Text('операции: ${category.entries}'),
      trailing: Text(NumberFormat.currency(locale: 'ru_RU')
          .format(category.totalAmount)),
    );
  }
}
