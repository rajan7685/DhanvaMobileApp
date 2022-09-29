import '../flutter_flow/flutter_flow_radio_button.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class HvtScreen1Widget extends StatefulWidget {
  const HvtScreen1Widget({Key key}) : super(key: key);

  @override
  _HvtScreen1WidgetState createState() => _HvtScreen1WidgetState();
}

class _HvtScreen1WidgetState extends State<HvtScreen1Widget> {
  String dropDownValue;
  String radioButtonValue1;
  String planType;
  List<String> _planTypes = [
    '30 days  ₹599',
    '60 days  ₹1299',
    '60 days  ₹1299',
  ];
  TextEditingController textController1;
  String radioButtonValue2;
  TextEditingController textController2;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    textController1 = TextEditingController();
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
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Align(
                    alignment: AlignmentDirectional(-1, -0.65),
                    child: Icon(
                      Icons.keyboard_backspace,
                      color: FlutterFlowTheme.of(context).primaryBackground,
                      size: 39,
                    ),
                  ),
                  Expanded(
                    child: Align(
                      alignment: AlignmentDirectional(0.9, -0.65),
                      child: FaIcon(
                        FontAwesomeIcons.solidBell,
                        color: FlutterFlowTheme.of(context).primaryBackground,
                        size: 30,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(3, 0, 0, 0),
                    child: Text(
                      'Start Booking',
                      style: FlutterFlowTheme.of(context).bodyText1.override(
                            fontFamily: 'Open Sans',
                            color: Color(0xFFF3F4F4),
                            fontSize: 33,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(4, 0, 0, 0),
                    child: Text(
                      'HVT Appointment',
                      style: FlutterFlowTheme.of(context).bodyText1.override(
                            fontFamily: 'Open Sans',
                            color: Color(0xFFF3F4F4),
                            fontSize: 18,
                            fontWeight: FontWeight.normal,
                          ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                  child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    decoration: BoxDecoration(
                      color: Color(0xFFEDF3F3),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(0),
                        bottomRight: Radius.circular(0),
                        topLeft: Radius.circular(55),
                        topRight: Radius.circular(55),
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
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      5, 38, 5, 0),
                                  child: Container(
                                    width: double.infinity,
                                    child: TextFormField(
                                      controller: textController1,
                                      autofocus: true,
                                      obscureText: false,
                                      decoration: InputDecoration(
                                        labelText: 'Patient Name',
                                        hintText: '  Enter patient Name',
                                        hintStyle: FlutterFlowTheme.of(context)
                                            .bodyText2,
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Color(0xFFC1C1C1),
                                            width: 2,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Color(0xFFC1C1C1),
                                            width: 2,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        errorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Color(0x00000000),
                                            width: 2,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        focusedErrorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Color(0x00000000),
                                            width: 2,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(15),
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
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(5, 2, 0, 0),
                                child: Text(
                                  'Pre Assessment Questinnarie',
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
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(5, 0, 0, 0),
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
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Align(
                                    alignment: AlignmentDirectional(0, 0),
                                    child: Image.asset(
                                      'assets/images/circle-removebg-preview.png',
                                      width: 75,
                                      height: 75,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Image.asset(
                                    'assets/images/triangle-removebg-preview.png',
                                    width: 75,
                                    height: 75,
                                    fit: BoxFit.cover,
                                  ),
                                  Image.asset(
                                    'assets/images/square-removebg-preview.png',
                                    width: 75,
                                    height: 75,
                                    fit: BoxFit.cover,
                                  ),
                                ],
                              ),
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(5, 0, 0, 0),
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
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(8, 3, 0, 0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Align(
                                      alignment:
                                          AlignmentDirectional(0.05, 0.1),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0, 0, 20, 0),
                                        child: FlutterFlowRadioButton(
                                          options: ['1', '2', '3', '4', '5']
                                              .toList(),
                                          onChanged: (value) {
                                            setState(() =>
                                                radioButtonValue1 = value);
                                          },
                                          optionHeight: 25,
                                          textStyle:
                                              FlutterFlowTheme.of(context)
                                                  .bodyText1
                                                  .override(
                                                    fontFamily: 'Open Sans',
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                  ),
                                          selectedTextStyle:
                                              FlutterFlowTheme.of(context)
                                                  .bodyText1
                                                  .override(
                                                    fontFamily: 'Open Sans',
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                          buttonPosition:
                                              RadioButtonPosition.right,
                                          direction: Axis.horizontal,
                                          radioButtonColor: Color(0xFF070000),
                                          inactiveRadioButtonColor:
                                              Color(0x8A000000),
                                          toggleable: false,
                                          horizontalAlignment:
                                              WrapAlignment.start,
                                          verticalAlignment:
                                              WrapCrossAlignment.start,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(5, 3, 0, 0),
                                child: Text(
                                  '2. How often do you get a health checkup?',
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
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(30, 3, 0, 0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 0, 11, 0),
                                      child: FlutterFlowRadioButton(
                                        options: [
                                          'Once in Months',
                                          'Once a year',
                                          'On When needed',
                                          'Never get it done'
                                        ].toList(),
                                        onChanged: (value) {
                                          setState(
                                              () => radioButtonValue2 = value);
                                        },
                                        optionHeight: 25,
                                        textStyle: FlutterFlowTheme.of(context)
                                            .bodyText1
                                            .override(
                                              fontFamily: 'Open Sans',
                                              color: Colors.black,
                                              fontWeight: FontWeight.normal,
                                            ),
                                        selectedTextStyle:
                                            FlutterFlowTheme.of(context)
                                                .bodyText1
                                                .override(
                                                  fontFamily: 'Open Sans',
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                        buttonPosition:
                                            RadioButtonPosition.left,
                                        direction: Axis.vertical,
                                        radioButtonColor: Color(0xFF070000),
                                        inactiveRadioButtonColor:
                                            Color(0x8A000000),
                                        toggleable: false,
                                        horizontalAlignment:
                                            WrapAlignment.start,
                                        verticalAlignment:
                                            WrapCrossAlignment.start,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(5, 3, 0, 0),
                                child: Text(
                                  '3. Please enter your goal over HVT',
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
                                alignment: AlignmentDirectional(-0.35, 1),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      5, 3, 5, 0),
                                  child: Container(
                                    width: double.infinity,
                                    child: TextFormField(
                                      controller: textController2,
                                      autofocus: true,
                                      obscureText: false,
                                      decoration: InputDecoration(
                                        hintText: '  Enter you goal...',
                                        hintStyle: FlutterFlowTheme.of(context)
                                            .bodyText2,
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Color(0xFFC1C1C1),
                                            width: 2,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Color(0xFFC1C1C1),
                                            width: 2,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        errorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Color(0x00000000),
                                            width: 2,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        focusedErrorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Color(0x00000000),
                                            width: 2,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                      ),
                                      style: FlutterFlowTheme.of(context)
                                          .bodyText1
                                          .override(
                                            fontFamily: 'Open Sans',
                                            color: Color(0xFF606E87),
                                            fontWeight: FontWeight.normal,
                                          ),
                                      textAlign: TextAlign.start,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(5, 3, 0, 0),
                                child: Text(
                                  '4. Please select your subscription period ',
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
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        5, 2, 0, 0),
                                    child: DropdownButtonFormField(
                                      validator: (String type) {
                                        if (type == null)
                                          return 'plan type Required';
                                        return null;
                                      },
                                      decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                            borderSide:
                                                BorderSide(color: Colors.red),
                                            borderRadius:
                                                const BorderRadius.all(
                                              const Radius.circular(26),
                                            ),
                                          ),
                                          filled: true,
                                          hintStyle: TextStyle(
                                            color: Color(0xFF9A9A9A),
                                          ),
                                          hintText: "Select the plan type",
                                          fillColor: Colors.white),
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
                                          print(
                                              "Plan type on select: $planType");
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
                                alignment: AlignmentDirectional(-0.15, 0),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 24, 0, 0),
                                  child: FFButtonWidget(
                                    onPressed: () {
                                      print('Button pressed ...');
                                    },
                                    text: '     Next Slot at 11:00 AM     ',
                                    options: FFButtonOptions(
                                      height: 40,
                                      color: Color(0xFF00A8A3),
                                      textStyle: FlutterFlowTheme.of(context)
                                          .subtitle2
                                          .override(
                                            fontFamily: 'Poppins',
                                            color: Colors.white,
                                            fontWeight: FontWeight.normal,
                                          ),
                                      borderSide: BorderSide(
                                        color: Colors.transparent,
                                        width: 1,
                                      ),
                                      borderRadius: 75,
                                    ),
                                  ),
                                ),
                              ),
                              Align(
                                alignment: AlignmentDirectional(-0.05, 0),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 10, 0, 0),
                                  child: Text(
                                    'Or',
                                    textAlign: TextAlign.center,
                                    style: FlutterFlowTheme.of(context)
                                        .bodyText1
                                        .override(
                                          fontFamily: 'Open Sans',
                                          color: Color(0xFF070000),
                                          fontWeight: FontWeight.w600,
                                        ),
                                  ),
                                ),
                              ),
                              Align(
                                alignment: AlignmentDirectional(-0.15, 0),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 10, 0, 30),
                                  child: FFButtonWidget(
                                    onPressed: () {
                                      print('Button pressed ...');
                                    },
                                    text: '     Next Slot at 11:00 AM     ',
                                    options: FFButtonOptions(
                                      height: 40,
                                      color: Color(0xFFEDF3F3),
                                      textStyle: FlutterFlowTheme.of(context)
                                          .subtitle2
                                          .override(
                                            fontFamily: 'Poppins',
                                            color: Color(0xFF00A8A3),
                                            fontWeight: FontWeight.normal,
                                          ),
                                      borderSide: BorderSide(
                                        color: Color(0xFF00A8A3),
                                        width: 2,
                                      ),
                                      borderRadius: 75,
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}