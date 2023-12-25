import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../data.dart';
import '../operation_body/operation_card.dart';

class AllOperationsList extends StatelessWidget {
  const AllOperationsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<OperationsProvider>(
      builder: (_, expanseProvider, __) {
        var list = expanseProvider.operations;
        return list.isNotEmpty
            ? ListView.builder(
                physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics()),
                itemCount: list.length,
                itemBuilder: (_, i) => OperationCard(list[i]),
              )
            : const Center(
                child: Text('Нет операций'),
              );
      },
    );
  }
}
