import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../../data.dart';
import '../../utils.dart';

class UpdateOperationForm extends StatefulWidget {
  final Operation operation;

  const UpdateOperationForm({super.key, required this.operation});

  @override
  State<UpdateOperationForm> createState() => _UpdateOperationFormState();
}

class _UpdateOperationFormState extends State<UpdateOperationForm> {
  late final TextEditingController _titleController;
  late final TextEditingController _amountController;
  late OperationType _currentOperationType;
  DateTime? _date;
  String _initialValue = 'Другое';

  @override
  initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.operation.title);
    _amountController =
        TextEditingController(text: widget.operation.amount.toStringAsFixed(2));
    _initialValue = widget.operation.category;
    _currentOperationType = widget.operation.operationType;
  }

  _pickDate() async {
    DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: widget.operation.date,
        firstDate: DateTime(2023),
        lastDate: DateTime.now());

    if (pickedDate != null) {
      setState(() {
        _date = pickedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final operationProvider =
        Provider.of<OperationsProvider>(context, listen: false);
    final categoryProvider =
        Provider.of<CategoryProvider>(context, listen: false);
    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      padding: const EdgeInsets.all(20.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                operationContainer(OperationType.expense),
                const SizedBox(
                  width: 10,
                ),
                operationContainer(OperationType.income),
              ],
            ),
            const SizedBox(height: 20.0),
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Описание',
              ),
            ),
            const SizedBox(height: 20.0),
            // amount
            TextField(
              controller: _amountController,
              keyboardType: const TextInputType.numberWithOptions(signed: true),
              decoration: const InputDecoration(
                labelText: 'Сумма',
              ),
            ),
            const SizedBox(height: 20.0),
            // date picker
            Row(
              children: [
                Expanded(
                  child: Text(_date != null
                      ? DateFormat('MMMM dd, yyyy').format(_date!)
                      : 'Выберите дату'),
                ),
                IconButton(
                  onPressed: () => _pickDate(),
                  icon: const Icon(Icons.calendar_month),
                ),
              ],
            ),
            const SizedBox(height: 20.0),
            // category
            if (_currentOperationType == OperationType.expense)
              Row(
                children: [
                  const Expanded(child: Text('Категория')),
                  Expanded(
                    child: DropdownButton(
                      items: icons.keys
                          .map(
                            (e) => DropdownMenuItem(
                              value: e,
                              child: Text(e),
                            ),
                          )
                          .toList(),
                      value: _initialValue,
                      onChanged: (newValue) {
                        setState(() {
                          _initialValue = newValue!;
                        });
                      },
                    ),
                  ),
                ],
              ),
            const SizedBox(height: 20.0),
            ElevatedButton.icon(
              onPressed: () {
                if (_amountController.text != '') {
                  final file = Operation(
                    operationType: _currentOperationType,
                    id: widget.operation.id,
                    title: _titleController.text.isNotEmpty
                        ? _titleController.text
                        : '',
                    amount: double.parse(
                        _amountController.text.replaceAll('-', '')),
                    date: _date != null ? _date! : DateTime.now(),
                    category: _initialValue,
                  );
                  operationProvider.updateOperation(file);

                  if (widget.operation.category != _initialValue) {
                    var oldCategory = categoryProvider
                        .findCategory(widget.operation.category);
                    categoryProvider.updateCategory(
                        widget.operation.category,
                        oldCategory.entries - 1,
                        oldCategory.totalAmount - widget.operation.amount);
                    var newCategory =
                        categoryProvider.findCategory(file.category);
                    categoryProvider.updateCategory(
                        file.category,
                        newCategory.entries + 1,
                        newCategory.totalAmount + file.amount);
                  }

                  Navigator.of(context).pop(true);
                }
              },
              icon: const Icon(Icons.add),
              label: const Text('Обновить'),
            ),
          ],
        ),
      ),
    );
  }

  Widget operationContainer(OperationType type) {
    return Expanded(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: InkWell(
          onTap: () {
            if (_currentOperationType != type) {
              setState(() {
                if (type == OperationType.income) {
                  _initialValue = "Доходы";
                } else {
                  _initialValue = "Другое";
                }
                _currentOperationType = type;
              });
            }
          },
          child: Container(
            decoration: BoxDecoration(
                color: (type == OperationType.expense)
                    ? (_currentOperationType == type
                        ? Colors.red
                        : Colors.red.withOpacity(0.2))
                    : (_currentOperationType == type
                        ? Colors.green
                        : Colors.green.withOpacity(0.2)),
                borderRadius: BorderRadius.circular(5)),
            padding: const EdgeInsets.all(16),
            child: Text(
              OperationType.operationTypeToString(type),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
