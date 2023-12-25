import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../data.dart';

class OperationSearch extends StatelessWidget {
  const OperationSearch({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<OperationsProvider>(context, listen: false);
    return TextField(
      onChanged: (value) {
        provider.searchText = value;
      },
      decoration: const InputDecoration(
        labelText: 'Поиск',
      ),
    );
  }
}
