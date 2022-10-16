import 'dart:async';

import 'package:dhanva_mobile_app/appointment_booked_screen/appointment_booked_screen_widget.dart';
import 'package:dhanva_mobile_app/components/next_icon_button_widget.dart';
import 'package:dhanva_mobile_app/flutter_flow/flutter_flow_theme.dart';
import 'package:dhanva_mobile_app/flutter_flow/flutter_flow_util.dart';
import 'package:dhanva_mobile_app/global/models/date_time_slot.dart';
import 'package:dhanva_mobile_app/global/models/doctor.dart';
import 'package:dhanva_mobile_app/global/providers/time_slot_provider.dart';
import 'package:dhanva_mobile_app/global/services/shared_preference_service.dart';
import 'package:dhanva_mobile_app/h_v_t_bookappointments/hvt_payment_screen.dart';
import 'package:dhanva_mobile_app/home_screen/models/quick_service_ui_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../global/services/api_services/api_service_base.dart';
import '../time_slot_screen/time_slot_screen_widget.dart';

String _dateTimeSelectedId = '';
String _dateTimeSelectedString = '';
String _selectedDoctorId;
String _selectedDoctorName;

String _to24HourTime(String time) {
  // print("Given time $time");
  String timeMaridane = time.split(' ')[1];
  String hourTime = time.split(' ')[0];
  int hour = int.parse(hourTime.split(':')[0]);
  int minute = int.parse(hourTime.split(':')[1]);
  if (timeMaridane == 'pm') {
    hour = (hour + 12);
  }
  if (minute == 0) {
    if (hour.toString().length == 1) return '0$hour:00';
    return '$hour:00';
  }
  if (hour.toString().length == 1) {
    // print('Formatted time 0$hour:$minute');
    return '0$hour:$minute';
  }
  // print('Formatted time $hour:$minute');
  return '$hour:$minute';
}

String _time24to12Format(String time) {
  time = time.split(" ").first;
  int hour = int.parse(time.split(":").first);
  String minuteString = time.split(":").last;

  if (hour == 0) {
    return '$hour:$minuteString am';
  } else if (hour <= 12) {
    return '${time.split(":").first}:$minuteString am';
  } else {
    int h = hour % 12;
    if (h <= 9) return '0$h:$minuteString pm';
    return '$h:$minuteString pm';
  }
}

ChangeNotifierProvider<TimeSlotProvider> _timeSotProvider =
    ChangeNotifierProvider((ref) => TimeSlotProvider());

class hvtTimeSlot extends ConsumerStatefulWidget {
  final bool isUniversalTimeSlot;
  final Doctor doctor;
  final Map<String, dynamic> data;

  const hvtTimeSlot(
      {Key key,
      @required this.data,
      @required this.isUniversalTimeSlot,
      this.doctor})
      : super(key: key);

  @override
  ConsumerState<hvtTimeSlot> createState() => _TimeSlotScreenWidgetState();
}

class _TimeSlotScreenWidgetState extends ConsumerState<hvtTimeSlot> {
  List<UniversalDateTimeSlot> universalTimeSlots = [];
  List<DateTimeSlot> doctorTimeSlots = [];
  bool _isTimeSlotDataLoading = true;

  @override
  void initState() {
    print("time slot universal? ${widget.isUniversalTimeSlot}");
    print("doctor? ${widget.doctor}");
    if (widget.isUniversalTimeSlot) {
      _loadAllTimeSlots();
    } else {
      _loadDoctorTimeSlots();
    }
    super.initState();
  }

  Future<void> _loadAllTimeSlots() async {
    Response res = await ApiService.dio.get(
        "${ApiService.protocol}${ApiService.baseUrl2}hvt/available/time-slots/alternate",
        options: Options(headers: {
          'Authorization': SharedPreferenceService.loadString(key: AuthTokenKey)
        }));
    (res.data as Map).entries.forEach(
          (slot) => universalTimeSlots
              .add(UniversalDateTimeSlot.fromAllTimeSlotData(slot)),
        );
    setState(() {
      _isTimeSlotDataLoading = false;
    });
  }

