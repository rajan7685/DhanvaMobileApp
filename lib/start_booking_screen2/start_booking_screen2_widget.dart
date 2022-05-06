import 'dart:convert';

import 'package:dhanva_mobile_app/global/models/doctor.dart';
import 'package:dhanva_mobile_app/global/models/patient.dart';
import 'package:dhanva_mobile_app/global/models/patient_relation.dart';
import 'package:dhanva_mobile_app/global/providers/doctor_record_provider.dart';
import 'package:dhanva_mobile_app/global/services/shared_preference_service.dart';
import 'package:dhanva_mobile_app/home_screen/models/quick_service_ui_model.dart';
import 'package:dhanva_mobile_app/start_booking_screen/start_booking_screen_widget.dart';
import 'package:dhanva_mobile_app/time_slot_screen/time_slot_screen_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../components/next_icon_button_widget.dart';
import '../flutter_flow/flutter_flow_radio_button.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

Doctor _selectedDoctor = null;

ChangeNotifierProvider<DoctorRecordProvider> _doctorsProvider =
    ChangeNotifierProvider((ref) => DoctorRecordProvider());

class StartBookingScreen2Widget extends ConsumerStatefulWidget {
  final QuickServiceUiModel service;
  final String pageTitle;

  const StartBookingScreen2Widget(
      {Key key, @required this.service, this.pageTitle = 'Start Booking'})
      : super(key: key);

  @override
  _StartBookingScreen2WidgetState createState() =>
      _StartBookingScreen2WidgetState();
}

