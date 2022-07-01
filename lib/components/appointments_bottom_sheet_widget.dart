import 'dart:io';
import 'dart:math';
import 'package:html/dom.dart' as HTML;
import 'package:dhanva_mobile_app/global/services/api_services/api_service_base.dart';
import 'package:dhanva_mobile_app/global/services/shared_preference_service.dart';
import 'package:dio/dio.dart';
import 'package:html/parser.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart' as path;
import 'package:permission_handler/permission_handler.dart';
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
      'http://api2.dhanva.icu/files/download/';
  String _consultationNotes;

  HTML.Document _data;

  @override
  void initState() {
    super.initState();

    if (widget.appointmentJson['hasConsultation']) _loadConsultaionNotes();
  }

  String statusText(int val) {
    String status;
    if (widget.appointmentJson['hasConsultation'])
      status = 'Completed';
    else if (val == 0)
      status = 'Booked';
    else if (val == 1)
      status = 'Accepted';
    else if (val == 2)
      status = 'Cancelled';
    else if (val == 3) status = 'Error';
    return status;
  }

  Future<void> _downloadFileAndPreview() async {
    // Directory appDocDir = await path.getExternalStorageDirectory();
    // android download file directory

    PermissionStatus stat = await Permission.storage.status;
    PermissionStatus writestat = await Permission.manageExternalStorage.status;
    if (!writestat.isGranted) await Permission.manageExternalStorage.request();
    if (!stat.isGranted) await Permission.storage.request();
    print('Storage $stat External $writestat');
    // Directory appDocDir = Directory('/storage/emulated/0/Download');
    // String _timeStampName = DateTime.now().millisecondsSinceEpoch.toString();
    // print(
    //     'filesave path : ${appDocDir.path}/medical_record_$_timeStampName.pdf');
    try {
      // Response res = await ApiService.dio.download(
      //     '$_prescriptionDownloadUri${widget.appointmentJson['_id']}',
      //     appDocDir.path + '/medical_record_$_timeStampName.pdf');
      // print(res.data.toString());
      // await OpenFile.open(
      //     '${appDocDir.path}/Medical_Records/$_timeStampName.pdf');
    } catch (e) {
      print(e.toString());
    }
    // print('opened the file');

    // Directory dir = Directory('/storage/emulated/0/Download');
    // String fileUrl =
    //     'https://www.w3.org/WAI/ER/tests/xhtml/testfiles/resources/pdf/dummy.pdf';
    // Directory externalDir = await path.getExternalStorageDirectory();
    // print(dir.path);
    // print(externalDir.path);
  }

  void _loadConsultaionNotes() async {
    String consultationNoteUri = 'http://api2.dhanva.icu/prescription/get/';
    Response res = await ApiService.dio.get(
        '$consultationNoteUri${widget.appointmentJson['_id']}',
        options: Options(headers: {
          'Authorization': SharedPreferenceService.loadString(key: AuthTokenKey)
        }));
    setState(() {
      _consultationNotes = res.data['Consultation_notes'];
    });
    _data = parse(_consultationNotes);
  }

  @override
  Widget build(BuildContext context) {
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
                            DateFormat('MMM d, yyyy hh:mma').format(
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
            SizedBox(
              height: 12,
            ),
            if (widget.appointmentJson['hasConsultation'])
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    Text(
                      'Consultaion Notes',
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
            SizedBox(
              height: 16,
            ),
            if (_consultationNotes != null && _consultationNotes.isNotEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    Text(
                      _data.querySelector('p')?.innerHtml ?? _consultationNotes,
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