  Future<void> _loadDoctorTimeSlots() async {
    Response res = await ApiService.dio.get(
        "${ApiService.protocol}${ApiService.baseUrl2}hvt/time-slots/${widget.doctor.id}",
        options: Options(headers: {
          'Authorization': SharedPreferenceService.loadString(key: AuthTokenKey)
        }));
    print(res.data);
    (res.data as Map).entries.forEach(
          (slot) =>
              doctorTimeSlots.add(DateTimeSlot.fromSlotDataByDoctor(slot)),
        );

    setState(() {
      _isTimeSlotDataLoading = false;
    });
    print(" time_slot:${_time24to12Format(_dateTimeSelectedString)}");
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Icon(
                    Icons.arrow_back_rounded,
                    color: Color(0xff00A8A3),
                    size: 34,
                  ),
                ),
              ],
            ),
            SizedBox(
              width: double.maxFinite,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    'Today',
                    style: FlutterFlowTheme.of(context).bodyText1.override(
                          fontFamily: 'Open Sans',
                          color: Color(0xFF282828),
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  Text(
                    'Tomorrow',
                    style: FlutterFlowTheme.of(context).bodyText1.override(
                          fontFamily: 'Open Sans',
                          color: Color(0xFF282828),
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  Text(
                    DateFormat.MMMd()
                        .format(DateTime.now().add(Duration(days: 2))),
                    style: FlutterFlowTheme.of(context).bodyText1.override(
                          fontFamily: 'Open Sans',
                          color: Color(0xFF282828),
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 12,
            ),
            Expanded(
              child: _isTimeSlotDataLoading
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : (widget.isUniversalTimeSlot
                      ? UniversalTimeSlotList(timeSlots: universalTimeSlots)
                      : DoctorTimeSlotList(slots: doctorTimeSlots)),
            ),

            InkWell(
              onTap: () {
                // print(_dateTimeSelectedId.split(',')[0]);
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => hvtPaymentScreenWidget(
                        // goal: widget.data["goal"],
                        doctorId: widget.doctor == null
                            ? _selectedDoctorId
                            : widget.doctor.id,
                        doctorName: widget.doctor == null
                            ? _selectedDoctorName
                            : widget.doctor.name,
                        data: {
                          "appointmentDate": _dateTimeSelectedId.split(",")[0],
                          "time_slot": _dateTimeSelectedString,
                          ...widget.data,
                        }),
                  ),
                );
              },
              child: Container(
                  width: 225,
                  margin: EdgeInsets.only(bottom: 18, top: 8),
                  padding: EdgeInsets.all(6),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(22),
                      color: Color(0xff00A8A3)),
                  child: NextIconButtonWidget()),
            )
            // next button
          ],
        ),
      ),
    );
  }
}

class UniversalTimeSlotList extends StatefulWidget {
  final List<UniversalDateTimeSlot> timeSlots;

  const UniversalTimeSlotList({Key key, @required this.timeSlots})
      : super(key: key);

  @override
  State<UniversalTimeSlotList> createState() => _UniversalTimeSlotListState();
}

class _UniversalTimeSlotListState extends State<UniversalTimeSlotList> {
  @override
  void initState() {
    print("unversal timeslot");
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // print('main list len ${widget.timeSlots}');
    return SizedBox(
      width: double.maxFinite,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(widget.timeSlots.length, (int index) {
          return GlobalTimeSlotRenderer(
              updateUI: () {
                setState(() {
                  // update
                });
              },
              parentIndex: index,
              date: widget.timeSlots[index].date,
              availableTimeSlots: widget.timeSlots[index].availableTimeSlots);
        }),
      ),
    );
  }
}

class DoctorTimeSlotListRenderer extends StatefulWidget {
  final List<String> slots;
  final VoidCallback updateUI;
  final DateTime date;
  final int parentIndex;

  const DoctorTimeSlotListRenderer(
      {Key key,
      @required this.slots,
      @required this.date,
      @required this.parentIndex,
      @required this.updateUI})
      : super(key: key);

  @override
  State<DoctorTimeSlotListRenderer> createState() =>
      _DoctorTimeSlotListRendererState();
}

class _DoctorTimeSlotListRendererState
    extends State<DoctorTimeSlotListRenderer> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: ListView.builder(
          shrinkWrap: true,
          physics: BouncingScrollPhysics(),
          scrollDirection: Axis.vertical,
          itemCount: widget.slots.length,
          itemBuilder: (context, int index) {
            String formattedTime = _to24HourTime(widget.slots[index]);
            return InkWell(
              onTap: () {
                _dateTimeSelectedId =
                    '${widget.date.toString().split(' ')[0]} $formattedTime, ${widget.parentIndex}:$index';
                _dateTimeSelectedString = formattedTime;
                // _selectedDoctorName =
                //       widget.availableTimeSlots[index].docNames[0];
                widget.updateUI();
              },
              child: TimeSLotButton(
                  dateId:
                      '${widget.date.toString().split(' ')[0]} $formattedTime',
                  isSelected: _dateTimeSelectedId ==
                      '${widget.date.toString().split(' ')[0]} $formattedTime, ${widget.parentIndex}:$index',
                  time: widget.slots[index]),
            );
          }),
    );
  }
}

