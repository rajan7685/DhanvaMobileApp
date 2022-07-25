import 'package:flutter/foundation.dart';

class QuickServiceUiModel {
  final List<String> departments;
  final double amount;
  final String id;
  final String name;
  final bool enabled;
  final DateTime createdDateTime;
  final DateTime updatedDateTime;
  final int v;
  final String iconLink;
  final int paymentType;

  QuickServiceUiModel(
      {@required this.departments,
      @required this.amount,
      @required this.id,
      @required this.name,
      @required this.enabled,
      @required this.createdDateTime,
      @required this.v,
      @required this.iconLink,
      @required this.updatedDateTime,
      @required this.paymentType});

  factory QuickServiceUiModel.fromJson(Map<String, dynamic> json) =>
      QuickServiceUiModel(
          departments: List.generate(json['departments'].length,
              (int index) => json['departments'][index].toString()),
          amount: double.parse(json['amount']),
          id: json['_id'],
          name: json['name'],
          enabled: json['enabled'],
          updatedDateTime: DateTime.parse(json['updated_datetime']),
          createdDateTime: DateTime.parse(json['created_datetime']),
          v: json['__v'],
          iconLink: json['icon'],
          paymentType: int.parse(json['payment_type']));
}
