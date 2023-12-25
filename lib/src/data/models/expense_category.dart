import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../utils.dart';

class OperationCategory extends Equatable {
  final String title;
  final int entries;
  final double totalAmount;
  final IconData icon;

  const OperationCategory({
    required this.title,
    required this.entries,
    required this.totalAmount,
    required this.icon,
  });

  Map<String, dynamic> toMap() => {
        'title': title,
        'entries': entries,
        'totalAmount': totalAmount.toString(),
      };

  factory OperationCategory.fromString(Map<String, dynamic> value) =>
      OperationCategory(
        title: value['title'],
        entries: value['entries'],
        totalAmount: double.parse(value['totalAmount']),
        icon: icons[value['title']] ?? Icons.wallet,
      );

  @override
  List<Object?> get props => [title, entries, totalAmount, icon];

  OperationCategory copyWith({
    String? title,
    int? entries,
    double? totalAmount,
    IconData? icon,
  }) {
    return OperationCategory(
      title: title ?? this.title,
      entries: entries ?? this.entries,
      totalAmount: totalAmount ?? this.totalAmount,
      icon: icon ?? this.icon,
    );
  }
}
