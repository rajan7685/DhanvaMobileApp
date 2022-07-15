import 'package:dhanva_mobile_app/appointment_booked_screen/appointment_booked_screen_widget.dart';
import 'package:dhanva_mobile_app/components/next_icon_button_widget.dart';
import 'package:dhanva_mobile_app/flutter_flow/flutter_flow_theme.dart';
import 'package:dhanva_mobile_app/flutter_flow/flutter_flow_util.dart';
import 'package:dhanva_mobile_app/global/models/date_time_slot.dart';
import 'package:dhanva_mobile_app/global/models/doctor.dart';
import 'package:dhanva_mobile_app/global/providers/time_slot_provider.dart';
import 'package:dhanva_mobile_app/global/services/shared_preference_service.dart';
import 'package:dhanva_mobile_app/home_screen/models/quick_service_ui_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

String _dateTimeSelectedId = '';
String _dateTimeSelectedString = '';
String _selectedDoctorId;
String _selectedDoctorName;

String _to24HourTime(String time) {
  print("Given time $time");
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
    print('Formatted time 0$hour:$minute');
    return '0$hour:$minute';
  }
  print('Formatted time $hour:$minute');
  return '$hour:$minute';
}

ChangeNotifierProvider<TimeSlotProvider> _timeSotProvider =
    ChangeNotifierProvider((ref) => TimeSlotProvider());

class TimeSlotScreenWidget extends ConsumerStatefulWidget {
  final bool isUniversalTimeSlot;
  final QuickServiceUiModel service;
  final Doctor doctor;
  final String patientId;
  final String patientRelationType;
  final String symptopms;
  final bool isOnline;
  final String hospitalId;

  const TimeSlotScreenWidget(
      {Key key,
      @required this.patientId,
      @required this.patientRelationType,
      @required this.hospitalId,
      @required this.symptopms,
      @required this.service,
      @required this.isUniversalTimeSlot,
      this.isOnline = true,
      this.doctor})
      : super(key: key);

  @override
  ConsumerState<TimeSlotScreenWidget> createState() =>
      _TimeSlotScreenWidgetState();
}

class _TimeSlotScreenWidgetState extends ConsumerState<TimeSlotScreenWidget> {
  @override
  void initState() {
    super.initState();
    if (widget.isUniversalTimeSlot) {
      ref.read(_timeSotProvider).fetchAllTimeSlotData(init: true);
    } else {
      print(widget.doctor.name);
      _selectedDoctorId = widget.doctor.id;
      _selectedDoctorName = widget.doctor.name;
      ref.read(_timeSotProvider).fetchTimeSlotByDoctor(
          widget.hospitalId, widget.doctor.id,
          init: true);
    }
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
              child: Consumer(
                builder: (context, ref, child) {
                  TimeSlotProvider slotProv = ref.watch(_timeSotProvider);
                  if (slotProv.isTimeSlotDataLoading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    if (widget.isUniversalTimeSlot) {
                      return Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                        child: UniversalTimeSlotList(
                            timeSlots: slotProv.universalTimeSlots),
                      );
                    } else {
                      return Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                          child: DoctorTimeSlotList(slots: slotProv.timeSlots));
                    }
                  }
                },
              ),
            ),

            InkWell(
              onTap: () {
                print(_dateTimeSelectedId.split(',')[0]);
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => AppointmentBookedScreenWidget(
                        patientRelationType: widget.patientRelationType,
                        hospitalId: widget.hospitalId,
                        isOnline: widget.isOnline,
                        symtopms: widget.symptopms,
                        timeString: _dateTimeSelectedString,
                        patientId: widget.patientId,
                        date: DateTime.parse(_dateTimeSelectedId.split(',')[0]),
                        doctorName: _selectedDoctorName,
                        doctorId: _selectedDoctorId,
                        service: widget.service)));
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
    print('main list len ${widget.timeSlots.length}');
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
    print('main list len ${widget.slots.length}');
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
          itemCount: widget.availableTimeSlots.length,
          itemBuilder: (context, int index) {
            String formattedTime = _to24HourTime(
                widget.availableTimeSlots[index].availableTimeSlot);
            return InkWell(
              onTap: () {
                setState(() {
                  _dateTimeSelectedId =
                      '${widget.date.toString().split(' ')[0]} $formattedTime, ${widget.parentIndex}:$index';
                  _dateTimeSelectedString = formattedTime;
                  _selectedDoctorId =
                      widget.availableTimeSlots[index].docIds[0];
                  _selectedDoctorName =
                      widget.availableTimeSlots[index].docNames[0];
                  widget.updateUI();
                });
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
