import '../flutter_flow/flutter_flow_radio_button.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dhanva_mobile_app/components/notification_icon_button.dart';

import 'hvt_bookdoctor_screen.dart';

class HvtStartAppointmentWidget extends StatefulWidget {
  const HvtStartAppointmentWidget({Key key}) : super(key: key);

  @override
  _HvtStartAppointmentWidgetState createState() =>
      _HvtStartAppointmentWidgetState();
}

class MyCustomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(size.width * 0.5, 0);
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

class _HvtStartAppointmentWidgetState extends State<HvtStartAppointmentWidget> {
  String dropDownValue;
  String radioButtonValue1;
  String planType;
  List<String> _planTypes = [
    '30 days  ₹599',
    '60 days  ₹1299',
    '90 days  ₹2199',
  ];
  TextEditingController textController1;
  String radioButtonValue2;
  TextEditingController textController2;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    textController1 = TextEditingController(text: '  JAMES HEMSWORTH');
    textController2 = TextEditingController();
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
                  Expanded(
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        //
                        NotificationIconButton()
                      ],
                    ),
                  ),
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
                    'HVT Appointment',
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
             // alignment: AlignmentDirectional(0, 2),
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
                          Align(
                            alignment: AlignmentDirectional(-0.35, 1),
                            child: Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(5, 38, 5, 0),
                              child: Container(
                                width: double.infinity,
                                child: TextFormField(
                                  controller: textController1,
                                  autofocus: true,
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    labelText: 'Patient Name',
                                    hintStyle:
                                        FlutterFlowTheme.of(context).bodyText2,
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0xFFC1C1C1),
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0xFFC1C1C1),
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0x00000000),
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0x00000000),
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                  ),
                                  style: FlutterFlowTheme.of(context)
                                      .bodyText1
                                      .override(
                                        fontFamily: 'Open Sans',
                                        color: Color(0xFF606E87),
                                      ),
                                  textAlign: TextAlign.start,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(5, 2, 0, 0),
                            child: Text(
                              'HVT Pre Assessment',
                              style: FlutterFlowTheme.of(context)
                                  .bodyText1
                                  .override(
                                    fontFamily: 'Open Sans',
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
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
                                  child: GestureDetector(
                                    child: Container(
                                      width: 60,
                                      height: 60,
                                      decoration: BoxDecoration(
                                        color: Color(0xFF00A8A3),
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        shape: BoxShape.rectangle,
                                      ),
                                    ),
                                    onTap: () {
                                      print('Clicked Circle');
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 0, 5, 0),
                                  child: ClipPath(
                                    clipper: MyCustomClipper(),
                                    child: GestureDetector(
                                      child: Container(
                                        width: 70,
                                        height: 60,
                                        constraints: BoxConstraints(
                                          maxWidth: 300,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Color(0xFF00A8A3),
                                          shape: BoxShape.rectangle,
                                        ),
                                      ),
                                      onTap: () {
                                        print('Clicked Triangle');
                                      },
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
                                        color: Color(0xFF00A8A3),
                                        borderRadius: BorderRadius.circular(0),
                                        shape: BoxShape.rectangle,
                                      ),
                                    ),
                                    onTap: () {
                                      print('Clicked Square');
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
                            options: [
                              'Once in Months',
                              'Once a year',
                              'On when needed',
                              'Never get it done',
                              'Other'
                            ],
                            onChanged: (value) {
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
                          //     '3. Please enter your goal over HVT',
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
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(5, 12, 0, 0),
                            child: Text(
                              '3. Please select your subscription period ',
                              style: FlutterFlowTheme.of(context)
                                  .bodyText1
                                  .override(
                                    fontFamily: 'Open Sans',
                                    color: Color(0xFF070000),
                                    fontWeight: FontWeight.normal,
                                  ),
                            ),
                          ),
                          Align(
                              alignment: AlignmentDirectional(-0.85, 0),
                              child: Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(5, 5, 5, 0),
                                child: DropdownButtonFormField(
                                  validator: (String type) {
                                    if (type.isEmpty || type == null)
                                      return 'plan type Required';
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.red),
                                      borderRadius: const BorderRadius.all(
                                        const Radius.circular(20),
                                      ),
                                    ),
                                    filled: true,
                                    hintStyle: TextStyle(
                                      color: Color(0xFF9A9A9A),
                                    ),
                                    hintText: "Select the plan type",
                                    fillColor: Color(0xFFEDF3F3),
                                  ),
                                  value: planType,
                                  items: _planTypes
                                      .map((type) => DropdownMenuItem(
                                            child: Text(type),
                                            value: type,
                                          ))
                                      .toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      planType = value;
                                      print("Plan type on select: $planType");
                                    });
                                  },
                                  iconEnabledColor: Color(0xFF606E87),
                                  iconDisabledColor: Color(0xFF606E87),
                                ),
                              )),

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
                                                'Please Fill all fields')));
                                    // }
                                    //else if (radioButtonValue == 'Yes' &&
                                    //     _selectedDoctor == null) {
                                    //   ScaffoldMessenger.of(context).showSnackBar(
                                    //       SnackBar(
                                    //           content: Text(
                                    //               'Please select a doctor')));
                                  } else if (planType == null) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            content: Text(
                                                'Please Fill all fields')));
                                    // }
                                  } else {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              hvt_bookdoctor_screen(),
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
