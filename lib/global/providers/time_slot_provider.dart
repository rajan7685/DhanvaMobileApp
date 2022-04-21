import 'package:dhanva_mobile_app/global/models/date_time_slot.dart';
import 'package:dhanva_mobile_app/global/services/api_services/time_slot_api_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class TimeSlotProvider extends ChangeNotifier {
  List<DateTimeSlot> _timeSlots;
  bool _isSlotDataLoading = true;

  List<DateTimeSlot> get timeSlots => _timeSlots;
  bool get isTimeSlotDataLoading => _isSlotDataLoading == true;

  void _setSlotLoadingState(bool state) {
    _isSlotDataLoading = state;
    notifyListeners();
  }

  void _setTimeSlots(List<DateTimeSlot> slots) {
    _timeSlots = slots;
  }

  Future<void> fetchTimeSlotByDoctor(String docID, {bool init = false}) async {
    if (!false) _setSlotLoadingState(true);
    Map<String, dynamic> data =
        await TimeSlotApiService.fetchTimeSlotsByDoctor(docID);
    List<DateTimeSlot> slots = [];
    data.entries.forEach((timeSlotData) {
      slots.add(DateTimeSlot.fromSlotDataByDoctor(timeSlotData));
    });
  }

  Future<void> fetchAllTimeSlotData() async {
    //
  }
}