class DoctorTimeSlotList extends StatefulWidget {
  final List<DateTimeSlot> slots;
  const DoctorTimeSlotList({Key key, @required this.slots}) : super(key: key);

  @override
  State<DoctorTimeSlotList> createState() => _DoctorTimeSlotListState();
}

class _DoctorTimeSlotListState extends State<DoctorTimeSlotList> {
  @override
  Widget build(BuildContext context) {
    // print("time list${widget.slots}");
    return SizedBox(
      width: double.maxFinite,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(widget.slots.length, (int index) {
          return DoctorTimeSlotListRenderer(
              date: widget.slots[index].date,
              updateUI: () {
                setState(() {
                  // update ui
                });
              },
              parentIndex: index,
              slots: widget.slots[index].availableTimeSlots);
        }),
      ),
    );
  }
}

class GlobalTimeSlotRenderer extends StatefulWidget {
  final int parentIndex;
  final List<GlobalAvailableTimeSlot> availableTimeSlots;
  final VoidCallback updateUI;
  final DateTime date;

  const GlobalTimeSlotRenderer(
      {Key key,
      @required this.parentIndex,
      @required this.updateUI,
      @required this.date,
      @required this.availableTimeSlots})
      : super(key: key);

  @override
  State<GlobalTimeSlotRenderer> createState() => _GlobalTimeSlotRendererState();
}

class _GlobalTimeSlotRendererState extends State<GlobalTimeSlotRenderer> {
  @override
  void initState() {
    print("GlobalTimeSlotRenderer");
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: ListView.builder(
          shrinkWrap: true,
          physics: BouncingScrollPhysics(),
          scrollDirection: Axis.vertical,
          itemCount: widget.availableTimeSlots.length,
          itemBuilder: (context, int index) {
            String formattedTime = _to24HourTime(
                widget.availableTimeSlots[index].availableTimeSlot);
            return InkWell(
              onTap: () {
                setState(() {
                  _dateTimeSelectedId =
                      '${widget.date.toString().split(' ')[0]} $formattedTime, ${widget.parentIndex}:$index';
                  _dateTimeSelectedString =
                      widget.availableTimeSlots[index].availableTimeSlot;
                  _selectedDoctorId =
                      widget.availableTimeSlots[index].docIds[0];
                  _selectedDoctorName =
                      widget.availableTimeSlots[index].docNames[0];

                  widget.updateUI();
                });
                print("initial time : $_dateTimeSelectedString");
                print(
                    "fornatted time : ${_time24to12Format(_dateTimeSelectedString)}");
              },
              child: TimeSLotButton(
                  dateId:
                      '${widget.date.toString().split(' ')[0]} $formattedTime',
                  isSelected: _dateTimeSelectedId ==
                      '${widget.date.toString().split(' ')[0]} $formattedTime, ${widget.parentIndex}:$index',
                  time: widget.availableTimeSlots[index].availableTimeSlot),
            );
          }),
    );
  }
}

class TimeSLotButton extends StatefulWidget {
  final String time;
  final String dateId;
  final bool isSelected;
  const TimeSLotButton(
      {Key key,
      @required this.time,
      @required this.dateId,
      @required this.isSelected})
      : super(key: key);

  @override
  State<TimeSLotButton> createState() => _TimeSLotButtonState();
}

class _TimeSLotButtonState extends State<TimeSLotButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 0, 4, 4),
      width: 35,
      height: 35,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          color: widget.isSelected ? Color(0xff00A8A3) : Colors.transparent,
          border: Border.all(
            color: widget.isSelected ? Color(0xff00A8A3) : Color(0xFF606E87),
          )),
      child: Center(
        child: Text(
          widget.time,
          style: FlutterFlowTheme.of(context).bodyText1.override(
                fontFamily: 'Open Sans',
                color: widget.isSelected ? Colors.white : Color(0xFF606E87),
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
        ),
      ),
    );
  }
}
