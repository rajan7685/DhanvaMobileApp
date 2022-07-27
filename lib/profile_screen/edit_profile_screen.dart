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
import 'package:flutter/widgets.dart';

class EditProfileScreenWidget extends StatefulWidget {
  const EditProfileScreenWidget({Key key}) : super(key: key);

  @override
  State<EditProfileScreenWidget> createState() =>
      _EditProfileScreenWidgetState();
}

class _EditProfileScreenWidgetState extends State<EditProfileScreenWidget> {
  final _formKey = GlobalKey<FormState>();

  String gender;
  String patientRelationType;
  List<String> _relationTypes = [];
  TextEditingController _patientNameController;
  TextEditingController _patientAgeController;
  TextEditingController _patientPhoneController;
  TextEditingController _patientEmailController;
  TextEditingController _emergencyPhoneController;
  TextEditingController _heightController;
  TextEditingController _weightController;
  TextEditingController _bgController, _dobController;
  DateTime _dob;

  //init
  @override
  void initState() {
    super.initState();
    _patientNameController = TextEditingController();
    _patientAgeController = TextEditingController();
    _patientPhoneController = TextEditingController();
    _patientEmailController = TextEditingController();
    _emergencyPhoneController = TextEditingController();
    _bgController = TextEditingController();
    _heightController = TextEditingController();
    _weightController = TextEditingController();
    _dobController = TextEditingController();
    _relationTypes = [];
    _getAndSetRelations();
    _loadPatientInfo();
  }

  Future<void> _getAndSetRelations() async {
    String uri = 'http://api2.dhanva.icu/patient/get_relation_constants';
    Response res = await ApiService.dio.get(uri,
        options: Options(headers: {
          'Authorization': SharedPreferenceService.loadString(key: AuthTokenKey)
        }));

    (res.data['data'] as List).forEach((type) => _relationTypes.add(type));
    setState(() {
      // updateUI
    });
  }

  Future<void> _loadPatientInfo() async {
    String patientId = Patient.fromJson(
            jsonDecode(SharedPreferenceService.loadString(key: PatientKey)))
        .id;
    String uri = 'http://api2.dhanva.icu/patient/getPatientDetails/$patientId';
    Response res = await ApiService.dio.get(uri,
        options: Options(headers: {
          'Authorization': SharedPreferenceService.loadString(key: AuthTokenKey)
        }));
    if (res.data['name'] == null)
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Please fill all of your details first')));
    print(res.data['gender']);
    setState(() {
      _patientNameController.text = res.data['name'];
      _patientAgeController.text = res.data['age'];
      _patientPhoneController.text = res.data['phone'].toString();
      _patientEmailController.text = res.data['email'];
      _emergencyPhoneController.text = res.data['emergency_contact'];
      _bgController.text = res.data['name'];
      _heightController.text = res.data['height'];
      _weightController.text = res.data['weight'];
      gender = res.data['gender'];
      patientRelationType;
      _dob = res.data['dob'] != null ? DateTime.parse(res.data['dob']) : null;
    });
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

  Future<void> _savePatientDetails() async {
    //
    String _uri = 'http://api2.dhanva.icu/patient/update';
    String patientId = Patient.fromJson(
            jsonDecode(SharedPreferenceService.loadString(key: PatientKey)))
        .id;
    Response res = await ApiService.dio.post(_uri,
        options: Options(headers: {
          'Authorization': SharedPreferenceService.loadString(key: AuthTokenKey)
        }),
        data: {
          "name": _patientNameController.text,
          "email": _patientEmailController.text,
          "dob": _dobController.text,
          "phone": _patientPhoneController.text,
          "bloodGroup": _bgController.text,
          "age": _patientAgeController.text,
          "emergency_contact": _emergencyPhoneController.text,
          "height": _heightController.text,
          "weight": _weightController.text,
          "relation_type": patientRelationType,
          "gender": gender,
          // patient id
          "id": patientId,
        });
    print('update response : ${res.data}');
    SharedPreferenceService.saveString(
        key: PatientKey, value: jsonEncode(res.data));
    return res.data;
  }

  //dispose

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 6,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6),
                child: Row(
                  //mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () async {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.arrow_back_sharp,
                        color: Color(0xff00A8A3),
                        size: 32,
                      ),
                    ),
                    NotificationIconButton()
                  ],
                ),
              ),
              SizedBox(
                height: 14,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  'Edit Profile',
                  style: TextStyle(
                      color: Color(0xff00A8A3),
                      fontSize: 26,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
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
                      // relation dropdown,
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
                        items: _relationTypes
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
                        onTap: _selectDob,
                        child: IgnorePointer(
                          child: TextFormField(
                            controller: _dobController,
                            validator: (String _) {
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
                            if (_formKey.currentState.validate() &&
                                gender != null) {
                              await _savePatientDetails();
                              Navigator.pop(context);
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                  content: Text(
                                      'Please fill all the fields properly')));
                            }
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
