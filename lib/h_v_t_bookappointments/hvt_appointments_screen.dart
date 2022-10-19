import 'dart:convert';
import 'dart:ffi';
import 'dart:io';
import 'package:dhanva_mobile_app/main.dart';
import 'package:path_provider/path_provider.dart';
import 'package:dhanva_mobile_app/appointments_screen/appointment_model.dart';
import 'package:dhanva_mobile_app/components/notification_icon_button.dart';
import 'package:dhanva_mobile_app/global/models/patient.dart';
import 'package:dhanva_mobile_app/global/services/api_services/medical_appoinment_service.dart';
import 'package:dhanva_mobile_app/global/services/mock_json_data_service.dart';
import 'package:dhanva_mobile_app/global/services/shared_preference_service.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:open_file/open_file.dart';

import '../app_guide_screen2/app_guide_screen2_widget.dart';
import '../components/appointments_bottom_sheet_widget.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

import '../global/services/api_services/api_service_base.dart';
import '../h_v_t_assestment_screen/h_v_t_assestment_screen_widget.dart';
import 'hvt_check_screen.dart';
import 'hvt_start_appointment.dart';

class HvtAppointmentsScreenWidget extends StatefulWidget {
  final Map<String, dynamic> data;
  final bool shouldPopNormally;
  const HvtAppointmentsScreenWidget(
      {Key key, this.shouldPopNormally = true, @required this.data})
      : super(key: key);

  @override
  _HvtAppointmentsScreenWidgetState createState() =>
      _HvtAppointmentsScreenWidgetState();
}