class _StartBookingScreen2WidgetState
    extends ConsumerState<StartBookingScreen2Widget> {
  String radioButtonValue;
  TextEditingController textController1;
  TextEditingController textController2;
  Patient patient;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  List<DropdownMenuItem<String>> patientNames = [];
  String _selectedPatientId;

  @override
  void initState() {
    super.initState();
    patient = Patient.fromJson(
        jsonDecode(SharedPreferenceService.loadString(key: PatientKey)));
    textController1 = TextEditingController(text: patient.name);
    patientNames.add(DropdownMenuItem(
      child: Text(patient.name),
      value: patient.id,
    ));
    for (PatientRelation relation in patient.relations) {
      patientNames.add(DropdownMenuItem(
        child: Text(relation.patientName),
        value: relation.patientId,
      ));
    }
    _selectedPatientId = patient.id;
    textController2 = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Color(0xFFF5F5F5),
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Stack(
            children: [
              Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.3,
                decoration: BoxDecoration(
                  color: Color(0xFFEEEEEE),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: Image.asset(
                      'assets/images/page_bgbg.png',
                    ).image,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(12, 8, 12, 0),
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.arrow_back_rounded,
                        color: Colors.white,
                        size: 34,
                      ),
                      Expanded(
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 0, 12, 0),
                              child: Container(
                                width: 45,
                                height: 45,
                                decoration: BoxDecoration(
                                  color: Color(0xFFEEEEEE),
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: Image.network(
                                      'https://www.pngkey.com/png/detail/1010-10107790_kathi-online-avatar-maker.png',
                                    ).image,
                                  ),
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: Color(0xFF00FFF9),
                                    width: 2,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              width: 45,
                              height: 45,
                              decoration: BoxDecoration(
                                color: Color(0xFF00827F),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Align(
                                alignment: AlignmentDirectional(0, 0),
                                child: Icon(
                                  Icons.notifications_outlined,
                                  color: Color(0xFFF3F4F4),
                                  size: 24,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(12, 75, 0, 0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.pageTitle,
                      textAlign: TextAlign.start,
                      style: FlutterFlowTheme.of(context).bodyText1.override(
                            fontFamily: 'Open Sans',
                            color: Color(0xFFF3F4F4),
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    Text(
                      widget.service.name,
                      style: FlutterFlowTheme.of(context).bodyText1.override(
                            fontFamily: 'Open Sans',
                            color: Color(0xFFF3F4F4),
                            fontSize: 20,
                            fontWeight: FontWeight.w300,
                          ),
                    ),
                  ],
                ),
              ),
              Align(
                alignment: AlignmentDirectional(0, 1),
                child: Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.77,
                  decoration: BoxDecoration(
                    color: Color(0xFFEDF3F3),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(0),
                      bottomRight: Radius.circular(0),
                      topLeft: Radius.circular(36),
                      topRight: Radius.circular(36),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(12, 16, 12, 0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        // TextFormField(
                        //   controller: textController1,
                        //   obscureText: false,
                        //   decoration: InputDecoration(
                        //     labelText: 'Patient Name',
                        //     labelStyle:
                        //         FlutterFlowTheme.of(context).bodyText1.override(
                        //               fontFamily: 'Open Sans',
                        //               color: Color(0xFF9A9A9A),
                        //               fontSize: 16,
                        //             ),
                        //     hintText: '[Some hint text...]',
                        //     enabledBorder: OutlineInputBorder(
                        //       borderSide: BorderSide(
                        //         color: Color(0x00000000),
                        //         width: 1,
                        //       ),
                        //       borderRadius: BorderRadius.circular(12),
                        //     ),
                        //     focusedBorder: OutlineInputBorder(
                        //       borderSide: BorderSide(
                        //         color: Color(0x00000000),
                        //         width: 1,
                        //       ),
                        //       borderRadius: BorderRadius.circular(12),
                        //     ),
                        //     filled: true,
                        //     fillColor: Colors.white,
                        //   ),
                        //   style:
                        //       FlutterFlowTheme.of(context).bodyText1.override(
                        //             fontFamily: 'Open Sans',
                        //             color: Color(0xFF606E87),
                        //             fontSize: 18,
                        //           ),
                        // ),
                        DropdownButtonHideUnderline(
                          child: DropdownButtonFormField(
                            items: patientNames,
                            value: _selectedPatientId,
                            onChanged: (value) {
                              setState(() {
                                _selectedPatientId = value;
                              });
                            },
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Color(0x00000000),
                              labelText: 'Patient Name',
                              // border:
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
                          child: TextFormField(
                            controller: textController2,
                            obscureText: false,
                            decoration: InputDecoration(
                              hintText: 'Tell me about your health problem',
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0x00000000),
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0x00000000),
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              filled: true,
                              fillColor: Colors.white,
                            ),
                            style:
                                FlutterFlowTheme.of(context).bodyText1.override(
                                      fontFamily: 'Poppins',
                                      color: Color(0xFF606E87),
                                    ),
                            maxLines: 5,
                          ),
                        ),
                        Align(
                          alignment: AlignmentDirectional(-1, 0),
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
                            child: Text(
                              'Do you want to select your doctor?',
                              style: FlutterFlowTheme.of(context)
                                  .bodyText1
                                  .override(
                                    fontFamily: 'Open Sans',
                                    color: Color(0xFF606E87),
                                    fontSize: 20,
                                  ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 8, 0, 4),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Expanded(
                                child: FlutterFlowRadioButton(
                                  options: [
                                    'Yes',
                                    'Help me with available doctor'
                                  ],
                                  onChanged: (value) {
                                    setState(() => radioButtonValue = value);
                                    if (radioButtonValue == 'Yes') {
                                      ref
                                          .read(_doctorsProvider)
                                          .fetchAllDoctors(
                                              serviceId: widget.service.id);
                                    }
                                  },
                                  optionHeight: 25,
                                  textStyle: FlutterFlowTheme.of(context)
                                      .bodyText1
                                      .override(
                                        fontFamily: 'Poppins',
                                        color: Colors.black,
                                      ),
                                  selectedTextStyle:
                                      FlutterFlowTheme.of(context)
                                          .bodyText1
                                          .override(
                                            fontFamily: 'Open Sans',
                                            color: Color(0xFF606E87),
                                          ),
                                  buttonPosition: RadioButtonPosition.left,
                                  direction: Axis.horizontal,
                                  radioButtonColor: Color(0xFF00A8A3),
                                  inactiveRadioButtonColor: Colors.white,
                                  toggleable: false,
                                  horizontalAlignment: WrapAlignment.start,
                                  verticalAlignment: WrapCrossAlignment.start,
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (radioButtonValue == 'Yes')
                          Expanded(
                            child: Consumer(
                              builder: (context, ref, child) {
                                DoctorRecordProvider _docRecords =
                                    ref.watch(_doctorsProvider);
                                if (_docRecords.isLoading) {
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                } else {
                                  return DoctorCardListView(
                                    doctors: _docRecords.doctors,
                                  );
                                }
                              },
                            ),
                          ),
                        if (radioButtonValue != 'Yes') Spacer(),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 18),
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.7,
                            height: 55,
                            // padding: EdgeInsets.only(bottom: 12),
                            decoration: BoxDecoration(
                              color: Color(0xFF00A8A3),
                              borderRadius: BorderRadius.circular(18),
                            ),
                            child: InkWell(
                                onTap: () {
                                  if (textController2.text.isEmpty) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            content: Text(
                                                'Please enter patient\'s symptomps')));
                                  } else if (radioButtonValue == null) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            content: Text(
                                                'Please select a doctor option')));
                                  } else if (radioButtonValue == 'Yes' &&
                                      _selectedDoctor == null) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            content: Text(
                                                'Please select a doctor')));
                                  } else {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                TimeSlotScreenWidget(
                                                  symptopms:
                                                      textController2.text,
                                                  service: widget.service,
                                                  patientId: _selectedPatientId,
                                                  isUniversalTimeSlot:
                                                      radioButtonValue != 'Yes',
                                                  doctor: _selectedDoctor,
                                                )));
                                  }
                                },
                                child: NextIconButtonWidget()),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DoctorCardListView extends StatefulWidget {
  final List<Doctor> doctors;
  const DoctorCardListView({Key key, @required this.doctors}) : super(key: key);

  @override
  State<DoctorCardListView> createState() => _DoctorCardListViewState();
}

class _DoctorCardListViewState extends State<DoctorCardListView> {
  int _selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        itemCount: widget.doctors.length,
        itemBuilder: (_, int index) => GestureDetector(
              onTap: () {
                setState(() {
                  _selectedIndex = index;
                  _selectedDoctor = widget.doctors[index];
                });
              },
              child: DoctorCard(
                isSelected: _selectedIndex == index,
                doctor: widget.doctors[index],
              ),
            ));
  }
}

class DoctorCard extends StatelessWidget {
  final bool isSelected;
  final Doctor doctor;

  const DoctorCard({Key key, @required this.doctor, @required this.isSelected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 4),
      width: double.maxFinite,
      decoration: BoxDecoration(
        color: Color(0xFFEEEEEE),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isSelected ? Color(0xFF00A8A3) : Colors.white,
        ),
      ),
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(
                doctor.profilePic.isEmpty
                    ? 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR0kigo369AKCLUVSYPBs4K54t0WQbsfL9Lmw&usqp=CAU'
                    : doctor.profilePic,
                width: 60,
                height: 60,
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                      child: Text(
                        doctor.name,
                        style: FlutterFlowTheme.of(context).bodyText1.override(
                              fontFamily: 'Open Sans',
                              color: Color(0xFF606E87),
                              fontSize: 16,
                            ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 6, 0, 0),
                      child: Text(
                        doctor.designation,
                        style: FlutterFlowTheme.of(context).bodyText1.override(
                              fontFamily: 'Open Sans',
                              color: Color(0xFF606E87),
                              fontSize: 14,
                            ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
