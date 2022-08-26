import 'dart:convert';
import 'dart:io';
import 'package:dhanva_mobile_app/global/models/patient_relation.dart';
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
  // List<PlatformFile> _pickedFiles = [];
  DateTime _datetime;
  DateTime _time;

  PlatformFile _selectedFile;
  bool _isFileLoading = false;
  bool _isFileUploading = false;
  Patient patient;
  List<PatientRelation> _relations = [];

  List<DropdownMenuItem<String>> patientNames = [];
  String _selectedPatientId;
  String patientRelationType = "Self";

  Future<void> _loadPatientInformation() async {
    await SharedPreferenceService.init();
    patient = Patient.fromJson(
        jsonDecode(SharedPreferenceService.loadString(key: PatientKey)));
    patientNameController.text = patient.name;
    patientNames.add(DropdownMenuItem(
      child: Text(patient.name),
      value: patient.id,
    ));
//response get
    Response res = await ApiService.dio.get(
        'http://api2.dhanva.icu/patient/getPatientRelations/$pid',
        options: Options(headers: {
          'Authorization': SharedPreferenceService.loadString(key: AuthTokenKey)
        }));

    _relations =
        (res.data as List).map((e) => PatientRelation.fromJson(e)).toList();
    for (PatientRelation relation in _relations) {
      patientNames.add(DropdownMenuItem(
        child: Text(relation.patientName),
        value: relation.patientId,
      ));
    }
    _selectedPatientId = patient.id;
    setState(() {
      // updateUI
    });
  }

  // Future<void> createRecordAndUpload(List<PlatformFile> pickedFiles) async {
  //   List<MultipartFile> uploadableFiles = [];
  //   Map<String, dynamic> fileNameData = {};
  //   Map<String, dynamic> fileMapData = {};

  //   // generate dynamic file names
  //   pickedFiles.asMap().entries.forEach((_fileEntry) {
  //     // print('file${_fileEntry.key} : ${_fileEntry.value}');
  //     fileNameData['file_name[${_fileEntry.key}]'] =
  //         _fileEntry.value.name.split('.')[0];
  //   });

  //   Patient patient = Patient.fromJson(
  //       jsonDecode(SharedPreferenceService.loadString(key: PatientKey)));
  //   await Future.forEach(pickedFiles, (PlatformFile file) async {
  //     uploadableFiles
  //         .add(await MultipartFile.fromFile(file.path, filename: file.name));
  //   });

  //   // generate dynamic keys
  //   uploadableFiles.asMap().entries.forEach((_fileEntry) {
  //     // print('file${_fileEntry.key} : ${_fileEntry.value}');
  //     fileMapData['file1[${_fileEntry.key}]'] = _fileEntry.value;
  //   });

  //   Map<String, dynamic> map = {
  //     "patient_id": patient.id,
  //     "employee_id": patient.id,
  //     "docType": reportTypeController.text ?? "Report",
  //     ...fileNameData,
  //     ...fileMapData,
  //   };

  //   print(map);

  //   FormData _formData = FormData.fromMap(map);

  //   Response res = await ApiService.dio.post(
  //       "http://api2.dhanva.icu/files/uploads",
  //       data: _formData,
  //       options: Options(headers: {
  //         'Authorization': SharedPreferenceService.loadString(key: AuthTokenKey)
  //       }));
  //   print(res.data);
  //   Navigator.pop(context);
  // }

  void _selectReportDate() async {
    final DateTime pickedDate = await showDatePicker(
        helpText: 'Select report date',
        cancelText: 'Cancel',
        confirmText: 'Done',
        context: context,
        initialDate: _datetime ??
            DateTime(
                DateTime.now().year, DateTime.now().month, DateTime.now().day),
        firstDate: DateTime(1900),
        lastDate: DateTime(2025));
    if (pickedDate != null && pickedDate != _datetime)
      setState(() {
        _datetime = pickedDate;
        reportDateController.text = DateFormat('MMM d, yyyy').format(_datetime);
      });
  }

  void _selectReportTime() async {
    final TimeOfDay pickedTime = await showTimePicker(
      initialTime: _time ?? TimeOfDay.now(),
      helpText: 'Select report time',
      cancelText: 'Cancel',
      confirmText: 'Done',
      context: context,
    );
    if (pickedTime != null)
      setState(() {
        _time = DateTime.parse(
            "2000-02-02 ${pickedTime.toString().substring(10, 15)}:00Z");
        reportTimeController.text = DateFormat('h:mm a').format(_time);
      });
  }

  void updateRecord() async {
    String filePath = await _downloadFileAndPreview(autopreview: false);
    if (filePath.isNotEmpty) {
      await deleteRecord(autopop: false);
      String fileUploadUri = 'http://api2.dhanva.icu/files/upload';
      Patient patient = Patient.fromJson(
          jsonDecode(SharedPreferenceService.loadString(key: PatientKey)));
      FormData _formData = FormData.fromMap({
        "patient_id": _selectedPatientId ?? patient.id,
        "employee_id": widget.medicalRecord?.patientId ?? patient.id,
        "docType": reportTypeController.text ?? "Report",
        "file_name": filePath.split('/').last,
        "file1": await MultipartFile.fromFile(filePath,
            filename: filePath.split('/').last)
      });

      Response res = await ApiService.dio.post(fileUploadUri,
          options: Options(headers: {
            'Authorization':
                SharedPreferenceService.loadString(key: AuthTokenKey)
          }),
          data: _formData);
      print(res.data);
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Record updated, Please refresh the page")));
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Error occured")));
    }
  }

  Future<void> uploadFile(PlatformFile file) async {
    String fileUploadUri = 'http://api2.dhanva.icu/files/upload';
    Patient patient = Patient.fromJson(
        jsonDecode(SharedPreferenceService.loadString(key: PatientKey)));
    FormData _formData = FormData.fromMap({
      "patient_id": _selectedPatientId ?? patient.id,
      "employee_id": widget.medicalRecord?.patientId ?? patient.id,
      "docType": reportTypeController.text ?? "Report",
      "file_name": file.name,
      "file1": await MultipartFile.fromFile(file.path, filename: file.name)
    });
    print("sentData $_formData");
    Response res = await ApiService.dio.post(fileUploadUri,
        options: Options(headers: {
          'Authorization': SharedPreferenceService.loadString(key: AuthTokenKey)
        }),
        data: _formData);
    print(res.data);
  }

  Future<void> _pickFiles({bool allowMultiple = false}) async {
    if (!await Permission.storage.status.isGranted) {
      await Permission.storage.request();
    }
    //pick files

    FilePickerResult files = await FilePicker.platform.pickFiles(
      allowMultiple: allowMultiple,
    );

    _selectedFile = files.files.first;

    setState(() {
      //
    });
  }

  Future<void> deleteRecord({bool autopop = true}) async {
    String deleteUri = 'http://api2.dhanva.icu/files/delete/';
    print('$deleteUri${widget.medicalRecord.id}');
    Response res = await ApiService.dio.get(
        '$deleteUri${widget.medicalRecord.id}',
        options: Options(headers: {
          'Authorization': SharedPreferenceService.loadString(key: AuthTokenKey)
        }));
    if (autopop) Navigator.pop(context);
    // print(res.data);
  }

