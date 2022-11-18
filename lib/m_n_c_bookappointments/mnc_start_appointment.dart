import 'dart:convert';

import 'package:dhanva_mobile_app/global/models/doctor.dart';
import 'package:dhanva_mobile_app/global/models/patient.dart';
import 'package:dhanva_mobile_app/global/models/patient_relation.dart';

import 'package:dhanva_mobile_app/global/services/api_services/api_service_base.dart';
import 'package:flutter_svg/svg.dart';

import '../app_guide_screen2/app_guide_screen2_widget.dart';
import '../flutter_flow/flutter_flow_radio_button.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dhanva_mobile_app/components/notification_icon_button.dart';
import 'package:dio/dio.dart';
import '../global/models/patient.dart';
import '../global/models/patient_relation.dart';
import '../global/services/shared_preference_service.dart';
import 'mnc_bookdoctor_screen.dart';

class MncStartAppointmentWidget extends StatefulWidget {
  const MncStartAppointmentWidget({
    Key key,
  }) : super(key: key);

  @override
  _MncStartAppointmentWidgetState createState() =>
      _MncStartAppointmentWidgetState();
}

class MyCustomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(size.width * 0.5, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.lineTo(size.width * 0.5, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) {
    return false;
  }
}

class _MncStartAppointmentWidgetState extends State<MncStartAppointmentWidget> {
  String dropDownValue;
  String radioButtonValue1;
  String shapes;
  List<String> _intervals = [];
  List<DropdownMenuItem<String>> patientNames = [];
  String _selectedPatientId;
  List<PatientRelation> _relations = [];
  String patientRelationType = "Self";
  Patient patient;
  TextEditingController textController1;
  String radioButtonValue2;
  TextEditingController textController2;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  // String planType;
  // List<String> _planTypes = [
  //   '30 days  ₹599',
  //   '60 days  ₹1299',
  //   '90 days  ₹2199',
  // ];
  Map<String, dynamic> data = {};

  @override
  void initState() {
    super.initState();
    // textController1 = TextEditingController(text: '  JAMES HEMSWORTH');
    textController2 = TextEditingController();
    // _sendAppointmentDetails();
    patient = Patient.fromJson(
        jsonDecode(SharedPreferenceService.loadString(key: PatientKey)));
    patientNames.add(DropdownMenuItem(
      child: Text(patient.name),
      value: patient.id,
    ));
    _selectedPatientId = patient.id;
    _loadIntervals();
    _loadRelations();
    _loadPaymentDetails();
    data["patient_id"] = _selectedPatientId;
  }

  // Future<void> _sendAppointmentDetails() async {
  //   Response res = await ApiService.dio.post(
  //       "${ApiService.protocol}${ApiService.baseUrl2}/mnc/shapes",
  //       options: Options(headers: {
  //         'Authorization': SharedPreferenceService.loadString(key: AuthTokenKey)
  //       }),
  //       data: {
  //         "shape": shapes,
  //         "healthRating": radioButtonValue1,
  //         "checkupFrequency": radioButtonValue2,
  //         "patient_id": patient.id,
  //         "name": patient.name,
  //       });
  // }

  Future<void> _loadIntervals() async {
    //print("${ApiService.protocol}${ApiService.baseUrl2}mnc/checkup-intervals");
    Response res = await ApiService.dio.get(
        "${ApiService.protocol}${ApiService.baseUrl2}mnc/checkup-intervals",
        options: Options(headers: {
          'Authorization': SharedPreferenceService.loadString(key: AuthTokenKey)
        }));
    (res.data as List).forEach(
      (element) => _intervals.add(element),
    );
    setState(() {
      //
    });
  }

  void _loadRelations() async {
    String pid = Patient.fromJson(
            jsonDecode(SharedPreferenceService.loadString(key: PatientKey)))
        .id;
    Response res = await ApiService.dio.get(
        '${ApiService.protocol}${ApiService.baseUrl2}patient/getPatientRelations/$pid',
        options: Options(headers: {
          'Authorization': SharedPreferenceService.loadString(key: AuthTokenKey)
        }));
    print(res.data);
    _relations =
        (res.data as List).map((e) => PatientRelation.fromJson(e)).toList();
    // print(relations);
    for (PatientRelation relation in _relations) {
      patientNames.add(DropdownMenuItem(
        child: Text(relation.patientName),
        value: relation.patientId,
      ));
    }
    setState(() {
      // updateUI
    });
  }

