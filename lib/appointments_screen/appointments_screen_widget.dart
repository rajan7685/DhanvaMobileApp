import 'dart:convert';
import 'dart:ffi';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:dhanva_mobile_app/appointments_screen/appointment_model.dart';
import 'package:dhanva_mobile_app/components/notification_icon_button.dart';
import 'package:dhanva_mobile_app/global/models/patient.dart';
import 'package:dhanva_mobile_app/global/services/api_services/medical_appoinment_service.dart';
import 'package:dhanva_mobile_app/global/services/mock_json_data_service.dart';
import 'package:dhanva_mobile_app/global/services/shared_preference_service.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:open_file_safe/open_file_safe.dart';
import '../components/appointments_bottom_sheet_widget.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

class AppointmentsScreenWidget extends StatefulWidget {
  const AppointmentsScreenWidget({Key key}) : super(key: key);

  @override
  _AppointmentsScreenWidgetState createState() =>
      _AppointmentsScreenWidgetState();
}

class _AppointmentsScreenWidgetState extends State<AppointmentsScreenWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  bool isDataLoading = true;
  List<dynamic> resData;
  List<dynamic> resDatas;

  void _loadAppointmentsData() async {
    Patient patient = Patient.fromJson(
        jsonDecode(SharedPreferenceService.loadString(key: PatientKey)));
    resDatas =
        await MedicalAppointmentsService.fetchMedicalAppointments(patient.id);
    resData = resDatas != null ? resDatas : [];
   
    // resData.sort((a, b) => DateTime.parse(b['appointmentDate'])
    //     .compareTo(DateTime.parse(a['appointmentDate'])));
    setState(() {
      isDataLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadAppointmentsData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: Color(0xFFF3F4F4),
        iconTheme: IconThemeData(color: Color(0xFF00A8A3)),
        automaticallyImplyLeading: true,
        // actions: [
        //   Padding(
        //       padding: EdgeInsetsDirectional.fromSTEB(0, 0, 12, 0),
        //       child: NotificationIconButton()),
        // ],
        centerTitle: true,
        elevation: 0,
      ),
      backgroundColor: Color(0xFFF3F4F4),
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
            padding: EdgeInsetsDirectional.fromSTEB(12, 0, 12, 0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
                  child: Text(
                    'Appointments',
                    style: FlutterFlowTheme.of(context).bodyText1.override(
                          fontFamily: 'Open Sans',
                          color: Color(0xFF00A8A3),
                          fontSize: 32,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 2, 0, 0),
                      child: Text(
                        'Completed, Present & Upcoming',
                        style: FlutterFlowTheme.of(context).bodyText1.override(
                              fontFamily: 'Open Sans',
                              fontSize: 18,
                            ),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: isDataLoading
                      ? Center(child: CircularProgressIndicator())
                      : (resData.length == 0
                          ? Center(
                              child: Text(
                                  'Nothing yet, Try booking an appointment'))
                          : RefreshIndicator(
                              onRefresh: () async {
                                setState(() {
                                  isDataLoading = true;
                                });
                                _loadAppointmentsData();
                              },
                              child: ListView.builder(
                                itemCount: resData.length,
                                itemBuilder: (_, int index) => GestureDetector(
                                  child: AppointmentCard(
                                    appointmentModel: resData[index],
                                  ),
                                  onTap: () async {
                                    await showModalBottomSheet(
                                      isScrollControlled: true,
                                      backgroundColor: Colors.transparent,
                                      context: context,
                                      builder: (context) {
                                        return Padding(
                                          padding:
                                              MediaQuery.of(context).viewInsets,
                                          child: Container(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.88,
                                            child:
                                                AppointmentsBottomSheetWidget(
                                              appointmentJson: resData[index],
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                ),
                              ),
                            )),
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
    if (appointmentModel['hasConsultation'])
      status = 'Completed';
    else if (val == 0)
      status = 'Booked';
    else if (val == 1)
      status = 'Accepted';
    else if (val == 2) status = 'Cancelled';
    return status;
  }

  @override
  Widget build(BuildContext context) {
    // print(" date format check${appointmentModel['appointmentDate']}");
    print(
        "appointment dates: ${DateTime.parse(appointmentModel['appointmentDate']).toLocal()}");
    print(
        " ${DateFormat('MMM d, yyyy').format(DateTime.parse(appointmentModel['appointmentDate']))}");

    print(DateFormat('MMM d, yyyy')
            .format(DateTime.parse(appointmentModel['appointmentDate'])) +
        appointmentModel['time_slot']);

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
                            appointmentModel['patient_id']['name'],
                            style:
                                FlutterFlowTheme.of(context).bodyText1.override(
                                      fontFamily: 'Open Sans',
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                    ),
                          ),
                          if (appointmentModel['payment_info'] != null)
                            Text(
                                " (${appointmentModel['payment_info']['meta_info']['relation_type']})")
                        ],
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(0, 2, 0, 0),
                            child: Text(
                              "${DateFormat('MMM d, yyyy').format(DateTime.parse(appointmentModel['appointmentDate']))} ${appointmentModel['time_slot']}",
                              style: FlutterFlowTheme.of(context)
                                  .bodyText1
                                  .override(
                                    fontFamily: 'Open Sans',
                                    fontSize: 12,
                                  ),
                            ),
                          ),
                          if (appointmentModel['payment_info'] != null)
                            Text(
                              " (${appointmentModel['payment_info']['meta_info']['booking_type']} booking)",
                              style: FlutterFlowTheme.of(context)
                                  .bodyText1
                                  .override(
                                    fontFamily: 'Open Sans',
                                    fontSize: 12,
                                  ),
                            ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 6, 0, 0),
                        child: FFButtonWidget(
                          onPressed: () {
                            print('Button pressed ...');
                          },
                          text: statusText(appointmentModel['status']),
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
