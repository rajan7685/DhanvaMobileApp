import 'package:dhanva_mobile_app/h_v_t_bookappointments/hvt_logs_investigation.dart';

import '../components/next_icon_button_widget.dart';
import '../flutter_flow/flutter_flow_radio_button.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dhanva_mobile_app/components/notification_icon_button.dart';

import 'hvt_timeslot_screen.dart';

class hvt_bookdoctor_screen extends StatefulWidget {
  const hvt_bookdoctor_screen({Key key}) : super(key: key);

  @override
  _hvt_bookdoctor_screenState createState() => _hvt_bookdoctor_screenState();
}

class _hvt_bookdoctor_screenState extends State<hvt_bookdoctor_screen> {
  String radioButtonValue;
  TextEditingController textController;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    textController = TextEditingController();
  }

  @override
  void dispose() {
    textController?.dispose();
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
                    'HVT Doctors',
                    textAlign: TextAlign.start,
                    style: FlutterFlowTheme.of(context).bodyText1.override(
                          fontFamily: 'Open Sans',
                          color: Color(0xFFF3F4F4),
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  Text(
                    'Find your Doctors',
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
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 30, 0, 0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(5, 30, 5, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(5, 0, 0, 0),
                              child: Text(
                                'Please enter your goal over HVT',
                                style: FlutterFlowTheme.of(context)
                                    .bodyText1
                                    .override(
                                      fontFamily: 'Open Sans',
                                      color: Color(0xFF606E87),
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(5, 30, 5, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Expanded(
                              child: Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(5, 0, 5, 0),
                                child: TextFormField(
                                  validator: (String textController) {
                                    if (textController.length < 50)
                                      return 'Must be a valid Text';
                                  },
                                  controller: textController,
                                  autofocus: true,
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    hintText: 'Type your Goal....',
                                    hintStyle:
                                        FlutterFlowTheme.of(context).bodyText2,
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0x00000000),
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0x00000000),
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    errorBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0x00000000),
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    focusedErrorBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0x00000000),
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    filled: true,
                                    fillColor: Colors.white,
                                  ),
                                  style: FlutterFlowTheme.of(context)
                                      .bodyText1
                                      .override(
                                        fontFamily: 'Open Sans',
                                        color: Color(0xFF606E87),
                                      ),
                                  maxLines: 5,
                                  keyboardType: TextInputType.multiline,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(8, 20, 0, 0),
                            child: Text(
                              'Do you want to select your doctor?',
                              textAlign: TextAlign.start,
                              style: FlutterFlowTheme.of(context)
                                  .bodyText1
                                  .override(
                                    fontFamily: 'Open Sans',
                                    color: Color(0xFF606E87),
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(10, 15, 0, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            FlutterFlowRadioButton(
                              options: [
                                'Yes',
                                'Help me with available doctor',
                              ].toList(),
                              onChanged: (value) {
                                setState(() => radioButtonValue = value);
                                if (radioButtonValue == 'Yes') {
                                  // ref
                                  //     .read(_doctorsProvider)
                                  //     .fetchAllDoctors(
                                  //         hospitalId: widget.hospitalId,
                                  //         serviceId: widget.service.id);
                                }
                              },
                              optionHeight: 25,
                              textStyle: FlutterFlowTheme.of(context)
                                  .bodyText1
                                  .override(
                                    fontFamily: 'Open Sans',
                                    color: Color(0xFF606E87),
                                  ),
                              selectedTextStyle: FlutterFlowTheme.of(context)
                                  .bodyText1
                                  .override(
                                    fontFamily: 'Open Sans',
                                    color: Color(0xFF606E87),
                                    fontWeight: FontWeight.w600,
                                  ),
                              buttonPosition: RadioButtonPosition.left,
                              direction: Axis.vertical,
                              radioButtonColor: Color(0xFF00A8A3),
                              inactiveRadioButtonColor: Color(0xFF00A8A3),
                              toggleable: false,
                              horizontalAlignment: WrapAlignment.start,
                              verticalAlignment: WrapCrossAlignment.start,
                            ),
                          ],
                        ),
                      ),
                      // if (radioButtonValue == 'Yes')
                      //     Expanded(
                      //       child: Consumer(
                      //         builder: (context, ref, child) {
                      //           DoctorRecordProvider _docRecords =
                      //               ref.watch(_doctorsProvider);
                      //           if (_docRecords.isLoading) {
                      //             return Center(
                      //               child: CircularProgressIndicator(),
                      //             );
                      //           } else {
                      //             return DoctorCardListView(
                      //               doctors: _docRecords.doctors,
                      //             );
                      //           }
                      //         },
                      //       ),
                      //     ),
                      //   if (radioButtonValue != 'Yes') Spacer(),
                      //   Padding(
                      //     padding: const EdgeInsets.only(bottom: 18),
                      //     child: Container(
                      //       width: MediaQuery.of(context).size.width * 0.7,
                      //       height: 55,
                      //       // padding: EdgeInsets.only(bottom: 12),
                      //       decoration: BoxDecoration(
                      //         color: Color(0xFF00A8A3),
                      //         borderRadius: BorderRadius.circular(18),
                      //       );
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            // child: Align(
                            //   alignment: AlignmentDirectional(0.05, 0),
                            //   child: Padding(
                            //     padding: EdgeInsetsDirectional.fromSTEB(
                            //         0, 300, 0, 0),
                            //     child: FFButtonWidget(
                            //       onPressed: () {
                            //         Navigator.of(context)
                            //             .push(MaterialPageRoute(
                            //           builder: (_) => hvtScreen2Widget(),
                            //         ));
                            //       },
                            //       text: 'Next',
                            //       options: FFButtonOptions(
                            //         width: 130,
                            //         height: 40,
                            //         color: Color(0xFF00A8A3),
                            //         textStyle: FlutterFlowTheme.of(context)
                            //             .subtitle2
                            //             .override(
                            //               fontFamily: 'Open Sans',
                            //               color: Colors.white,
                            //               fontSize: 18,
                            //             ),
                            //         borderSide: BorderSide(
                            //           color: Colors.transparent,
                            //           width: 1,
                            //         ),
                            //         borderRadius: 15,
                            //       ),
                            //     ),
                            //   ),
                            // ),
                            // child: InkWell(
                            //   onTap: () {
                            //     if (textController.text.isEmpty) {
                            //       ScaffoldMessenger.of(context).showSnackBar(
                            //           SnackBar(
                            //               content:
                            //                   Text('Please enter the Goal')));
                            //     } else if (radioButtonValue == null) {
                            //       ScaffoldMessenger.of(context).showSnackBar(
                            //           SnackBar(
                            //               content: Text(
                            //                   'Please select a doctor option')));
                            //       // } else if (radioButtonValue == 'Yes' &&
                            //       //     _selectedDoctor == null) {
                            //       //   ScaffoldMessenger.of(context).showSnackBar(
                            //       //       SnackBar(
                            //       //           content: Text(
                            //       //               'Please select a doctor')));
                            //     } else {
                            //       Navigator.push(
                            //           context,
                            //           MaterialPageRoute(
                            //               builder: (context) =>
                            //                   hvtScreen2Widget()));
                            //     }
                            //   },
                            child: Align(
                              alignment: AlignmentDirectional(0.05, 0),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0, 20, 0, 50),
                                child: FFButtonWidget(
                                  onPressed: () {
                                    if (textController.text.isEmpty) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              content: Text(
                                                  'Please enter the Goal')));
                                    } else if (radioButtonValue == null) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              content: Text(
                                                  'Please select a doctor')));
                                      // } else if (radioButtonValue == 'Yes' &&
                                      //     _selectedDoctor == null) {
                                      //   ScaffoldMessenger.of(context).showSnackBar(
                                      //       SnackBar(
                                      //           content: Text(
                                      //               'Please select a doctor')));
                                    } else {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => hvtTimeSlot(
                                                    isUniversalTimeSlot: true,
                                                  )));
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
                                          color: Colors.white,
                                          fontSize: 18,
                                        ),
                                    borderSide: BorderSide(
                                      color: Colors.transparent,
                                      width: 1,
                                    ),
                                    borderRadius: 15,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
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
