import 'dart:convert';
import 'package:dhanva_mobile_app/components/notification_icon_button.dart';
import 'package:dhanva_mobile_app/global/models/medical_record.dart';
import 'package:dhanva_mobile_app/global/models/patient.dart';
import 'package:dhanva_mobile_app/global/providers/medical_records_provider.dart';
import 'package:dhanva_mobile_app/global/services/shared_preference_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';

import '../components/medical_record_bottom_sheet_widget.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

ChangeNotifierProvider<MedicalRecordsProvider> _medicalRecordsProvider =
    ChangeNotifierProvider((ref) => MedicalRecordsProvider());

class MedicalRecordScreenWidget extends ConsumerStatefulWidget {
  const MedicalRecordScreenWidget({Key key}) : super(key: key);

  @override
  ConsumerState createState() => _MedicalRecordScreenWidgetState();
}

class _MedicalRecordScreenWidgetState
    extends ConsumerState<MedicalRecordScreenWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    ref.read(_medicalRecordsProvider).fetchMedicalRecords(init: true);
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
        //       padding: EdgeInsetsDirectional.fromSTEB(0, 2, 14, 2),
        //       child: NotificationIconButton()),
        // ],
        centerTitle: true,
        elevation: 0,
      ),
      backgroundColor: Color(0xFFF3F4F4),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await showModalBottomSheet(
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            context: context,
            builder: (context) {
              return Padding(
                padding: MediaQuery.of(context).viewInsets,
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.8,
                  child: MedicalRecordBottomSheetWidget(
                    newRecord: true,
                  ),
                ),
              );
            },
          );
          // await Future.delayed(Duration(seconds: 2));
          ref.read(_medicalRecordsProvider).fetchMedicalRecords();
        },
        backgroundColor: FlutterFlowTheme.of(context).primaryColor,
        elevation: 8,
        child: Icon(
          Icons.add_rounded,
          color: Colors.white,
          size: 24,
        ),
      ),
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
                    'Medical Records',
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
                    Text(
                      'Have a look at medical records',
                      style: FlutterFlowTheme.of(context).bodyText1.override(
                            fontFamily: 'Open Sans',
                            fontSize: 18,
                          ),
                    ),
                    // Expanded(
                    //   child: Align(
                    //     alignment: AlignmentDirectional(0.65, 0),
                    //     child: Image.asset(
                    //       'assets/images/Group_608.png',
                    //       width: 35,
                    //       height: 35,
                    //       fit: BoxFit.contain,
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
                Expanded(child: Consumer(
                  builder: (context, ref, child) {
                    MedicalRecordsProvider _prov =
                        ref.watch(_medicalRecordsProvider);
                    if (_prov.isMedicalRecordsLoading) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      return RefreshIndicator(
                        onRefresh: () async {
                          ref
                              .read(_medicalRecordsProvider)
                              .fetchMedicalRecords();
                        },
                        child: ListView.builder(
                          itemCount: _prov.medicalRecords.length,
                          padding: EdgeInsets.fromLTRB(0, 8, 0, 0),
                          scrollDirection: Axis.vertical,
                          itemBuilder: (context, index) {
                            return InkWell(
                                onTap: () async {
                                  showModalBottomSheet(
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
                                              0.8,
                                          child: MedicalRecordBottomSheetWidget(
                                            medicalRecord:
                                                _prov.medicalRecords[index],
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                                child: MedicalRecordCard(
                                  medicalRecord: _prov.medicalRecords[index],
                                ));
                          },
                        ),
                      );
                    }
                  },
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MedicalRecordCard extends StatelessWidget {
  final MedicalRecord medicalRecord;
  const MedicalRecordCard({Key key, @required this.medicalRecord})
      : super(key: key);

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
        padding: EdgeInsetsDirectional.fromSTEB(12, 8, 12, 8),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Image.asset(
              'assets/images/Group_607.png',
              width: 65,
              height: 65,
              fit: BoxFit.contain,
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      medicalRecord.fileName,
                      style: FlutterFlowTheme.of(context).bodyText1.override(
                            fontFamily: 'Open Sans',
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    Text(
                      Patient.fromJson(jsonDecode(
                              SharedPreferenceService.loadString(
                                  key: PatientKey)))
                          .name,
                      style: FlutterFlowTheme.of(context).bodyText1,
                    ),
                    Text(
                      medicalRecord.employeeId ?? '',
                      style: FlutterFlowTheme.of(context).bodyText1,
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
                      child: Text(
                        DateFormat('MMM d, yyyy')
                            .format(medicalRecord.createdAt),
                        style: FlutterFlowTheme.of(context).bodyText1.override(
                              fontFamily: 'Open Sans',
                              fontSize: 12,
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
    );
  }
}
