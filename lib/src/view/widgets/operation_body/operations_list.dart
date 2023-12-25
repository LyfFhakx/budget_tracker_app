import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../data.dart';
import './operation_card.dart';

class OperationList extends StatelessWidget {
  const OperationList({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<OperationsProvider>(
      builder: (_, operationProvider, __) {
        var exList = operationProvider.operations;
        return exList.isNotEmpty
            ? ListView.builder(
                itemCount: exList.length,
                itemBuilder: (_, i) => OperationCard(exList[i]))
            : const Center(
                child: Text('Нет операций'),
              );
      },
    );
  }
}