class _HvtAppointmentsScreenWidgetState
    extends State<HvtAppointmentsScreenWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  bool isDataLoading = true;
  List<dynamic> appointments = [];
  List<dynamic> resDatas;

  Future<void> _loadhvtAppointments({bool init = false}) async {
    print("calling the get API");
    if (!init)
      setState(() {
        isDataLoading = true;
      });
    Patient patient = Patient.fromJson(
        jsonDecode(SharedPreferenceService.loadString(key: PatientKey)));
    Response res = await ApiService.dio.get(
        "${ApiService.protocol}${ApiService.baseUrl2}hvt/family/all/${patient.id}",
        options: Options(headers: {
          'Authorization': SharedPreferenceService.loadString(key: AuthTokenKey)
        }));
    appointments = res.data;
    setState(() {
      isDataLoading = false;
    });
    print((res.data as List).length);
    print("HVT${res.data}");
  }

  @override
  void initState() {
    super.initState();
    _loadhvtAppointments(init: true);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      // appBar: AppBar(
      //   backgroundColor: Color(0xFFF3F4F4),
      //   // iconTheme: IconThemeData(color: Color(0xFF00A8A3)),
      //   // automaticallyImplyLeading: true,
      //   actions: [
      //     Padding(
      //         padding: EdgeInsetsDirectional.fromSTEB(0, 0, 12, 0),
      //         child: NotificationIconButton()),
      //   ],
      //   centerTitle: true,
      //   elevation: 0,
      // ),
      //backgroundColor: Color(0xFFF3F4F4),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () async {
      //     // file picking action
      //     // final res = await FilePicker.platform.pickFiles(allowMultiple: false);
      //     // await OpenFile.open(res.files.first.path);
      //     final String _prescriptionDownloadUri =
      //         '${ApiService.protocol}api2.dhanva.icu/files/download/';
      //     Directory path = await getApplicationDocumentsDirectory();

      //     print(path.uri);
      //   },
      //   backgroundColor: FlutterFlowTheme.of(context).primaryColor,
      //   elevation: 8,
      //   child: Icon(
      //     Icons.add_rounded,
      //     color: Colors.white,
      //     size: 24,
      //   ),
      // ),
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(5, 0, 0, 0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(5, 0, 12, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: () async {
                          // if (widget.shouldPopNormally)
                          //   Navigator.pop(context);
                          // else
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: ((context) => NavBarPage())));
                        },
                        child: Icon(
                          Icons.arrow_back_rounded,
                          color: Color(0xFF00A8A3),
                          size: 35,
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
                  padding: EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
                  child: Text(
                    'HVT Appointments',
                    style: FlutterFlowTheme.of(context).bodyText1.override(
                          fontFamily: 'Open Sans',
                          color: Color(0xFF00A8A3),
                          fontSize: 32,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ),
                // Row(
                //   mainAxisSize: MainAxisSize.max,
                //   children: [
                //     Padding(
                //       padding: EdgeInsetsDirectional.fromSTEB(0, 2, 0, 0),
                //       child: Text(
                //         'Completed, Present & Upcoming',
                //         style: FlutterFlowTheme.of(context).bodyText1.override(
                //               fontFamily: 'Open Sans',
                //               fontSize: 18,
                //             ),
                //       ),
                //     ),
                //   ],
                // ),
                Expanded(
                  child: isDataLoading
                      ? Center(child: CircularProgressIndicator())
                      : (appointments.length == 0
                          ? Center(
                              child: Text(
                                  'Nothing yet, Try booking an HVT appointment'))
                          : RefreshIndicator(
                              onRefresh: () async {
                                // _loadhvtAppointments();
                              },
                              child: ListView.builder(
                                itemCount: appointments.length,
                                itemBuilder: (_, int index) => GestureDetector(
                                  child: AppointmentCard(
                                    appointmentModel: appointments[index],
                                  ),
                                  onTap: () async {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (_) =>
                                                hvtCheckScreenWidget(
                                                  appointmentJson:
                                                      appointments[index],
                                                  hvtId: appointments[index]
                                                      ["_id"],
                                                  hvtStatus: int.parse(
                                                    appointments[index]
                                                        ["status"],
                                                  ),
                                                )));
                                  },
                                ),
                              ),
                            )),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.78,
                        height: 55,
                        decoration: BoxDecoration(
                          color: Color(0xFF00A8A3),
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (_) => AppGuideScreen2Widget()));
                              },
                              child: Text(
                                'Create HVT Program',
                                style: FlutterFlowTheme.of(context)
                                    .bodyText1
                                    .override(
                                      fontFamily: 'Open Sans',
                                      color: Color(0xFFFBFAFA),
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(16, 0, 0, 0),
                              child: Image.asset(
                                'assets/images/Layer_2.png',
                                width: 35,
                                height: 35,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AppointmentCard extends StatelessWidget {
  final Map<String, dynamic> appointmentModel;

  const AppointmentCard({Key key, @required this.appointmentModel})
      : super(key: key);

  String statusText(int val) {
    String status;
    // if (appointmentModel['hasConsultation'])
    //   status = 'Completed';
    if (val == 0)
      status = 'Booked';
    else if (val == 1)
      status = 'Active';
    else if (val == 2) status = 'Completed';
    return status;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      color: Colors.white,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(12, 12, 12, 12),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQvDVXm8awuyibcdpoTSPoePE6-OKncWYyNK9QF-YO66FyUIWHrlF8hbvBU7Gml5eoeeGw&usqp=CAU',
                width: 70,
                height: 85,
                fit: BoxFit.contain,
              ),
            ),
            Expanded(
              child: Align(
                alignment: AlignmentDirectional(0, 0.15),
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
                            appointmentModel["patient_id"]["name"] ?? "-",
                            style:
                                FlutterFlowTheme.of(context).bodyText1.override(
                                      fontFamily: 'Open Sans',
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                    ),
                          ),
                          // if (appointmentModel['payment_info'] != null)
                          // Text(" (Friend)")
                        ],
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(0, 2, 0, 0),
                            child: Text(
                              "${DateFormat('MMM d, yyyy').format(
                                DateTime.parse(
                                  appointmentModel['appointmentDate'],
                                ),
                              )} ${appointmentModel['time_slot']}",
                              // "12 Sept 12:00AM",
                              style: FlutterFlowTheme.of(context)
                                  .bodyText1
                                  .override(
                                    fontFamily: 'Open Sans',
                                    fontSize: 12,
                                  ),
                            ),
                          ),
                          // if (appointmentModel['payment_info'] != null)
                          // Text(
                          //   // " (${appointmentModel['payment_info']['meta_info']['booking_type']} booking)",
                          //   "Online",
                          //   style:
                          //       FlutterFlowTheme.of(context).bodyText1.override(
                          //             fontFamily: 'Open Sans',
                          //             fontSize: 12,
                          //           ),
                          // ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 6, 0, 0),
                        child: FFButtonWidget(
                          onPressed: () {
                            print('Button pressed ...');
                          },
                          text: statusText(
                            int.parse(
                              appointmentModel["status"],
                            ),
                          ),
                          options: FFButtonOptions(
                            // width: 80,
                            height: 24,
                            color: Colors.white,
                            textStyle:
                                FlutterFlowTheme.of(context).subtitle2.override(
                                      fontFamily: 'Poppins',
                                      color: Color(0xFF0BA6C3),
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                            borderSide: BorderSide(
                              color: Color(0xFF0BA6C3),
                              width: 2,
                            ),
                            borderRadius: 12,
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
