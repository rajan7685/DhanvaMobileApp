import 'package:dhanva_mobile_app/m_n_c_bookappointments/mnc_appointments_screen.dart';
import 'package:dhanva_mobile_app/m_n_c_bookappointments/mnc_bookdoctor_screen.dart';
import 'package:dhanva_mobile_app/m_n_c_bookappointments/mnc_logs_investigation.dart';
import 'package:dhanva_mobile_app/m_n_c_bookappointments/mnc_payment_screen.dart';
import 'package:dhanva_mobile_app/m_n_c_bookappointments/mnc_timeslot_screen.dart';

import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import '../main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

class mncSuccessScreenWidget extends StatefulWidget {
  const mncSuccessScreenWidget({Key key}) : super(key: key);

  @override
  _mncSuccessScreenWidgetState createState() => _mncSuccessScreenWidgetState();
}

class _mncSuccessScreenWidgetState extends State<mncSuccessScreenWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

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
              Image.asset(
                'assets/images/login__1.png',
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 1,
                fit: BoxFit.cover,
              ),
              Align(
                alignment: AlignmentDirectional(0, 0.05),
                child: Image.asset(
                  'assets/images/Group_521.png',
                  width: MediaQuery.of(context).size.width * 0.7,
                  height: 350,
                  fit: BoxFit.fitWidth,
                ),
              ),
              // Padding(
              //   padding: EdgeInsetsDirectional.fromSTEB(10, 10, 12, 0),
              //   child: Row(
              //       mainAxisSize: MainAxisSize.max,
              //       mainAxisAlignment: MainAxisAlignment.start,
              //       children: [
              //         InkWell(
              //           onTap: () async {
              //             Navigator.pop(context);
              //           },
              //           child: Icon(
              //             Icons.arrow_back_rounded,
              //             color: Colors.white,
              //             size: 40,
              //           ),
              //         ),
              //       ]),
              // ),
              Align(
                alignment: AlignmentDirectional(0, 1),
                child: Container(
                  width: double.infinity,
                  height: 240,
                  decoration: BoxDecoration(
                    color: Color(0xFFEEEEEE),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(0),
                      bottomRight: Radius.circular(0),
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40),
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
                        child: Text(
                          'Thanks for Booking',
                          style: FlutterFlowTheme.of(context).title1.override(
                                fontFamily: 'Open Sans',
                                color: Color(0xFF00A8A3),
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 2, 0, 0),
                        child: Text(
                          'Your MNC Appointment has been Scheduled',
                          style:
                              FlutterFlowTheme.of(context).bodyText1.override(
                                    fontFamily: 'Open Sans',
                                    color: Color(0xFF00A8A3),
                                    fontSize: 18,
                                  ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 38, 0, 0),
                        child: FFButtonWidget(
                          onPressed: () async {
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    MncAppointmentsScreenWidget(),
                              ),
                            );
                          },
                          text: 'Go',
                          options: FFButtonOptions(
                            width: 100,
                            height: 60,
                            color: Color(0xFF00A8A3),
                            textStyle:
                                FlutterFlowTheme.of(context).subtitle2.override(
                                      fontFamily: 'Open Sans',
                                      color: Colors.white,
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                    ),
                            borderSide: BorderSide(
                              color: Colors.transparent,
                              width: 1,
                            ),
                            borderRadius: 44,
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
      ),
    );
  }
}
