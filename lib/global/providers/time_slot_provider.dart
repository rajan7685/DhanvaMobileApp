import 'package:dhanva_mobile_app/global/models/date_time_slot.dart';
import 'package:dhanva_mobile_app/global/services/api_services/time_slot_api_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class TimeSlotProvider extends ChangeNotifier {
  List<DateTimeSlot> _timeSlots;
  List<UniversalDateTimeSlot> _universalTimeSlots;
  bool _isSlotDataLoading = true;

  List<DateTimeSlot> get timeSlots => _timeSlots;
  List<UniversalDateTimeSlot> get universalTimeSlots => _universalTimeSlots;
  bool get isTimeSlotDataLoading => _isSlotDataLoading == true;

  void _setSlotLoadingState(bool state) {
    _isSlotDataLoading = state;
    notifyListeners();
  }

  void _setTimeSlots(List<DateTimeSlot> slots) {
    _timeSlots = slots;
  }

  void _setUniversalTimeSlots(List<UniversalDateTimeSlot> slots) {
    _universalTimeSlots = slots;
  }

  Future<void> fetchTimeSlotByDoctor(String docID, {bool init = false}) async {
    if (!init) _setSlotLoadingState(true);
    Map<String, dynamic> data =
        await TimeSlotApiService.fetchTimeSlotsByDoctor(docID);
    List<DateTimeSlot> slots = [];
    data.entries.forEach((timeSlotData) {
      slots.add(DateTimeSlot.fromSlotDataByDoctor(timeSlotData));
    });
    _setTimeSlots(slots);
    _setSlotLoadingState(false);
  }

  Future<void> fetchAllTimeSlotData({bool init = false}) async {
    if (!init) _setSlotLoadingState(true);
    Map<String, dynamic> data = await TimeSlotApiService.fetchAllTImeSlots();
    List<UniversalDateTimeSlot> slots = [];
    data.entries.forEach((timeSlotData) {
      slots.add(UniversalDateTimeSlot.fromAllTimeSlotData(timeSlotData));
    });
    _setUniversalTimeSlots(slots);
    _setSlotLoadingState(false);
  }
}
