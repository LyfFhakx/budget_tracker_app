import 'package:flutter/material.dart';

import '../widgets/operation_body/operation_fetcher.dart';

class OperationScreen extends StatelessWidget {
  const OperationScreen({super.key});

  static const name = '/operation_screen';

  @override
  Widget build(BuildContext context) {
    final category = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      appBar: AppBar(title: Text(category)),
      body: OperationBody(category),
    );
  }
}