//initialize
  @override
  void initState() {
    super.initState();
    _loadPatientInformation();
    patientNameController = TextEditingController(
        text: widget.newRecord ? '' : widget.medicalRecord.fileName);
    reportTypeController =
        TextEditingController(text: widget.newRecord ? '' : '');
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
    print('mera response ${patientNameController}');
  }

  Future<dynamic> _downloadFileAndPreview({bool autopreview = true}) async {
    Directory appDocDir = await path.getExternalStorageDirectory();
    PermissionStatus stat = await Permission.storage.status;

    if (!stat.isGranted) await Permission.storage.request();

    setState(() {
      _isFileLoading = true;
    });

    String _timeStampName = DateTime.now().millisecondsSinceEpoch.toString();
    List<String> _terms = widget.medicalRecord.filePath.split('/');
    String fileName = _terms[_terms.length - 1];
    print('${appDocDir.path}/$fileName');
    try {
      Response res = await ApiService.dio.download(
          widget.medicalRecord.filePath,
          '${appDocDir.path}/${_timeStampName}_$fileName');
      print(res.data.toString());
      setState(() {
        _isFileLoading = false;
      });
      if (autopreview)
        await OpenFile.open('${appDocDir.path}/${_timeStampName}_$fileName');
      return '${appDocDir.path}/${_timeStampName}_$fileName';
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
            itemCount: 1,
            itemBuilder: (_, int index) {
              if (!widget.newRecord || _selectedFile != null)
                return Padding(
                  padding: const EdgeInsets.only(right: 5),
                  child: Image.asset(
                    'assets/images/Group_607.png',
                    width: 65,
                    height: 65,
                    fit: BoxFit.contain,
                  ),
                );
              if (_selectedFile == null)
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
              return SizedBox();
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
              // TextFormField(
              //   controller: patientNameController,
              //   obscureText: false,
              //   decoration: InputDecoration(
              //     labelText: 'Patient Name',
              //     labelStyle: FlutterFlowTheme.of(context).bodyText1.override(
              //           fontFamily: 'Open Sans',
              //           color: Color(0xFF9A9A9A),
              //         ),
              //     enabledBorder: OutlineInputBorder(
              //       borderSide: BorderSide(
              //         color: Color(0xFFC1C1C1),
              //         width: 1,
              //       ),
              //       borderRadius: BorderRadius.circular(12),
              //     ),
              //     focusedBorder: OutlineInputBorder(
              //       borderSide: BorderSide(
              //         color: Color(0xFFC1C1C1),
              //         width: 1,
              //       ),
              //       borderRadius: BorderRadius.circular(12),
              //     ),
              //     filled: true,
              //     fillColor: Colors.white,
              //   ),
              //   style: FlutterFlowTheme.of(context).bodyText1.override(
              //         fontFamily: 'Open Sans',
              //         color: Color(0xFF485163),
              //         fontWeight: FontWeight.w500,
              //       ),
              // ),
              // DropdownButtonHideUnderline(
              //   child: DropdownButtonFormField(
              //     items: patientNames,
              //     value: _selectedPatientId,

              //     onChanged: (value) {
              //       setState(() {
              //         _selectedPatientId = value;
              //       });
              //       int idx = _relations.indexWhere(
              //           (element) => _selectedPatientId == element.patientId);
              //       patientRelationType =
              //           idx == -1 ? "Self" : _relations[idx].type;
              //       // print(patientRelationType);
              //     },
              //     decoration: InputDecoration(
              //       filled: true,
              //       fillColor: Color(0x00000000),
              //       labelText: 'Patient Name',
              //       // border:
              //     ),
              //   ),
              // ),
              // Padding(
              //   padding: EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
              //   child: TextFormField(
              //     controller: reportTypeController,
              //     enabled: false,
              //     obscureText: false,
              //     decoration: InputDecoration(
              //       labelText: 'Type of scan or test',
              //       labelStyle: FlutterFlowTheme.of(context).bodyText1.override(
              //             fontFamily: 'Open Sans',
              //             color: Color(0xFF9A9A9A),
              //           ),
              //       enabledBorder: OutlineInputBorder(
              //         borderSide: BorderSide(
              //           color: Color(0xFFC1C1C1),
              //           width: 1,
              //         ),
              //         borderRadius: BorderRadius.circular(12),
              //       ),
              //       focusedBorder: OutlineInputBorder(
              //         borderSide: BorderSide(
              //           color: Color(0xFFC1C1C1),
              //           width: 1,
              //         ),
              //         borderRadius: BorderRadius.circular(12),
              //       ),
              //       filled: true,
              //       fillColor: Colors.white,
              //     ),
              //     style: FlutterFlowTheme.of(context).bodyText1.override(
              //           fontFamily: 'Open Sans',
              //           color: Color(0xFF485163),
              //           fontWeight: FontWeight.w500,
              //         ),
              //   ),
              // ),
              // Padding(
              //   padding: EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
              //   child: TextFormField(
              //     controller: doctorNameController,
              //     obscureText: false,
              //     decoration: InputDecoration(
              //       labelText: 'Doctor Name',
              //       labelStyle: FlutterFlowTheme.of(context).bodyText1.override(
              //             fontFamily: 'Open Sans',
              //             color: Color(0xFF9A9A9A),
              //           ),
              //       enabledBorder: OutlineInputBorder(
              //         borderSide: BorderSide(
              //           color: Color(0xFFC1C1C1),
              //           width: 1,
              //         ),
              //         borderRadius: BorderRadius.circular(12),
              //       ),
              //       focusedBorder: OutlineInputBorder(
              //         borderSide: BorderSide(
              //           color: Color(0xFFC1C1C1),
              //           width: 1,
              //         ),
              //         borderRadius: BorderRadius.circular(12),
              //       ),
              //       filled: true,
              //       fillColor: Colors.white,
              //     ),
              //     style: FlutterFlowTheme.of(context).bodyText1.override(
              //           fontFamily: 'Open Sans',
              //           color: Color(0xFF485163),
              //           fontWeight: FontWeight.w500,
              //         ),
              //   ),
              // ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 0, 12, 0),
                        child: InkWell(
                          onTap: _selectReportDate,
                          child: IgnorePointer(
                            child: TextFormField(
                              controller: reportDateController,
                              obscureText: false,
                              decoration: InputDecoration(
                                enabled: true,
                                labelText: 'Report Date',
                                labelStyle: FlutterFlowTheme.of(context)
                                    .bodyText1
                                    .override(
                                      fontFamily: 'Open Sans',
                                      color: Color(0xFF9A9A9A),
                                    ),
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
                              style: FlutterFlowTheme.of(context)
                                  .bodyText1
                                  .override(
                                    fontFamily: 'Open Sans',
                                    color: Color(0xFF485163),
                                    fontWeight: FontWeight.w500,
                                  ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    // Expanded(
                    //   child: Padding(
                    //     padding: EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                    //     child: InkWell(
                    //       onTap: _selectReportTime,
                    //       child: IgnorePointer(
                    //         child: TextFormField(
                    //           controller: reportTimeController,
                    //           enabled: false,
                    //           obscureText: false,
                    //           decoration: InputDecoration(
                    //             enabled: true,
                    //             labelText: 'Report Time',
                    //             labelStyle: FlutterFlowTheme.of(context)
                    //                 .bodyText1
                    //                 .override(
                    //                   fontFamily: 'Open Sans',
                    //                   color: Color(0xFF9A9A9A),
                    //                 ),
                    //             enabledBorder: OutlineInputBorder(
                    //               borderSide: BorderSide(
                    //                 color: Color(0xFFC1C1C1),
                    //                 width: 1,
                    //               ),
                    //               borderRadius: BorderRadius.circular(12),
                    //             ),
                    //             focusedBorder: OutlineInputBorder(
                    //               borderSide: BorderSide(
                    //                 color: Color(0xFFC1C1C1),
                    //                 width: 1,
                    //               ),
                    //               borderRadius: BorderRadius.circular(12),
                    //             ),
                    //             filled: true,
                    //             fillColor: Colors.white,
                    //           ),
                    //           style: FlutterFlowTheme.of(context)
                    //               .bodyText1
                    //               .override(
                    //                 fontFamily: 'Open Sans',
                    //                 color: Color(0xFF485163),
                    //                 fontWeight: FontWeight.w500,
                    //               ),
                    //         ),
                    //       ),
                    //     ),
                    //   ),
                    // ),
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
              if (!widget.newRecord)
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
                          'Download File',
                          style:
                              FlutterFlowTheme.of(context).bodyText1.override(
                                    fontFamily: 'Open Sans',
                                    color: Color(0xFF00A8A3),
                                    fontWeight: FontWeight.w500,
                                  ),
                        ),
                        SizedBox(
                          width: 18,
                        ),
                        if (_isFileLoading)
                          CircularProgressIndicator(
                            strokeWidth: 2,
                          )
                      ],
                    ),
                  ),
                ),
              // if (!widget.newRecord)
              //   Padding(
              //     padding: EdgeInsetsDirectional.fromSTEB(0, 42, 0, 0),
              //     child: Container(
              //       width: MediaQuery.of(context).size.width * 0.78,
              //       height: 55,
              //       decoration: BoxDecoration(
              //         color: Color(0xFF00A8A3),
              //         borderRadius: BorderRadius.circular(24),
              //       ),
              //       child: InkWell(
              //         onTap: updateRecord,
              //         child: Row(
              //           mainAxisSize: MainAxisSize.max,
              //           mainAxisAlignment: MainAxisAlignment.center,
              //           children: [
              //             Text(
              //               'Update Record',
              //               style: FlutterFlowTheme.of(context).title1.override(
              //                     fontFamily: 'Poppins',
              //                     color: Colors.white,
              //                   ),
              //             ),
              //             Padding(
              //               padding:
              //                   EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
              //               child: Image.asset(
              //                 'assets/images/Layer_2.png',
              //                 width: 35,
              //                 height: 35,
              //                 fit: BoxFit.cover,
              //               ),
              //             ),
              //           ],
              //         ),
              //       ),
              //     ),
              //   ),
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
                        setState(() {
                          _isFileUploading = true;
                        });
                        uploadFile(_selectedFile);
                        setState(() {
                          _isFileUploading = false;
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Record Saved")));
                        Navigator.pop(context);
                      },
                      child: !_isFileUploading
                          ? Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Save Record',
                                  style: FlutterFlowTheme.of(context)
                                      .title1
                                      .override(
                                        fontFamily: 'Poppins',
                                        color: Colors.white,
                                      ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      12, 0, 0, 0),
                                  child: Image.asset(
                                    'assets/images/Layer_2.png',
                                    width: 35,
                                    height: 35,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ],
                            )
                          : Center(
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ),
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
                      child: InkWell(
                        onTap: deleteRecord,
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Delete Record',
                              style:
                                  FlutterFlowTheme.of(context).title1.override(
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
                ),
            ],
          ),
        ),
      ),
    );
  }
}
