import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../data.dart';
import '../../../utils.dart';
import '../update_operation_form.dart';
import './confirm_box.dart';

class OperationCard extends StatefulWidget {
  final Operation operation;

  const OperationCard(this.operation, {super.key});

  @override
  State<OperationCard> createState() => _OperationCardState();
}

class _OperationCardState extends State<OperationCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()=>showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          builder: (_) => UpdateOperationForm(operation: widget.operation),
        ),
      child: Dismissible(
        key: ValueKey(widget.operation.id),
        confirmDismiss: (_) async {
          showDialog(
            context: context,
            builder: (_) => ConfirmBox(operation: widget.operation),
          );
        },
        child: ColoredBox(
          color: widget.operation.operationType == OperationType.income
              ? Colors.green.withOpacity(0.2)
              : Colors.red.withOpacity(0.2),
          child: ListTile(
            leading: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(icons[widget.operation.category] ?? Icons.wallet),
            ),
            title: Text(widget.operation.title),
            subtitle: Text(DateFormat('MMMM dd, yyyy').format(widget.operation.date)),
            trailing: Text(
              "${widget.operation.operationType == OperationType.income
                  ? "+"
                  : "-"}${NumberFormat.currency(locale: 'ru_RU').format(
                  widget.operation.amount)}",
              style: TextStyle(
                  color: widget.operation.operationType == OperationType.income
                      ? Colors.green
                      : Colors.red),
            ),
          ),
        ),
      ),
    );
  }
}
