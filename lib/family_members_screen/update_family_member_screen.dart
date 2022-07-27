import 'dart:convert';

import 'package:dhanva_mobile_app/components/notification_icon_button.dart';
import 'package:dhanva_mobile_app/flutter_flow/flutter_flow_radio_button.dart';
import 'package:dhanva_mobile_app/flutter_flow/flutter_flow_theme.dart';
import 'package:dhanva_mobile_app/flutter_flow/flutter_flow_util.dart';
import 'package:dhanva_mobile_app/global/models/patient.dart';
import 'package:dhanva_mobile_app/global/services/api_services/api_service_base.dart';
import 'package:dhanva_mobile_app/global/services/shared_preference_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class UpdateFamilyMemberWidget extends StatefulWidget {
  final Map<String, dynamic> memberData;
  const UpdateFamilyMemberWidget({Key key, @required this.memberData})
      : super(key: key);

  @override
  State<UpdateFamilyMemberWidget> createState() =>
      _UpdateFamilyMemberWidgetState();
}

class _UpdateFamilyMemberWidgetState extends State<UpdateFamilyMemberWidget> {
  String gender;
  final _formKey = GlobalKey<FormState>();
  String patientRelationType;
  TextEditingController _patientNameController;
  TextEditingController _patientAgeController;
  TextEditingController _patientPhoneController;
  TextEditingController _patientEmailController;
  TextEditingController _emergencyPhoneController;
  TextEditingController _heightController;
  TextEditingController _weightController;
  TextEditingController _bgController, _dobController;
  DateTime _dob;
  Map<String, dynamic> memberDetails;
  List<String> relationList = [];
  String _patientRelationUpdateApi = 'http://api3.dhanva.icu/patient/update';
  String _patientRelationConsts =
      'http://api3.dhanva.icu/patient/get_relation_constants';
  String _patientDetailsApi =
      'http://api3.dhanva.icu/patient/getPatientDetails/';

  void _feedValuestoForm() {
    _patientNameController.text = memberDetails['name'];
    _patientAgeController.text = memberDetails['age'];
    _patientPhoneController.text = memberDetails['phone'].toString();
    _patientEmailController.text = memberDetails['email'];
    _emergencyPhoneController.text = memberDetails['emergency_contact'];
    _heightController.text = memberDetails['height'];
    _weightController.text = memberDetails['weight'];
    _bgController.text = memberDetails['bloodGroup'];
    _dobController.text = memberDetails['dob'] != null
        ? DateFormat('EEEE MMM d, yyyy')
            .format(DateTime.parse(memberDetails['dob']))
        : '';
    gender = memberDetails['gender'];
    setState(() {
      // update the values
      patientRelationType = widget.memberData['type'];
    });
  }

  Future<void> _updateMemberDetails() async {
    await SharedPreferenceService.init();
    Patient patient = Patient.fromJson(
        jsonDecode(SharedPreferenceService.loadString(key: PatientKey)));
    print("""
          "id": ${widget.memberData['user']['id']},
          "name": ${_patientNameController.text},
          "email": ${_patientEmailController.text},
          "phone": ${_patientPhoneController.text},
          "dob": ${_dobController.text},
          "bloodGroup": ${_bgController.text},
          "age": ${_patientAgeController.text},
          "emergency_contact": ${_emergencyPhoneController.text},
          "height": ${_heightController.text},
          "weight": ${_weightController.text},
          "relation_type": $patientRelationType,
          "gender": $gender
      """);
    Response res = await ApiService.dio.post(_patientRelationUpdateApi,
        data: {
          "id": widget.memberData['user']['_id'],
          "name": _patientNameController.text,
          "email": _patientEmailController.text,
          "phone": _patientPhoneController.text,
          "dob": _dobController.text,
          "bloodGroup": _bgController.text,
          "age": _patientAgeController.text,
          "latlong": "11.596294,78.598915",
          "emergency_contact": _emergencyPhoneController.text,
          "marital_status": "married",
          "height": _heightController.text,
          "weight": _weightController.text,
          "relation_type": patientRelationType,
          "gender": gender
        },
        options: Options(headers: {
          'Authorization': SharedPreferenceService.loadString(key: AuthTokenKey)
        }));
    // print(res.data);
  }

