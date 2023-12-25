import 'package:equatable/equatable.dart';

enum OperationType {
  expense,
  income;

 static String operationTypeToString(OperationType type) {
    switch (type) {
      case OperationType.expense:
        return "Расходы";
      case OperationType.income:
        return "Доходы";
    }
  }
}



class Operation extends Equatable {
  final OperationType operationType;
  final int id;
  final String title;
  final double amount;
  final DateTime date;
  final String category;

  const Operation({
    required this.operationType,
    required this.id,
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
  });

  @override
  List<Object?> get props => [operationType, id, title, amount, date, category];

  factory Operation.fromMap(Map<String, dynamic> map) {
    return Operation(
        id: map['id'],
        operationType: OperationType.values.byName(map['operationType']),
        title: map['title'],
        amount: double.parse(map['amount']),
        date: DateTime.parse(map['date']),
        category: map['category']);
  }

  Map<String, dynamic> toMap() => {
        'operationType': operationType.name,
        'title': title,
        'amount': amount.toString(),
        'date': date.toString(),
        'category': category,
      };

  Operation copyWith({
    OperationType? operationType,
    int? id,
    String? title,
    double? amount,
    DateTime? date,
    String? category,
  }) {
    return Operation(
      operationType: operationType ?? this.operationType,
      id: id ?? this.id,
      title: title ?? this.title,
      amount: amount ?? this.amount,
      date: date ?? this.date,
      category: category ?? this.category,
    );
  }
}
