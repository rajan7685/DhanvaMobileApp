import 'package:flutter/cupertino.dart';

class GlobalAvailableTimeSlot {
  final List<String> docIds;
  final List<String> docNames;
  final String availableTimeSlot;

  GlobalAvailableTimeSlot({
    @required this.availableTimeSlot,
    @required this.docNames,
    @required this.docIds,
  });

  factory GlobalAvailableTimeSlot.fromJson(MapEntry<String, dynamic> json) =>
      GlobalAvailableTimeSlot(
          availableTimeSlot: json.key,
          docIds: List.generate((json.value as List).length,
              (int index) => json.value[index]['id']),
          docNames: List.generate((json.value as List).length,
              (int index) => json.value[index]['name']));
}

class UniversalDateTimeSlot {
  final DateTime date;
  final List<GlobalAvailableTimeSlot> availableTimeSlots;

  UniversalDateTimeSlot({
    @required this.date,
    @required this.availableTimeSlots,
  });

  factory UniversalDateTimeSlot.fromAllTimeSlotData(
      MapEntry<String, dynamic> json) {
    List<GlobalAvailableTimeSlot> slots = [];
    (json.value as Map<String, dynamic>).entries.forEach((json) {
      slots.add(GlobalAvailableTimeSlot.fromJson(json));
    });
    return UniversalDateTimeSlot(
        date: DateTime.parse(json.key), availableTimeSlots: slots);
  }
}

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
