import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../data.dart';

class ConfirmBox extends StatelessWidget {
  const ConfirmBox({
    super.key,
    required this.operation,
  });

  final Operation operation;

  @override
  Widget build(BuildContext context) {
    final operationProvider =
        Provider.of<OperationsProvider>(context, listen: false);
    final categoryProvider =
        Provider.of<CategoryProvider>(context, listen: false);
    return AlertDialog(
      title: Text('Удалить ${operation.title} ?'),
      content: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(false);
            },
            child: const Text('нет'),
          ),
          const SizedBox(width: 5.0),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop(true); // delete
              operationProvider.deleteOperation(
                  operation.id, operation.category, operation.amount);
              var ex = categoryProvider.findCategory(operation.category);
              categoryProvider.updateCategory(operation.category, ex.entries - 1,
                  ex.totalAmount - operation.amount);
            },
            child: const Text('да'),
          ),
        ],
      ),
    );
  }
}
