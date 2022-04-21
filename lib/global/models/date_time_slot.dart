import 'package:flutter/cupertino.dart';

class DateTimeSlot {
  final DateTime date;
  final String docID;
  final String docName;
  final List<String> availableTimeSlots;

  DateTimeSlot(
      {@required this.date,
      @required this.availableTimeSlots,
      @required this.docID,
      @required this.docName});

  factory DateTimeSlot.fromSlotDataByDoctor(MapEntry<String, dynamic> json) {
    Map<String, dynamic> valueJson = json.value[0];
    return DateTimeSlot(
        date: DateTime.parse(json.key),
        docID: valueJson['id'],
        docName: valueJson['name'],
        availableTimeSlots: List.generate(valueJson['availableSlots'].length,
            (int index) => valueJson['availableSlots'][index]));
  }
}