  Future<void> _loadPaymentDetails() async {
    Response res = await ApiService.dio.get(
        "${ApiService.protocol}${ApiService.baseUrl2}mnc/assessment-service",
        options: Options(headers: {
          'Authorization': SharedPreferenceService.loadString(key: AuthTokenKey)
        }));

    data["amount"] = res.data["amount"];
    data["name"] = res.data["name"];
    print("load payment service info${res.data}");
  }

  @override
  void dispose() {
    textController1?.dispose();
    textController2?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Color(0xFF00A8A3),
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Stack(children: [
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.5,
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
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () async {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.arrow_back_rounded,
                      color: Colors.white,
                      size: 34,
                    ),
                  ),
                  // Expanded(
                  //   child: Row(
                  //     mainAxisSize: MainAxisSize.max,
                  //     mainAxisAlignment: MainAxisAlignment.end,
                  //     // children: [
                  //     //   //
                  //     //   NotificationIconButton()
                  //     // ],
                  //   ),
                  // ),
                ],
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
                    'Start Booking',
                    textAlign: TextAlign.start,
                    style: FlutterFlowTheme.of(context).bodyText1.override(
                          fontFamily: 'Open Sans',
                          color: Color(0xFFF3F4F4),
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  Text(
                    'MNC Appointment',
                    style: FlutterFlowTheme.of(context).bodyText1.override(
                          fontFamily: 'Open Sans',
                          color: Color(0xFFF3F4F4),
                          fontSize: 16,
                          fontWeight: FontWeight.w300,
                        ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: AlignmentDirectional(0, 1),
              //  alignment: AlignmentDirectional(0, 2),
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
                child: Align(
                  alignment: AlignmentDirectional(-0.1, 0),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 22, 0, 0),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          DropdownButtonHideUnderline(
                            child: DropdownButtonFormField(
                              items: patientNames,
                              value: _selectedPatientId,
                              onChanged: (value) {
                                data["patient_id"] = _selectedPatientId;
                                setState(() {
                                  _selectedPatientId = value;
                                });
                                Map<String, dynamic> _patientJson = jsonDecode(
                                    SharedPreferenceService.loadString(
                                        key: PatientKey));
                                int idx = _relations.indexWhere((element) =>
                                    _selectedPatientId == element.patientId);
                                patientRelationType =
                                    idx == -1 ? "Self" : _relations[idx].type;
                                // if (_selectedPatientId == patient.id) {
                                //   data["patient_name"] = patient.name;
                                // } else {
                                //   data["patient_name"] = _relations
                                //       .firstWhere((element) =>
                                //           _selectedPatientId == element.id)
                                //       .patientName;
                                // }

                                // print(patientRelationType);
                                // print(data["patient_name"]);
                                // print(_selectedPatientId);
                              },
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Color(0x00000000),
                                labelText: 'Patient Name',
                                // border:
                              ),
                            ),
                          ),
                          // Align(
                          //   alignment: AlignmentDirectional(-0.35, 1),
                          //   child: Padding(
                          //     padding:
                          //         EdgeInsetsDirectional.fromSTEB(5, 38, 5, 0),
                          //     child: Container(
                          //       width: double.infinity,
                          //       child: TextFormField(
                          //         controller: textController1,
                          //         autofocus: true,
                          //         obscureText: false,
                          //         decoration: InputDecoration(
                          //           labelText: 'Patient Name',
                          //           hintStyle:
                          //               FlutterFlowTheme.of(context).bodyText2,
                          //           enabledBorder: OutlineInputBorder(
                          //             borderSide: BorderSide(
                          //               color: Color(0xFFC1C1C1),
                          //               width: 2,
                          //             ),
                          //             borderRadius: BorderRadius.circular(15),
                          //           ),
                          //           focusedBorder: OutlineInputBorder(
                          //             borderSide: BorderSide(
                          //               color: Color(0xFFC1C1C1),
                          //               width: 2,
                          //             ),
                          //             borderRadius: BorderRadius.circular(15),
                          //           ),
                          //           errorBorder: OutlineInputBorder(
                          //             borderSide: BorderSide(
                          //               color: Color(0x00000000),
                          //               width: 2,
                          //             ),
                          //             borderRadius: BorderRadius.circular(15),
                          //           ),
                          //           focusedErrorBorder: OutlineInputBorder(
                          //             borderSide: BorderSide(
                          //               color: Color(0x00000000),
                          //               width: 2,
                          //             ),
                          //             borderRadius: BorderRadius.circular(15),
                          //           ),
                          //         ),
                          //         style: FlutterFlowTheme.of(context)
                          //             .bodyText1
                          //             .override(
                          //               fontFamily: 'Open Sans',
                          //               color: Color(0xFF606E87),
                          //             ),
                          //         textAlign: TextAlign.start,
                          //       ),
                          //     ),
                          //   ),
                          // ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(5, 2, 0, 0),
                            child: Text(
                              'MNC Pre Assessment',
                              style: FlutterFlowTheme.of(context)
                                  .bodyText1
                                  .override(
                                    fontFamily: 'Open Sans',
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF606E87),
                                  ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(5, 0, 0, 0),
                            child: Text(
                              'Please choose the shape',
                              style: FlutterFlowTheme.of(context)
                                  .bodyText1
                                  .override(
                                    fontFamily: 'Open Sans',
                                    color: Color(0xFF070000),
                                    fontWeight: FontWeight.normal,
                                  ),
                            ),
                          ),
                          // Row(
                          //   mainAxisSize: MainAxisSize.max,
                          //   children: [
                          //     Align(
                          //       alignment: AlignmentDirectional(0, 0),
                          //       child: Image.asset(
                          //         'assets/images/circle-removebg-preview.png',
                          //         width: 75,
                          //         height: 75,
                          //         fit: BoxFit.cover,
                          //       ),
                          //     ),
                          //     Image.asset(
                          //       'assets/images/triangle-removebg-preview.png',
                          //       width: 75,
                          //       height: 75,
                          //       fit: BoxFit.cover,
                          //     ),
                          //     Image.asset(
                          //       'assets/images/square-removebg-preview.png',
                          //       width: 75,
                          //       height: 75,
                          //       fit: BoxFit.cover,
                          //     ),
                          //   ],
                          // ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(60, 8, 5, 0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      5, 0, 5, 0),
                                  child: InkWell(
                                    child: Container(
                                      width: 60,
                                      height: 60,
                                      decoration: BoxDecoration(
                                          color: shapes == "Ellipse"
                                              ? Colors.transparent
                                              : Color(0xFF00A8A3),
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          shape: BoxShape.rectangle,
                                          border: Border.all(
                                            color: shapes == "Ellipse"
                                                ? Color(0xFF00A8A3)
                                                : Colors.transparent,
                                            width: 2,
                                          )),
                                    ),
                                    onTap: () {
                                      data["shapes"] = "Ellipse";
                                      setState(() {
                                        shapes = "Ellipse";
                                      });
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 0, 5, 0),
                                  child: InkWell(
                                    onTap: () {
                                      data["shapes"] = "Triangle";
                                      setState(() {
                                        shapes = "Triangle";
                                      });
                                    },
                                    child: SvgPicture.asset(
                                      shapes == "Triangle"
                                          ? "assets/images/triangleborder.svg"
                                          : "assets/images/trianglefilled.svg",
                                      width: 70,
                                      height: 60,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      10, 0, 5, 0),
                                  child: GestureDetector(
                                    child: Container(
                                      width: 60,
                                      height: 60,
                                      decoration: BoxDecoration(
                                        color: shapes == "Rectangle"
                                            ? Colors.transparent
                                            : Color(0xFF00A8A3),
                                        borderRadius: BorderRadius.circular(0),
                                        shape: BoxShape.rectangle,
                                        border: Border.all(
                                          color: shapes == "Rectangle"
                                              ? Color(0xFF00A8A3)
                                              : Colors.transparent,
                                          width: 2,
                                        ),
                                      ),
                                    ),
                                    onTap: () {
                                      data["shapes"] = "Rectangle";
                                      setState(() {
                                        shapes = "Rectangle";
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(5, 5, 0, 0),
                            child: Text(
                              '1. How healthy do you consider yourself on a scale of 1 to 10?',
                              style: FlutterFlowTheme.of(context)
                                  .bodyText1
                                  .override(
                                    fontFamily: 'Open Sans',
                                    color: Color(0xFF070000),
                                    fontWeight: FontWeight.normal,
                                  ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(0, 2, 0, 0),
                            child: FlutterFlowRadioButton(
                              options: [
                                '1',
                                '2',
                                '3',
                                '4',
                                '5',
                                '6',
                                '7',
                                '8',
                                '9',
                                '10',
                              ],
                              onChanged: (value) {
                                data["healthRating"] = value;

                                setState(() => radioButtonValue1 = value);
                              },
                              optionHeight: 25,
                              textStyle: FlutterFlowTheme.of(context)
                                  .bodyText1
                                  .override(
                                    fontFamily: 'Poppins',
                                    color: Colors.black,
                                  ),
                              textPadding:
                                  EdgeInsetsDirectional.fromSTEB(4, 0, 16, 0),
                              buttonPosition: RadioButtonPosition.left,
                              direction: Axis.horizontal,
                              radioButtonColor: Color(0xFF00A8A3),
                              inactiveRadioButtonColor: Color(0x8A000000),
                              toggleable: false,
                              horizontalAlignment: WrapAlignment.spaceEvenly,
                              verticalAlignment: WrapCrossAlignment.start,
                            ),
                          ),
                          // Padding(
                          //   padding: EdgeInsetsDirectional.fromSTEB(5, 3, 0, 0),
                          //   child: Text(
                          //     '2. How often do you get a health checkup?',
                          //     style: FlutterFlowTheme.of(context)
                          //         .bodyText1
                          //         .override(
                          //           fontFamily: 'Open Sans',
                          //           color: Color(0xFF070000),
                          //           fontWeight: FontWeight.normal,
                          //         ),
                          //   ),
                          // ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(5, 12, 0, 0),
                            child: Text(
                              '2. How often  do you get a health checkup?',
                              style: FlutterFlowTheme.of(context).bodyText1,
                            ),
                          ),
                          FlutterFlowRadioButton(
                            options: _intervals,
                            onChanged: (value) {
                              data["checkupFrequency"] = value;
                              setState(() => radioButtonValue2 = value);
                            },
                            optionHeight: 35,
                            textStyle:
                                FlutterFlowTheme.of(context).bodyText1.override(
                                      fontFamily: 'Poppins',
                                      color: Colors.black,
                                    ),
                            buttonPosition: RadioButtonPosition.left,
                            direction: Axis.vertical,
                            radioButtonColor: Color(0xFF00A8A3),
                            inactiveRadioButtonColor: Color(0x8A000000),
                            toggleable: false,
                            horizontalAlignment: WrapAlignment.start,
                            verticalAlignment: WrapCrossAlignment.start,
                          ),
                          // Padding(
                          //   padding:
                          //       EdgeInsetsDirectional.fromSTEB(5, 12, 0, 0),
                          //   child: Text(
                          //     '3. Please enter your goal over MNC',
                          //     style: FlutterFlowTheme.of(context)
                          //         .bodyText1
                          //         .override(
                          //           fontFamily: 'Open Sans',
                          //           color: Color(0xFF070000),
                          //           fontWeight: FontWeight.normal,
                          //         ),
                          //   ),
                          // ),
                          // Align(
                          //   alignment: AlignmentDirectional(-0.35, 1),
                          //   child: Padding(
                          //     padding:
                          //         EdgeInsetsDirectional.fromSTEB(5, 3, 5, 0),
                          //     child: Container(
                          //       width: double.infinity,
                          //       child: TextFormField(
                          //         controller: textController2,
                          //         autofocus: true,
                          //         obscureText: false,
                          //         decoration: InputDecoration(
                          //           hintText: '  Enter you goal...',
                          //           hintStyle:
                          //               FlutterFlowTheme.of(context).bodyText2,
                          //           enabledBorder: OutlineInputBorder(
                          //             borderSide: BorderSide(
                          //               color: Color(0xFFC1C1C1),
                          //               width: 2,
                          //             ),
                          //             borderRadius: BorderRadius.circular(15),
                          //           ),
                          //           focusedBorder: OutlineInputBorder(
                          //             borderSide: BorderSide(
                          //               color: Color(0xFFC1C1C1),
                          //               width: 2,
                          //             ),
                          //             borderRadius: BorderRadius.circular(15),
                          //           ),
                          //           errorBorder: OutlineInputBorder(
                          //             borderSide: BorderSide(
                          //               color: Color(0x00000000),
                          //               width: 2,
                          //             ),
                          //             borderRadius: BorderRadius.circular(15),
                          //           ),
                          //           focusedErrorBorder: OutlineInputBorder(
                          //             borderSide: BorderSide(
                          //               color: Color(0x00000000),
                          //               width: 2,
                          //             ),
                          //             borderRadius: BorderRadius.circular(15),
                          //           ),
                          //         ),
                          //         style: FlutterFlowTheme.of(context)
                          //             .bodyText1
                          //             .override(
                          //               fontFamily: 'Open Sans',
                          //               color: Color(0xFF606E87),
                          //               fontWeight: FontWeight.normal,
                          //             ),
                          //         textAlign: TextAlign.start,
                          //       ),
                          //     ),
                          //   ),
                          // ),
                          // Padding(
                          //   padding:
                          //       EdgeInsetsDirectional.fromSTEB(5, 12, 0, 0),
                          //   child: Text(
                          //     '3. Please select your subscription period ',
                          //     style: FlutterFlowTheme.of(context)
                          //         .bodyText1
                          //         .override(
                          //           fontFamily: 'Open Sans',
                          //           color: Color(0xFF070000),
                          //           fontWeight: FontWeight.normal,
                          //         ),
                          //   ),
                          // ),
                          // Align(
                          //     alignment: AlignmentDirectional(-0.85, 0),
                          //     child: Padding(
                          //       padding:
                          //           EdgeInsetsDirectional.fromSTEB(5, 5, 5, 0),
                          //       child: DropdownButtonFormField(
                          //         validator: (String type) {
                          //           if (type.isEmpty || type == null)
                          //             return 'plan type Required';
                          //           return null;
                          //         },
                          //         decoration: InputDecoration(
                          //           border: OutlineInputBorder(
                          //             borderSide: BorderSide(color: Colors.red),
                          //             borderRadius: const BorderRadius.all(
                          //               const Radius.circular(20),
                          //             ),
                          //           ),
                          //           filled: true,
                          //           hintStyle: TextStyle(
                          //             color: Color(0xFF9A9A9A),
                          //           ),
                          //           hintText: "Select the plan type",
                          //           fillColor: Color(0xFFEDF3F3),
                          //         ),
                          //         value: planType,
                          //         items: _planTypes
                          //             .map((type) => DropdownMenuItem(
                          //                   child: Text(type),
                          //                   value: type,
                          //                 ))
                          //             .toList(),
                          //         onChanged: (value) {
                          //           setState(() {
                          //             planType = value;
                          //             print("Plan type on select: $planType");
                          //           });
                          //         },
                          //         iconEnabledColor: Color(0xFF606E87),
                          //         iconDisabledColor: Color(0xFF606E87),
                          //       ),
                          //     )),

                          // Align(
                          //   alignment: AlignmentDirectional(-0.85, 0),
                          //   child: Padding(
                          //     padding: EdgeInsetsDirectional.fromSTEB(
                          //         5, 2, 0, 0),
                          //     child: FlutterFlowDropDown(
                          //       options: [
                          //         '30 days                     ₹599',
                          //         '60 days                  ₹1299',
                          //         '90 days                 ₹2199'
                          //       ],
                          //       onChanged: (val) =>
                          //           setState(() => dropDownValue = val),
                          //       width: 180,
                          //       height: 50,
                          //       textStyle: FlutterFlowTheme.of(context)
                          //           .bodyText1
                          //           .override(
                          //             fontFamily: 'Open Sans',
                          //             color: Colors.black,
                          //             fontWeight: FontWeight.normal,
                          //           ),
                          //       hintText: 'Select your plan',
                          //       fillColor: Colors.white,
                          //       elevation: 2,
                          //       borderColor: Color(0xFFC1C1C1),
                          //       borderWidth: 0,
                          //       borderRadius: 0,
                          //       margin: EdgeInsetsDirectional.fromSTEB(
                          //           12, 4, 12, 4),
                          //       hidesUnderline: true,
                          //     ),
                          //   ),
                          // ),
                          Align(
                            alignment: AlignmentDirectional(-0.05, 0),
                            child: Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 20, 0, 50),
                              child: FFButtonWidget(
                                onPressed: () {
                                  if (radioButtonValue1 == null ||
                                      radioButtonValue1.isEmpty) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            content: Text(
                                                'Please Fill all fields')));
                                  } else if (radioButtonValue2 == null ||
                                      radioButtonValue2.isEmpty) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            content: Text(
                                                'Please select the intervals')));
                                    // }
                                    // else if (radioButtonValue == 'Yes' &&
                                    //     _selectedDoctor == null) {
                                    //   ScaffoldMessenger.of(context).showSnackBar(
                                    //       SnackBar(
                                    //           content: Text(
                                    //               'Please select a doctor')));
                                  } else if (shapes == null) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            content:
                                                Text('Please choose a shape')));
                                    // }
                                  } else {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              mnc_bookdoctor_screen(
                                            data: data,
                                          ),
                                        ));
                                  }
                                },
                                text: 'Next',
                                options: FFButtonOptions(
                                  width: 130,
                                  height: 40,
                                  color: Color(0xFF00A8A3),
                                  textStyle: FlutterFlowTheme.of(context)
                                      .subtitle2
                                      .override(
                                        fontFamily: 'Open Sans',
                                        color: Color(0xFFF3F4F4),
                                        fontSize: 18,
                                      ),
                                  borderSide: BorderSide(
                                    color: Colors.transparent,
                                    width: 1,
                                  ),
                                  borderRadius: 8,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
