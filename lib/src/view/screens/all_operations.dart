import 'package:flutter/material.dart';
import '../widgets/all_expenses_body/all_operations_body.dart';

class AllOperations extends StatefulWidget {
  const AllOperations({super.key});
  static const name = '/all_operations';

  @override
  State<AllOperations> createState() => _AllOperationsState();
}

class _AllOperationsState extends State<AllOperations> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Все Операции')),
      body: const AllOperationsBody(),
    );
  }
}
