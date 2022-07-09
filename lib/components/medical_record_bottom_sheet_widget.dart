import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:dhanva_mobile_app/global/models/medical_record.dart';
import 'package:dhanva_mobile_app/global/models/patient.dart';
import 'package:dhanva_mobile_app/global/services/api_services/api_service_base.dart';
import 'package:dhanva_mobile_app/global/services/shared_preference_service.dart';
import 'package:dio/dio.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart' as path;

import 'package:permission_handler/permission_handler.dart';

import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';

class MedicalRecordBottomSheetWidget extends StatefulWidget {
  final MedicalRecord medicalRecord;
  final bool newRecord;

  const MedicalRecordBottomSheetWidget(
      {Key key, this.newRecord = false, this.medicalRecord})
      : super(key: key);

  @override
  _MedicalRecordBottomSheetWidgetState createState() =>
      _MedicalRecordBottomSheetWidgetState();
}

class _MedicalRecordBottomSheetWidgetState
    extends State<MedicalRecordBottomSheetWidget> {
  TextEditingController patientNameController;
  TextEditingController reportTypeController;
  TextEditingController doctorNameController;
  TextEditingController reportDateController;
  TextEditingController reportTimeController;
  List<PlatformFile> _pickedFiles = [];

  Future<void> _loadPatientInformation() async {
    await SharedPreferenceService.init();
    Patient patient = Patient.fromJson(
        jsonDecode(SharedPreferenceService.loadString(key: PatientKey)));
    Response res = await ApiService.dio.get(
        "http://api3.dhanva.icu/patient/getPatientDetails/${widget.medicalRecord.patientId}",
        options: Options(headers: {
          'Authorization': SharedPreferenceService.loadString(key: AuthTokenKey)
        }));
    setState(() {
      patientNameController.text = res.data['name'];
    });
  }

  void uploadFile(FilePickerResult pickedFiles) async {
    String fileUploadUri = 'http://api2.dhanva.icu/files/upload';
    FormData _formData = FormData.fromMap({
      "patient_id": widget.medicalRecord.patientId,
      "docType": reportTypeController.text ?? "Report",
      "file_name": pickedFiles.files.first.name,
      "file1": await MultipartFile.fromFile(pickedFiles.files.first.path,
          filename: pickedFiles.files.first.name)
    });
    Response res = await ApiService.dio.post(fileUploadUri,
        options: Options(headers: {
          'Authorization': SharedPreferenceService.loadString(key: AuthTokenKey)
        }),
        data: _formData);
    print(res.data);
  }

  void _pickFiles({bool allowMultiple = false}) async {
    if (!await Permission.storage.status.isGranted) {
      await Permission.storage.request();
    }
    //pick files

    FilePickerResult files = await FilePicker.platform.pickFiles(
      allowMultiple: allowMultiple,
    );
    files.files.forEach((file) {
      _pickedFiles.add(file);
    });
    setState(() {
      // updateUI
    });
    // uploadFile(files);
  }

  @override
  void initState() {
    super.initState();
    _loadPatientInformation();
    patientNameController =
        TextEditingController(text: widget.newRecord ? '' : '');
    reportTypeController =
        TextEditingController(text: widget.newRecord ? '' : 'Document');
    doctorNameController =
        TextEditingController(text: widget.newRecord ? '' : '');

    reportDateController = TextEditingController(
        text: widget.newRecord
            ? ''
            : DateFormat('MMM d, yyyy').format(widget.medicalRecord.createdAt));
    reportTimeController = TextEditingController(
        text: widget.newRecord
            ? ''
            : DateFormat('h:mma').format(widget.medicalRecord.createdAt));
  }

  _downloadFileAndPreview() async {
    Directory appDocDir = await path.getExternalStorageDirectory();
    PermissionStatus stat = await Permission.storage.status;

    if (!stat.isGranted) await Permission.storage.request();

    String _timeStampName = DateTime.now().millisecondsSinceEpoch.toString();
    List<String> _terms = widget.medicalRecord.filePath.split('/');
    String fileName = _terms[_terms.length - 1];
    print('${appDocDir.path}/$fileName');
    try {
      Response res = await ApiService.dio.download(
          widget.medicalRecord.filePath,
          '${appDocDir.path}/${_timeStampName}_$fileName');
      print(res.data.toString());
      await OpenFile.open('${appDocDir.path}/${_timeStampName}_$fileName');
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  Container _filesListView() => Container(
        width: double.maxFinite,
        height: 65,
        padding: const EdgeInsets.symmetric(horizontal: 6.0),
        child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: _pickedFiles.length + 1,
            itemBuilder: (_, int index) {
              if (_pickedFiles.length != 0 && index < _pickedFiles.length)
                return Padding(
                  padding: const EdgeInsets.only(right: 5),
                  child: Image.asset(
                    'assets/images/Group_607.png',
                    width: 65,
                    height: 65,
                    fit: BoxFit.contain,
                  ),
                );
              return InkWell(
                onTap: () => _pickFiles(),
                child: Container(
                  width: 55,
                  height: 55,
                  decoration: BoxDecoration(
                    color: Color(0xFFEEEEEE),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: Color(0xFF5A6771),
                      width: 4,
                    ),
                  ),
                  child: Icon(
                    Icons.add,
                    color: Color(0xFF535F6B),
                    size: 42,
                  ),
                ),
              );
            }),
      );

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        color: Color(0xFFF3F4F4),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(0),
          bottomRight: Radius.circular(0),
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(12, 16, 12, 0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              TextFormField(
                controller: patientNameController,
                obscureText: false,
                decoration: InputDecoration(
                  labelText: 'Patient Name',
                  labelStyle: FlutterFlowTheme.of(context).bodyText1.override(
                        fontFamily: 'Open Sans',
                        color: Color(0xFF9A9A9A),
                      ),
                  hintText: '[Some hint text...]',
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xFFC1C1C1),
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xFFC1C1C1),
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
                style: FlutterFlowTheme.of(context).bodyText1.override(
                      fontFamily: 'Open Sans',
                      color: Color(0xFF485163),
                      fontWeight: FontWeight.w500,
                    ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
                child: TextFormField(
                  controller: reportTypeController,
                  obscureText: false,
                  decoration: InputDecoration(
                    labelText: 'Type of scan or test',
                    labelStyle: FlutterFlowTheme.of(context).bodyText1.override(
                          fontFamily: 'Open Sans',
                          color: Color(0xFF9A9A9A),
                        ),
                    hintText: '[Some hint text...]',
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xFFC1C1C1),
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xFFC1C1C1),
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  style: FlutterFlowTheme.of(context).bodyText1.override(
                        fontFamily: 'Open Sans',
                        color: Color(0xFF485163),
                        fontWeight: FontWeight.w500,
                      ),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
                child: TextFormField(
                  controller: doctorNameController,
                  obscureText: false,
                  decoration: InputDecoration(
                    labelText: 'Doctor Name',
                    labelStyle: FlutterFlowTheme.of(context).bodyText1.override(
                          fontFamily: 'Open Sans',
                          color: Color(0xFF9A9A9A),
                        ),
                    hintText: '[Some hint text...]',
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xFFC1C1C1),
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xFFC1C1C1),
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  style: FlutterFlowTheme.of(context).bodyText1.override(
                        fontFamily: 'Open Sans',
                        color: Color(0xFF485163),
                        fontWeight: FontWeight.w500,
                      ),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 0, 12, 0),
                        child: TextFormField(
                          controller: reportDateController,
                          obscureText: false,
                          decoration: InputDecoration(
                            enabled: false,
                            labelText: 'Report Date',
                            labelStyle:
                                FlutterFlowTheme.of(context).bodyText1.override(
                                      fontFamily: 'Open Sans',
                                      color: Color(0xFF9A9A9A),
                                    ),
                            hintText: '[Some hint text...]',
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xFFC1C1C1),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xFFC1C1C1),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            filled: true,
                            fillColor: Colors.white,
                          ),
                          style:
                              FlutterFlowTheme.of(context).bodyText1.override(
                                    fontFamily: 'Open Sans',
                                    color: Color(0xFF485163),
                                    fontWeight: FontWeight.w500,
                                  ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                        child: TextFormField(
                          controller: reportTimeController,
                          obscureText: false,
                          decoration: InputDecoration(
                            enabled: false,
                            labelText: 'Report Time',
                            labelStyle:
                                FlutterFlowTheme.of(context).bodyText1.override(
                                      fontFamily: 'Open Sans',
                                      color: Color(0xFF9A9A9A),
                                    ),
                            hintText: '[Some hint text...]',
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xFFC1C1C1),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xFFC1C1C1),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            filled: true,
                            fillColor: Colors.white,
                          ),
                          style:
                              FlutterFlowTheme.of(context).bodyText1.override(
                                    fontFamily: 'Open Sans',
                                    color: Color(0xFF485163),
                                    fontWeight: FontWeight.w500,
                                  ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      'Upload your Report',
                      style: FlutterFlowTheme.of(context).bodyText1.override(
                            fontFamily: 'Open Sans',
                            color: Color(0xFF1E1E1E),
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 6,
              ),
              _filesListView(),
              InkWell(
                onTap: () {
                  _downloadFileAndPreview();
                },
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 18, 0, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        'Download All',
                        style: FlutterFlowTheme.of(context).bodyText1.override(
                              fontFamily: 'Open Sans',
                              color: Color(0xFF00A8A3),
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                    ],
                  ),
                ),
              ),
              if (!widget.newRecord)
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 42, 0, 0),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.78,
                    height: 55,
                    decoration: BoxDecoration(
                      color: Color(0xFF00A8A3),
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: InkWell(
                      onTap: () async {
                        Navigator.pop(context);
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Update Record',
                            style: FlutterFlowTheme.of(context).title1.override(
                                  fontFamily: 'Poppins',
                                  color: Colors.white,
                                ),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
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
                  ),
                ),
              if (widget.newRecord)
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 42, 0, 0),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.78,
                    height: 55,
                    decoration: BoxDecoration(
                      color: Color(0xFF00A8A3),
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: InkWell(
                      onTap: () async {
                        Navigator.pop(context);
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Save Record',
                            style: FlutterFlowTheme.of(context).title1.override(
                                  fontFamily: 'Poppins',
                                  color: Colors.white,
                                ),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
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
                  ),
                ),
              if (!widget.newRecord)
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 18, 0, 0),
                  child: InkWell(
                    onTap: () async {
                      Navigator.pop(context);
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.78,
                      height: 55,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(
                          color: Color(0xFF00A8A3),
                          width: 2,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Delete Record',
                            style: FlutterFlowTheme.of(context).title1.override(
                                  fontFamily: 'Poppins',
                                  color: Color(0xFF00A8A3),
                                ),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                            child: Container(
                              width: 35,
                              height: 35,
                              decoration: BoxDecoration(
                                color: Color(0xFFEEEEEE),
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Color(0xFF00A8A3),
                                  width: 2,
                                ),
                              ),
                              child: Icon(
                                Icons.close,
                                color: Color(0xFF00A8A3),
                                size: 24,
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
      ),
    );
  }
}
