import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../data.dart';
import './operation_chart.dart';
import 'operations_list.dart';

class OperationBody extends StatefulWidget {
  final String category;
  const OperationBody(this.category, {super.key});

  @override
  State<OperationBody> createState() => _OperationBodyState();
}

class _OperationBodyState extends State<OperationBody> {
  late Future _expenseList;

  Future _getOperationList() async {
    final provider = Provider.of<OperationsProvider>(context, listen: false);
    return await provider.getOperationsByCategory(widget.category);
  }

  @override
  void initState() {
    super.initState();
    _expenseList = _getOperationList();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _expenseList,
      builder: (_, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          } else {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                children: [
                  SizedBox(
                    height: 250.0,
                    child: OperationChart(widget.category),
                  ),
                  const Expanded(child: OperationList()),
                ],
              ),
            );
          }
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
