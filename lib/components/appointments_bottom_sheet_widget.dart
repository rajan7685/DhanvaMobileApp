import 'dart:io';
import 'dart:math';

import 'package:dhanva_mobile_app/global/services/api_services/api_service_base.dart';
import 'package:dio/dio.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart' as path;
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

class AppointmentsBottomSheetWidget extends StatefulWidget {
  final Map<String, dynamic> appointmentJson;
  const AppointmentsBottomSheetWidget({Key key, @required this.appointmentJson})
      : super(key: key);

  @override
  _AppointmentsBottomSheetWidgetState createState() =>
      _AppointmentsBottomSheetWidgetState();
}

class _AppointmentsBottomSheetWidgetState
    extends State<AppointmentsBottomSheetWidget> {
  final String _prescriptionDownloadUri =
      'http://api3.dhanva.icu/files/download/';
  String statusText(int val) {
    if (val == 0) return 'Booked';
    if (val == 1) return 'Completed';
    return 'Cancelled';
  }

  Future<void> _downloadFileAndPreview() async {
    Directory appDocDir = await path.getApplicationDocumentsDirectory();
    try {
      Response res = await ApiService.dio.download(
          '${_prescriptionDownloadUri}61cdcfdf7c9850a47de40886',
          appDocDir.path + 'Medical_Records/61cdcfdf7c9850a47de40886.pdf');
      await OpenFile.open(
          '${appDocDir.path}/Medical_Records/61cdcfdf7c9850a47de40886.pdf');
    } catch (e) {
      print(e.toString());
    }
    print('opened the file');
  }

  @override
  Widget build(BuildContext context) {
    debugPrint(widget.appointmentJson.toString());
    debugPrint(widget.appointmentJson['payment_info']['meta_info'].toString());
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
      child: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          color: Color(0xFFEEEEEE),
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(0),
            bottomRight: Radius.circular(0),
            topLeft: Radius.circular(18),
            topRight: Radius.circular(18),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(12, 8, 12, 8),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    flex: 1,
                    child: Image.asset(
                      'assets/images/Group_524.png',
                      width: 80,
                      height: 80,
                      fit: BoxFit.contain,
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                widget.appointmentJson['patient_id']['name'],
                                style: FlutterFlowTheme.of(context)
                                    .bodyText1
                                    .override(
                                      fontFamily: 'Open Sans',
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                    ),
                              ),
                              // Align(
                              //   alignment: AlignmentDirectional(0, 0),
                              //   child: Padding(
                              //     padding: EdgeInsetsDirectional.fromSTEB(
                              //         4, 0, 0, 0),
                              //     child: Text(
                              //       '(Father)',
                              //       style: FlutterFlowTheme.of(context)
                              //           .bodyText1
                              //           .override(
                              //             fontFamily: 'Open Sans',
                              //             fontSize: 12,
                              //           ),
                              //     ),
                              //   ),
                              // ),
                            ],
                          ),
                          Text(
                            DateFormat('MMM d, yyyy at hh:mma').format(
                                DateTime.parse(
                                    widget.appointmentJson['appointmentDate'])),
                            style:
                                FlutterFlowTheme.of(context).bodyText1.override(
                                      // fontSize: 17,
                                      fontFamily: 'Poppins',
                                      color: Color(0xFF636363),
                                    ),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                            child: Text(
                              widget.appointmentJson['doctor']['name'],
                              style: FlutterFlowTheme.of(context)
                                  .subtitle1
                                  .override(
                                    fontFamily: 'Poppins',
                                    fontSize: 16,
                                    fontWeight: FontWeight.normal,
                                  ),
                            ),
                          ),
                          Text(
                            "(${widget.appointmentJson['doctor']['designation']})",
                            style:
                                FlutterFlowTheme.of(context).subtitle2.override(
                                      fontFamily: 'Poppins',
                                      fontSize: 12,
                                    ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        color: Color(0xFFEEEEEE),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            width: 70,
                            height: 25,
                            decoration: BoxDecoration(
                              color: Color(0xFF00A8A3),
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(0),
                                bottomRight: Radius.circular(0),
                                topLeft: Radius.circular(8),
                                topRight: Radius.circular(8),
                              ),
                            ),
                            child: Align(
                              alignment: AlignmentDirectional(0, 0),
                              child: Text(
                                'status',
                                style: FlutterFlowTheme.of(context)
                                    .bodyText1
                                    .override(
                                      fontFamily: 'Open Sans',
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                    ),
                              ),
                            ),
                          ),
                          Container(
                            width: 70,
                            height: 25,
                            decoration: BoxDecoration(
                              color: Color(0xFFEEEEEE),
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(8),
                                bottomRight: Radius.circular(8),
                                topLeft: Radius.circular(0),
                                topRight: Radius.circular(0),
                              ),
                              border: Border.all(
                                color: Color(0xFF00A8A3),
                                width: 2,
                              ),
                            ),
                            child: Align(
                              alignment: AlignmentDirectional(0, 0),
                              child: Text(
                                statusText(widget.appointmentJson['status']),
                                style: FlutterFlowTheme.of(context)
                                    .bodyText1
                                    .override(
                                      fontFamily: 'Open Sans',
                                      color: Color(0xFF00A8A3),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                    ),
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
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(12, 20, 12, 0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    'Payment Details',
                    style: FlutterFlowTheme.of(context).title1.override(
                          fontFamily: 'Open Sans',
                          color: Colors.black,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(12, 20, 12, 0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    "Transaction id: ${widget.appointmentJson['payment_info']['transaction_id']}",
                    style: FlutterFlowTheme.of(context).subtitle2.override(
                          fontFamily: 'Poppins',
                          color: Color(0xFF7E7E7E),
                          fontSize: 15,
                        ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(12, 4, 12, 0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  // Text(
                  //   'Bank Name: ',
                  //   style: FlutterFlowTheme.of(context).subtitle2.override(
                  //         fontFamily: 'Poppins',
                  //         color: Color(0xFF7E7E7E),
                  //         fontSize: 15,
                  //       ),
                  // ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(12, 4, 12, 0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    'Payment Mode: ',
                    style: FlutterFlowTheme.of(context).subtitle2.override(
                          fontFamily: 'Poppins',
                          color: Color(0xFF7E7E7E),
                          fontSize: 15,
                        ),
                  ),
                  //widget.appointmentJson
                  Text(
                    widget.appointmentJson['payment_info']['meta_info']
                        ['payment_type'],
                    style: FlutterFlowTheme.of(context).subtitle2.override(
                          fontFamily: 'Poppins',
                          color: Color(0xFF7E7E7E),
                          fontSize: 15,
                        ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(12, 4, 12, 0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    'Paid: Rs. ${widget.appointmentJson['payment_info']['amount']}',
                    style: FlutterFlowTheme.of(context).subtitle2.override(
                          fontFamily: 'Poppins',
                          color: Color(0xFF171717),
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(12, 26, 12, 0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    'Symptoms',
                    style: FlutterFlowTheme.of(context).title1.override(
                          fontFamily: 'Open Sans',
                          color: Colors.black,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(12, 20, 12, 0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    widget.appointmentJson['symptoms'],
                    style: FlutterFlowTheme.of(context).subtitle2.override(
                          fontFamily: 'Poppins',
                          color: Color(0xFF7E7E7E),
                          fontSize: 15,
                        ),
                  ),
                ],
              ),
            ),
            Spacer(),
            if (widget.appointmentJson['status'] == 1)
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 28),
                child: InkWell(
                  onTap: () async {
                    Navigator.pop(context);
                    _downloadFileAndPreview();
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(
                            'Please wait while the file is downloading...')));
                  },
                  child: Container(
                    width: 340,
                    height: 45,
                    decoration: BoxDecoration(
                      color: Color(0xFF00A8A3),
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Align(
                          alignment: AlignmentDirectional(0, 0),
                          child: Text(
                            'Download Prescription',
                            style:
                                FlutterFlowTheme.of(context).bodyText1.override(
                                      fontFamily: 'Open Sans',
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                    ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(8, 0, 0, 0),
                          child: Transform.rotate(
                            angle: pi / 2,
                            child: Image.asset(
                              'assets/images/Layer_2.png',
                              width: 32,
                              height: 32,
                              fit: BoxFit.cover,
                            ),
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
    );
  }
}