  Future<void> _loadMemberDetails() async {
    await SharedPreferenceService.init();
    Patient patient = Patient.fromJson(
        jsonDecode(SharedPreferenceService.loadString(key: PatientKey)));
    print("$_patientDetailsApi${widget.memberData['user']['_id']}");
    Response res = await ApiService.dio.get(
        "$_patientDetailsApi${widget.memberData['user']['_id']}",
        options: Options(headers: {
          'Authorization': SharedPreferenceService.loadString(key: AuthTokenKey)
        }));
    memberDetails = res.data;
    _feedValuestoForm();
  }

  Future<void> _loadRelationTypeButton() async {
    await SharedPreferenceService.init();
    Patient patient = Patient.fromJson(
        jsonDecode(SharedPreferenceService.loadString(key: PatientKey)));
    Response res = await ApiService.dio.get(_patientRelationConsts,
        options: Options(headers: {
          'Authorization': SharedPreferenceService.loadString(key: AuthTokenKey)
        }));
    setState(() {
      for (var a in res.data['data']) {
        relationList.add(a);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _loadMemberDetails();
    _loadRelationTypeButton();
    patientRelationType = null;
    gender =
        '${widget.memberData['user']['gender'][0].toString().toUpperCase()}${widget.memberData['user']['gender'].toString().substring(1)}';
    _patientNameController = TextEditingController()
      ..text = widget.memberData['user']['name'];
    _patientAgeController = TextEditingController();
    _patientPhoneController = TextEditingController();
    _patientEmailController = TextEditingController();
    _emergencyPhoneController = TextEditingController();
    _bgController = TextEditingController();
    _heightController = TextEditingController();
    _weightController = TextEditingController();
    _dobController = TextEditingController();
  }

  void _selectDob() async {
    final DateTime pickedDate = await showDatePicker(
        helpText: 'Select your Date of Birth',
        cancelText: 'Cancel',
        confirmText: 'Done',
        context: context,
        initialDate: _dob ?? DateTime(2000),
        firstDate: DateTime(1900),
        lastDate: DateTime(2025));
    if (pickedDate != null && pickedDate != _dob)
      setState(() {
        _dob = pickedDate;
        _dobController.text = DateFormat('EEEE MMM d, yyyy').format(_dob);
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // AppBar
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(12, 8, 12, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  // mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.arrow_back_rounded,
                        color: Color(0xFF00A8A3),
                        size: 38,
                      ),
                    ),
                    Spacer(),
                    SizedBox(
                      width: 12,
                    ),
                    NotificationIconButton()
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(8, 12, 0, 0),
                child: Text(
                  'Update Family Member',
                  style: FlutterFlowTheme.of(context).bodyText1.override(
                        fontFamily: 'Open Sans',
                        color: Color(0xFF00A8A3),
                        fontSize: 28,
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 14, vertical: 18),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // forms
                      TextFormField(
                        controller: _patientNameController,
                        validator: (String name) {
                          if (name.isEmpty) return 'Name cannot be empty';
                          return null;
                        },
                        obscureText: false,
                        decoration: InputDecoration(
                          labelText: 'Patient Name',
                          labelStyle:
                              FlutterFlowTheme.of(context).bodyText1.override(
                                    fontFamily: 'Open Sans',
                                    color: Color(0xFF9A9A9A),
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                  ),
                          hintStyle:
                              FlutterFlowTheme.of(context).bodyText1.override(
                                    fontFamily: 'Open Sans',
                                    color: Color(0xFF606E87),
                                    fontWeight: FontWeight.normal,
                                  ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFFC1C1C1),
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFFC1C1C1),
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                        style: FlutterFlowTheme.of(context).bodyText1.override(
                              fontFamily: 'Open Sans',
                              color: Color(0xFF606E87),
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                        textAlign: TextAlign.start,
                        keyboardType: TextInputType.text,
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      SizedBox(
                        width: double.maxFinite,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 12),
                              child: Row(
                                children: [
                                  Text(
                                    'Gender',
                                    style: FlutterFlowTheme.of(context)
                                        .bodyText1
                                        .override(
                                          fontFamily: 'Open Sans',
                                          color: Color(0xFF606E87),
                                          fontSize: 11,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                Expanded(
                                    flex: 2,
                                    child: FlutterFlowRadioButton(
                                      initialValue: gender,
                                      options: ['Male', 'Female'],
                                      onChanged: (value) {
                                        setState(() {
                                          gender = value;
                                        });
                                      },
                                      optionHeight: 25,
                                      textStyle: FlutterFlowTheme.of(context)
                                          .bodyText1
                                          .override(
                                            fontFamily: 'Open Sans',
                                            color: Color(0xFF606E87),
                                          ),
                                      selectedTextStyle:
                                          FlutterFlowTheme.of(context)
                                              .bodyText1
                                              .override(
                                                fontFamily: 'Open Sans',
                                                color: Color(0xFF606E87),
                                              ),
                                      buttonPosition: RadioButtonPosition.left,
                                      direction: Axis.horizontal,
                                      radioButtonColor: Color(0xFF00A8A3),
                                      inactiveRadioButtonColor: Colors.white,
                                      toggleable: false,
                                      horizontalAlignment: WrapAlignment.start,
                                      verticalAlignment:
                                          WrapCrossAlignment.start,
                                    )),
                                Expanded(
                                  child: TextFormField(
                                    controller: _patientAgeController,
                                    validator: (String number) {
                                      if (number.isEmpty)
                                        return 'Age cannot be empty';
                                      return null;
                                    },
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      labelText: 'Age',
                                      labelStyle: FlutterFlowTheme.of(context)
                                          .bodyText1
                                          .override(
                                            fontFamily: 'Open Sans',
                                            color: Color(0xFF9A9A9A),
                                            fontSize: 14,
                                            fontWeight: FontWeight.normal,
                                          ),
                                      hintStyle: FlutterFlowTheme.of(context)
                                          .bodyText1
                                          .override(
                                            fontFamily: 'Open Sans',
                                            color: Color(0xFF606E87),
                                            fontWeight: FontWeight.normal,
                                          ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0xFFC1C1C1),
                                          width: 1,
                                        ),
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0xFFC1C1C1),
                                          width: 1,
                                        ),
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                      filled: true,
                                      fillColor: Colors.white,
                                    ),
                                    style: FlutterFlowTheme.of(context)
                                        .bodyText1
                                        .override(
                                          fontFamily: 'Open Sans',
                                          color: Color(0xFF606E87),
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                        ),
                                    textAlign: TextAlign.start,
                                    keyboardType: TextInputType.number,
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 12,
                            ),
                            Row(
                              children: [
                                Expanded(
                                    child: TextFormField(
                                  controller: _emergencyPhoneController,
                                  validator: (String phone) {
                                    if (phone.isEmpty)
                                      return 'Contact cannot be empty';
                                    if (phone.length != 10)
                                      return 'Must be a valid phone number';
                                    return null;
                                  },
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    prefix: Text('+91  '),
                                    labelText: 'Emergency Contact',
                                    labelStyle: FlutterFlowTheme.of(context)
                                        .bodyText1
                                        .override(
                                          fontFamily: 'Open Sans',
                                          color: Color(0xFF9A9A9A),
                                          fontSize: 14,
                                          fontWeight: FontWeight.normal,
                                        ),
                                    hintStyle: FlutterFlowTheme.of(context)
                                        .bodyText1
                                        .override(
                                          fontFamily: 'Open Sans',
                                          color: Color(0xFF606E87),
                                          fontWeight: FontWeight.normal,
                                        ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0xFFC1C1C1),
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0xFFC1C1C1),
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    filled: true,
                                    fillColor: Colors.white,
                                  ),
                                  style: FlutterFlowTheme.of(context)
                                      .bodyText1
                                      .override(
                                        fontFamily: 'Open Sans',
                                        color: Color(0xFF606E87),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                      ),
                                  textAlign: TextAlign.start,
                                  keyboardType: TextInputType.number,
                                )),
                                SizedBox(
                                  width: 8,
                                ),
                                Expanded(
                                    child: TextFormField(
                                  controller: _patientPhoneController,
                                  validator: (String phone) {
                                    if (phone.isEmpty)
                                      return 'Phone cannot be empty';
                                    if (phone.length != 10)
                                      return 'Must be a valid phone number';
                                    return null;
                                  },
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    prefix: Text('+91  '),
                                    labelText: 'Phone',
                                    labelStyle: FlutterFlowTheme.of(context)
                                        .bodyText1
                                        .override(
                                          fontFamily: 'Open Sans',
                                          color: Color(0xFF9A9A9A),
                                          fontSize: 14,
                                          fontWeight: FontWeight.normal,
                                        ),
                                    hintStyle: FlutterFlowTheme.of(context)
                                        .bodyText1
                                        .override(
                                          fontFamily: 'Open Sans',
                                          color: Color(0xFF606E87),
                                          fontWeight: FontWeight.normal,
                                        ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0xFFC1C1C1),
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0xFFC1C1C1),
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    filled: true,
                                    fillColor: Colors.white,
                                  ),
                                  style: FlutterFlowTheme.of(context)
                                      .bodyText1
                                      .override(
                                        fontFamily: 'Open Sans',
                                        color: Color(0xFF606E87),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                      ),
                                  textAlign: TextAlign.start,
                                  keyboardType: TextInputType.number,
                                )),
                              ],
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Row(
                              children: [
                                Expanded(
                                    child: TextFormField(
                                  controller: _patientEmailController,
                                  validator: (String email) {
                                    if (email.isEmpty)
                                      return 'Email cannot be empty';
                                    return null;
                                  },
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    labelText: 'Email',
                                    labelStyle: FlutterFlowTheme.of(context)
                                        .bodyText1
                                        .override(
                                          fontFamily: 'Open Sans',
                                          color: Color(0xFF9A9A9A),
                                          fontSize: 14,
                                          fontWeight: FontWeight.normal,
                                        ),
                                    hintStyle: FlutterFlowTheme.of(context)
                                        .bodyText1
                                        .override(
                                          fontFamily: 'Open Sans',
                                          color: Color(0xFF606E87),
                                          fontWeight: FontWeight.normal,
                                        ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0xFFC1C1C1),
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0xFFC1C1C1),
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    filled: true,
                                    fillColor: Colors.white,
                                  ),
                                  style: FlutterFlowTheme.of(context)
                                      .bodyText1
                                      .override(
                                        fontFamily: 'Open Sans',
                                        color: Color(0xFF606E87),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                      ),
                                  textAlign: TextAlign.start,
                                  keyboardType: TextInputType.emailAddress,
                                ))
                              ],
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Row(
                              children: [
                                Expanded(
                                    child: TextFormField(
                                  controller: _heightController,
                                  validator: (String phone) {
                                    if (phone.isEmpty)
                                      return 'Height cannot be empty';

                                    return null;
                                  },
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    labelText: 'Height',
                                    labelStyle: FlutterFlowTheme.of(context)
                                        .bodyText1
                                        .override(
                                          fontFamily: 'Open Sans',
                                          color: Color(0xFF9A9A9A),
                                          fontSize: 14,
                                          fontWeight: FontWeight.normal,
                                        ),
                                    hintStyle: FlutterFlowTheme.of(context)
                                        .bodyText1
                                        .override(
                                          fontFamily: 'Open Sans',
                                          color: Color(0xFF606E87),
                                          fontWeight: FontWeight.normal,
                                        ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0xFFC1C1C1),
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0xFFC1C1C1),
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    filled: true,
                                    fillColor: Colors.white,
                                  ),
                                  style: FlutterFlowTheme.of(context)
                                      .bodyText1
                                      .override(
                                        fontFamily: 'Open Sans',
                                        color: Color(0xFF606E87),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                      ),
                                  textAlign: TextAlign.start,
                                  keyboardType: TextInputType.number,
                                )),
                                SizedBox(
                                  width: 6,
                                ),
                                Expanded(
                                    child: TextFormField(
                                  controller: _weightController,
                                  validator: (String phone) {
                                    if (phone.isEmpty)
                                      return 'Weight cannot be empty';

                                    return null;
                                  },
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    labelText: 'Weight',
                                    labelStyle: FlutterFlowTheme.of(context)
                                        .bodyText1
                                        .override(
                                          fontFamily: 'Open Sans',
                                          color: Color(0xFF9A9A9A),
                                          fontSize: 14,
                                          fontWeight: FontWeight.normal,
                                        ),
                                    hintStyle: FlutterFlowTheme.of(context)
                                        .bodyText1
                                        .override(
                                          fontFamily: 'Open Sans',
                                          color: Color(0xFF606E87),
                                          fontWeight: FontWeight.normal,
                                        ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0xFFC1C1C1),
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0xFFC1C1C1),
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    filled: true,
                                    fillColor: Colors.white,
                                  ),
                                  style: FlutterFlowTheme.of(context)
                                      .bodyText1
                                      .override(
                                        fontFamily: 'Open Sans',
                                        color: Color(0xFF606E87),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                      ),
                                  textAlign: TextAlign.start,
                                  keyboardType: TextInputType.number,
                                )),
                                SizedBox(
                                  width: 6,
                                ),
                                Expanded(
                                    child: TextFormField(
                                  controller: _bgController,
                                  validator: (String phone) {
                                    if (phone.isEmpty)
                                      return 'Blood group cannot be empty';

                                    return null;
                                  },
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    labelText: 'Blood group',
                                    labelStyle: FlutterFlowTheme.of(context)
                                        .bodyText1
                                        .override(
                                          fontFamily: 'Open Sans',
                                          color: Color(0xFF9A9A9A),
                                          fontSize: 14,
                                          fontWeight: FontWeight.normal,
                                        ),
                                    hintStyle: FlutterFlowTheme.of(context)
                                        .bodyText1
                                        .override(
                                          fontFamily: 'Open Sans',
                                          color: Color(0xFF606E87),
                                          fontWeight: FontWeight.normal,
                                        ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0xFFC1C1C1),
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0xFFC1C1C1),
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    filled: true,
                                    fillColor: Colors.white,
                                  ),
                                  style: FlutterFlowTheme.of(context)
                                      .bodyText1
                                      .override(
                                        fontFamily: 'Open Sans',
                                        color: Color(0xFF606E87),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                      ),
                                  textAlign: TextAlign.start,
                                  keyboardType: TextInputType.text,
                                )),
                              ],
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      DropdownButtonFormField(
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.red),
                              borderRadius: const BorderRadius.all(
                                const Radius.circular(26),
                              ),
                            ),
                            filled: true,
                            hintStyle: TextStyle(color: Color(0xFF606E87)),
                            hintText: "Relation Type",
                            fillColor: Colors.white),
                        value: patientRelationType,
                        items: relationList
                            .map((String type) => DropdownMenuItem(
                                  child: Text(type),
                                  value: type,
                                ))
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            patientRelationType = value;
                          });
                        },
                        iconEnabledColor: Color(0xFF606E87),
                        iconDisabledColor: Color(0xFF606E87),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      InkWell(
                        onTap: () {
                          _selectDob();
                        },
                        child: IgnorePointer(
                          child: TextFormField(
                            controller: _dobController,
                            validator: (String relation) {
                              if (relation.isEmpty)
                                return 'Please provide your date of birth';
                              return null;
                            },
                            obscureText: false,
                            decoration: InputDecoration(
                              labelText: 'DOB',
                              labelStyle: FlutterFlowTheme.of(context)
                                  .bodyText1
                                  .override(
                                    fontFamily: 'Open Sans',
                                    color: Color(0xFF9A9A9A),
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                  ),
                              hintStyle: FlutterFlowTheme.of(context)
                                  .bodyText1
                                  .override(
                                    fontFamily: 'Open Sans',
                                    color: Color(0xFF606E87),
                                    fontWeight: FontWeight.normal,
                                  ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0xFFC1C1C1),
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0xFFC1C1C1),
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              filled: true,
                              fillColor: Colors.white,
                            ),
                            style:
                                FlutterFlowTheme.of(context).bodyText1.override(
                                      fontFamily: 'Open Sans',
                                      color: Color(0xFF606E87),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                            textAlign: TextAlign.start,
                            keyboardType: TextInputType.text,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 18,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 28),
                        child: InkWell(
                          onTap: () async {
                            _updateMemberDetails();
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Data updated')));
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: Color(0xff00A8A3),
                                borderRadius: BorderRadius.circular(22)),
                            padding: EdgeInsets.symmetric(
                                horizontal: 8, vertical: 9),
                            width: double.maxFinite,

                            // height: 25,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Save',
                                  style: TextStyle(
                                      fontFamily: 'Open Sans',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
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
