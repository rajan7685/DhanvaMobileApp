import 'dart:convert';

import 'package:dhanva_mobile_app/global/models/patient.dart';
import 'package:dhanva_mobile_app/global/services/api_services/api_service_base.dart';
import 'package:dhanva_mobile_app/m_n_c_bookappointments/mnc_logs_investigation.dart';
import 'package:dhanva_mobile_app/m_n_c_bookappointments/mnc_payment_breakage_screen.dart';
import 'package:dio/dio.dart';

import '../components/notification_icon_button.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import '../global/services/shared_preference_service.dart';
import 'mnc_check_payment.dart';

class mncCheckScreenWidget extends StatefulWidget {
  final Map<String, dynamic> appointmentJson;
  final String mncId;
  final int mncStatus;
  final bool isMncPaused;
  final bool shouldPopNormally;

  const mncCheckScreenWidget(
      {Key key,
      @required this.appointmentJson,
      @required this.mncId,
      @required this.shouldPopNormally,
      @required this.isMncPaused,
      @required this.mncStatus})
      : super(key: key);

  @override
  _mncCheckScreenWidgetState createState() => _mncCheckScreenWidgetState();
}

class _mncCheckScreenWidgetState extends State<mncCheckScreenWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  Map<String, dynamic> resData = {};
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadPlanNotesDetails();
  }

  Future<void> _loadPlanNotesDetails() async {
    Response res = await ApiService.dio.get(
        "${ApiService.protocol}${ApiService.baseUrl2}mnc/${widget.appointmentJson["_id"]}",
        options: Options(headers: {
          'Authorization': SharedPreferenceService.loadString(key: AuthTokenKey)
        }));
    setState(() {
      resData = res.data;
      _loading = false;
    });
    // resData["mncPayments"] !=
    //                                                 null &&
    //                                             resData["mncPayments"]
    //                                                 .containsKey(
    //                                                     "initial_payment") &&
    //                                             resData["status"] == 1
    print('conditions: ${resData["mncPayments"] != null}');
    print(
        'conditions: ${resData["mncPayments"].containsKey("initial_payment")}');
    print('conditions: ${resData["status"].runtimeType}');
  }

  @override
  void dispose() {
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
          child: Stack(
            children: [
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
                        // if (resData["mncPayments"] != null &&
                        //     !resData["mncPayments"]
                        //         .containsKey("initial_payment")) {
                        //   Navigator.pop(context);
                        //   Navigator.pop(context);
                        //   Navigator.pop(context);
                        // } else {
                        //   Navigator.pop(context);
                        // }
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
                    //     children: [
                    //       //
                    //       NotificationIconButton()
                    //     ],
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
                      'MNC Appointments',
                      textAlign: TextAlign.start,
                      style: FlutterFlowTheme.of(context).bodyText1.override(
                            fontFamily: 'Open Sans',
                            color: Color(0xFFF3F4F4),
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    Text(
                      'Your MNC\'s',
                      style: FlutterFlowTheme.of(context).bodyText1.override(
                            fontFamily: 'Open Sans',
                            color: Color(0xFFF3F4F4),
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
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
                  child: !_loading
                      ? Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 30, 0, 0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    15, 10, 0, 2),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Text(
                                      'Appointment Details',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyText1
                                          .override(
                                            fontFamily: 'Poppins',
                                            color: Color(0xFF606E87),
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700,
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(5, 0, 5, 0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Expanded(
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            10, 0, 10, 0),
                                        child: Container(
                                          width: 100,
                                          // height: 100,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              SizedBox(height: 8),
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(5, 8, 5, 0),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: [
                                                    Text(
                                                      'Medical Professional Name: Dr.${widget.appointmentJson["doctor"]["name"]}',
                                                      style: FlutterFlowTheme
                                                              .of(context)
                                                          .bodyText1
                                                          .override(
                                                            fontFamily:
                                                                'Poppins',
                                                            color: Color(
                                                                0xFF070000),
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(5, 5, 5, 0),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: [
                                                    Text(
                                                      'Appointment On: ${DateFormat("dd MMM yyyy").format(DateTime.parse(widget.appointmentJson["appointmentDate"]))} ${widget.appointmentJson["time_slot"]}',
                                                      style: FlutterFlowTheme
                                                              .of(context)
                                                          .bodyText1
                                                          .override(
                                                            fontFamily:
                                                                'Poppins',
                                                            color: Color(
                                                                0xFF070000),
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(5, 5, 5, 0),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: [
                                                    Flexible(
                                                      child: Text(
                                                        'MNC Goal: ${widget.appointmentJson["goal"]}',
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyText1
                                                                .override(
                                                                  fontFamily:
                                                                      'Poppins',
                                                                  color: Color(
                                                                      0xFF070000),
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(5, 5, 5, 0),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: [
                                                    if (resData["plan_name"] !=
                                                        null)
                                                      Text(
                                                        'MNC Plan: ${resData["plan_name"]}',
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyText1
                                                                .override(
                                                                  fontFamily:
                                                                      'Poppins',
                                                                  color: Color(
                                                                      0xFF070000),
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                ),
                                                      ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(height: 8),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    10, 50, 10, 0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    if (resData["consultation_notes"] != null)
                                      Text(
                                        'MNC Consultation Notes',
                                        style: FlutterFlowTheme.of(context)
                                            .bodyText1
                                            .override(
                                              fontFamily: 'Poppins',
                                              color: Color(0xFF606E87),
                                              fontSize: 16,
                                              fontWeight: FontWeight.w700,
                                            ),
                                      ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    10, 0, 10, 0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    if (resData["consultation_notes"] != null)
                                      Expanded(
                                        child: Container(
                                          // width: 100,
                                          // height: 100,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.only(
                                              bottomLeft: Radius.circular(0),
                                              bottomRight: Radius.circular(0),
                                              topLeft: Radius.circular(5),
                                              topRight: Radius.circular(0),
                                            ),
                                          ),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              SizedBox(height: 8),
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(5, 0, 5, 0),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: [
                                                    Flexible(
                                                      child: Text(
                                                          " ${resData["consultation_notes"] ?? "Not mentioned by the Medical Professional"}",
                                                          maxLines: 5,
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .bodyText1
                                                              .override(
                                                                fontFamily:
                                                                    'Poppins',
                                                                color: Color(
                                                                    0xFF070000),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                              )),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(height: 8),
                                            ],
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0, 120, 0, 0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      // width: 150,
                                      height: 50,
                                      decoration: BoxDecoration(
                                        color: Color(0xFF00A8A3),
                                        borderRadius: BorderRadius.circular(10),
                                        shape: BoxShape.rectangle,
                                      ),
                                      child: InkWell(
                                        onTap: () async {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    mncCheckPaymentScreenWidget(
                                                  data: widget.appointmentJson,
                                                  mncPayment: int.parse(
                                                    resData["initial_amount"],
                                                  ),
                                                  mncId: resData["_id"],
                                                  mncStatus: resData["status"],
                                                  isMncPaused:
                                                      resData["paused"],
                                                ),
                                              ));
                                        },
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            if (resData["mncPayments"] !=
                                                    null &&
                                                resData["initial_amount"] !=
                                                    null &&
                                                !resData["mncPayments"]
                                                    .containsKey(
                                                        "initial_payment"))
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(10.0),
                                                child: Text(
                                                  'Pay \u20B9${resData["initial_amount"]}',
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyText1
                                                      .override(
                                                        fontFamily: 'Open Sans',
                                                        color: Colors.white,
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                ),
                                              ),
                                            // Padding(
                                            //   padding: EdgeInsetsDirectional.fromSTEB(
                                            //       12, 0, 0, 0),
                                            //   child: Image.asset(
                                            //     'assets/images/Layer_2.png',
                                            //     width: 35,
                                            //     height: 35,
                                            //     fit: BoxFit.contain,
                                            //   ),
                                            // ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Container(
                                      // width: 150,
                                      height: 50,
                                      decoration: BoxDecoration(
                                        color: Color(0xFF00A8A3),
                                        borderRadius: BorderRadius.circular(10),
                                        shape: BoxShape.rectangle,
                                      ),
                                      child: InkWell(
                                        onTap: () async {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    mncLogsInvestigationWidget(
                                                  appointmentJson:
                                                      widget.appointmentJson,
                                                  mncId: resData["_id"],
                                                  mncStatus: resData["status"],
                                                  isMncpaused:
                                                      resData["paused"],
                                                ),
                                              ));
                                        },
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            if (resData["mncPayments"] !=
                                                    null &&
                                                resData["mncPayments"]
                                                    .containsKey(
                                                        "initial_payment") &&
                                                resData["status"] ==
                                                    1.toString())
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(10.0),
                                                child: Text(
                                                  'Logs & Investigation',
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyText1
                                                      .override(
                                                        fontFamily: 'Open Sans',
                                                        color: Colors.white,
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                ),
                                              ),
                                            // Padding(
                                            //   padding: EdgeInsetsDirectional.fromSTEB(
                                            //       12, 0, 0, 0),
                                            //   child: Image.asset(
                                            //     'assets/images/Layer_2.png',
                                            //     width: 35,
                                            //     height: 35,
                                            //     fit: BoxFit.contain,
                                            //   ),
                                            // ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    // Padding(
                                    //   padding:
                                    //       EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
                                    //   child: InkWell(
                                    //     onTap: () async {
                                    //       await showModalBottomSheet(
                                    //         isScrollControlled: true,
                                    //         backgroundColor: Colors.transparent,
                                    //         context: context,
                                    //         builder: (context) {
                                    //           return Padding(
                                    //             padding:
                                    //                 MediaQuery.of(context).viewInsets,
                                    //             child: Container(
                                    //               height: MediaQuery.of(context)
                                    //                       .size
                                    //                       .height *
                                    //                   0.45,
                                    //               child: mncAmountBreakupWidget(),
                                    //             ),
                                    //           );
                                    //         },
                                    //       ).then((value) => setState(() {}));
                                    //     },
                                    //     child: Icon(
                                    //       Icons.arrow_drop_down_outlined,
                                    //       color: Color(0xFF00A8A3),
                                    //       size: 35,
                                    //     ),
                                    //   ),
                                    // )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )
                      : Center(
                          child: CircularProgressIndicator(
                            color: Colors.green,
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
