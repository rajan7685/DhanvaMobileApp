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

  String valueChoose;

  String gender;
  String patientRelationType;
  List<String> _relationTypes = [];
  String bloodGroupType;
  List<String> _bloodGroupTypes = [];
  TextEditingController _patientNameController;
  TextEditingController _patientAgeController;
  TextEditingController _patientPhoneController;
  TextEditingController _patientEmailController;
  TextEditingController _emergencyPhoneController;
  TextEditingController _heightController;
  TextEditingController _weightController;
  TextEditingController _bgController, _dobController;
  DateTime _dob;
  bool isApiLoading;

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
    _bloodGroupTypes = [];

    isApiLoading = true;
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) => apiCalls(),
    );
    // print(RegExp(
    //         r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
    //     .hasMatch("email@a."));
  }

  void apiCalls() async {
    await _getBloodGroup();
    await _getAndSetRelations();
    await _loadPatientInfo();
    setState(() {
      isApiLoading = false;
    });
  }

  Future<void> _getBloodGroup() {
    _bloodGroupTypes = ['A+', 'B+', 'AB+', 'AB-', 'O+', 'O-', 'A-', 'B-'];
  }

  Future<void> _getAndSetRelations() async {
    String uri = 'http://api2.dhanva.icu/patient/get_relation_constants';
    Response res = await ApiService.dio.get(uri,
        options: Options(headers: {
          'Authorization': SharedPreferenceService.loadString(key: AuthTokenKey)
        }));

    print(res.data['data']);

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
    print('API response : ${res.data}');
    setState(() {
      _patientNameController.text = res.data['name'];
      _patientAgeController.text = res.data['age'];
      _patientPhoneController.text = res.data['phone'].toString();
      _patientEmailController.text = res.data['email'];
      _emergencyPhoneController.text = res.data['emergency_contact'];
      _bgController.text = res.data['bloodGroup'];
      _heightController.text = res.data['height'];
      _weightController.text = res.data['weight'];
      gender = res.data['gender'];
      patientRelationType;
      bloodGroupType = res.data['bloodGroup'] != null
          ? res.data['bloodGroup'].toString().toUpperCase()
          : null;
      _dob = res.data['dob'] != null ? DateTime.parse(res.data['dob']) : null;
      _dobController.text =
          _dob != null ? DateFormat('MMM d, yyyy').format(_dob) : null;
    });
  }

  void _selectDob() async {
    final DateTime pickedDate = await showDatePicker(
        helpText: 'Select your Date of Birth',
        cancelText: 'Cancel',
        confirmText: 'Done',
        context: context,
        initialDate: _dob ??
            DateTime(
                DateTime.now().year, DateTime.now().month, DateTime.now().day),
        firstDate: DateTime(1900),
        lastDate: DateTime(2025));
    if (pickedDate != null && pickedDate != _dob)
      setState(() {
        _dob = pickedDate;
        _dobController.text = DateFormat('MMM d, yyyy').format(_dob);
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
          "dob": DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").format(_dob),
          "phone": _patientPhoneController.text,
          "bloodGroup": bloodGroupType,
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
              (isApiLoading ?? true)
                  ? Align(
                      alignment: Alignment.center,
                      child: CircularProgressIndicator())
                  : Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // forms
                            TextFormField(
                              controller: _patientNameController,
                              validator: (String name) {
                                if (name.isEmpty) return 'Name is Required';
                                return null;
                              },
                              obscureText: false,
                              decoration: InputDecoration(
                                labelText: 'Patient Name',
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
                                                color: Color.fromARGB(
                                                    255, 12, 16, 22),
                                                fontSize: 11,
                                              ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                          child: FlutterFlowRadioButton(
                                        initialValue: gender,
                                        options: ['Male', 'Female'],
                                        onChanged: (value) {
                                          setState(() {
                                            gender = value;
                                          });
                                        },
                                        validator: (gender) {
                                          print(gender == null);
                                          if (gender == null)
                                            return 'Gender is Required';
                                          return null;
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
                                        buttonPosition:
                                            RadioButtonPosition.left,
                                        direction: Axis.horizontal,
                                        radioButtonColor: Color(0xFF00A8A3),
                                        inactiveRadioButtonColor:
                                            Color(0x8A314A51),
                                        toggleable: false,
                                        horizontalAlignment:
                                            WrapAlignment.start,
                                        verticalAlignment:
                                            WrapCrossAlignment.start,
                                      )),
                                      SizedBox(
                                        width: 8,
                                      ),
                                      Expanded(
                                        child: TextFormField(
                                          controller: _patientAgeController,
                                          validator: (String number) {
                                            if (number.isEmpty)
                                              return 'Age is Required';
                                            else if (RegExp(r"/^100|[1-9]?\d$/")
                                                .hasMatch(number))
                                              return 'Please enter the valid Age';
                                            return null;
                                          },
                                          obscureText: false,
                                          decoration: InputDecoration(
                                            labelText: 'Age',
                                            labelStyle:
                                                FlutterFlowTheme.of(context)
                                                    .bodyText1
                                                    .override(
                                                      fontFamily: 'Open Sans',
                                                      color: Color(0xFF9A9A9A),
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                    ),
                                            hintStyle:
                                                FlutterFlowTheme.of(context)
                                                    .bodyText1
                                                    .override(
                                                      fontFamily: 'Open Sans',
                                                      color: Color(0xFF606E87),
                                                      fontWeight:
                                                          FontWeight.normal,
                                                    ),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Color(0xFFC1C1C1),
                                                width: 1,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(16),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Color(0xFFC1C1C1),
                                                width: 1,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(16),
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
                                            return 'Contact is Required';
                                          if (phone.length < 10 ||
                                              phone.length > 11)
                                            return 'Enter valid phone number';
                                          else if (RegExp(r"^[0-9]{11}")
                                              .hasMatch(phone))
                                            return 'Please enter the valid Phone number';
                                          return null;
                                        },
                                        obscureText: false,
                                        decoration: InputDecoration(
                                          labelText: 'Emergency Contact',
                                          labelStyle:
                                              FlutterFlowTheme.of(context)
                                                  .bodyText1
                                                  .override(
                                                    fontFamily: 'Open Sans',
                                                    color: Color(0xFF9A9A9A),
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                  ),
                                          hintStyle:
                                              FlutterFlowTheme.of(context)
                                                  .bodyText1
                                                  .override(
                                                    fontFamily: 'Open Sans',
                                                    color: Color(0xFF606E87),
                                                    fontWeight:
                                                        FontWeight.normal,
                                                  ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color(0xFFC1C1C1),
                                              width: 1,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(16),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color(0xFFC1C1C1),
                                              width: 1,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(16),
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
                                            return 'Phone is Required';
                                          if (phone.length < 10 ||
                                              phone.length > 11)
                                            return 'Must be a valid phone number';
                                          else if (RegExp(r"^[0-9]{11}")
                                              .hasMatch(phone))
                                            return 'Please enter the valid Phone number';

                                          return null;
                                        },
                                        obscureText: false,
                                        decoration: InputDecoration(
                                          labelText: 'Phone',
                                          labelStyle:
                                              FlutterFlowTheme.of(context)
                                                  .bodyText1
                                                  .override(
                                                    fontFamily: 'Open Sans',
                                                    color: Color(0xFF9A9A9A),
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                  ),
                                          hintStyle:
                                              FlutterFlowTheme.of(context)
                                                  .bodyText1
                                                  .override(
                                                    fontFamily: 'Open Sans',
                                                    color: Color(0xFF606E87),
                                                    fontWeight:
                                                        FontWeight.normal,
                                                  ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color(0xFFC1C1C1),
                                              width: 1,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(16),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color(0xFFC1C1C1),
                                              width: 1,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(16),
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
                                            return 'Email is Required';
                                          else if (!RegExp(
                                                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                              .hasMatch(email))
                                            return 'Please enter the valid email';
                                          return null;
                                        },
                                        obscureText: false,
                                        decoration: InputDecoration(
                                          labelText: 'Email',
                                          labelStyle:
                                              FlutterFlowTheme.of(context)
                                                  .bodyText1
                                                  .override(
                                                    fontFamily: 'Open Sans',
                                                    color: Color(0xFF9A9A9A),
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                  ),
                                          hintStyle:
                                              FlutterFlowTheme.of(context)
                                                  .bodyText1
                                                  .override(
                                                    fontFamily: 'Open Sans',
                                                    color: Color(0xFF606E87),
                                                    fontWeight:
                                                        FontWeight.normal,
                                                  ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color(0xFFC1C1C1),
                                              width: 1,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(16),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color(0xFFC1C1C1),
                                              width: 1,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(16),
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
                                        keyboardType:
                                            TextInputType.emailAddress,
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
                                          if (phone.isEmpty) return 'Height*';

                                          return null;
                                        },
                                        obscureText: false,
                                        decoration: InputDecoration(
                                          suffix: Text("cm"),
                                          labelText: 'Height',
                                          labelStyle:
                                              FlutterFlowTheme.of(context)
                                                  .bodyText1
                                                  .override(
                                                    fontFamily: 'Open Sans',
                                                    color: Color(0xFF9A9A9A),
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                  ),
                                          hintStyle:
                                              FlutterFlowTheme.of(context)
                                                  .bodyText1
                                                  .override(
                                                    fontFamily: 'Open Sans',
                                                    color: Color(0xFF606E87),
                                                    fontWeight:
                                                        FontWeight.normal,
                                                  ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color(0xFFC1C1C1),
                                              width: 1,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(16),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color(0xFFC1C1C1),
                                              width: 1,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(16),
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
                                          if (phone.isEmpty) return 'Weight*';

                                          return null;
                                        },
                                        obscureText: false,
                                        decoration: InputDecoration(
                                          suffix: Text("kg"),
                                          labelText: 'Weight',
                                          labelStyle:
                                              FlutterFlowTheme.of(context)
                                                  .bodyText1
                                                  .override(
                                                    fontFamily: 'Open Sans',
                                                    color: Color(0xFF9A9A9A),
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                  ),
                                          hintStyle:
                                              FlutterFlowTheme.of(context)
                                                  .bodyText1
                                                  .override(
                                                    fontFamily: 'Open Sans',
                                                    color: Color(0xFF606E87),
                                                    fontWeight:
                                                        FontWeight.normal,
                                                  ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color(0xFFC1C1C1),
                                              width: 1,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(16),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color(0xFFC1C1C1),
                                              width: 1,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(16),
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

                                      /*Expanded(
                                  child: TextFormField(
                                    controller: _bgController,
                                    validator: (
                                      String phone,
                                    ) {
                                      if (phone.isEmpty) return 'Blood group*';

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
                                  ),
                                ),*/
                                    ],
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 0,
                              width: 3,
                            ),
                            // relation dropdown,
                            Row(
                              children: [
                                Expanded(
                                  child: DropdownButtonFormField(
                                    validator: (String type) {
                                      if (type == null)
                                        return 'Blood group Required';
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.red),
                                          borderRadius: const BorderRadius.all(
                                            const Radius.circular(26),
                                          ),
                                        ),
                                        filled: true,
                                        hintStyle: TextStyle(
                                          color: Color(0xFF9A9A9A),
                                        ),
                                        hintText: "Blood Group",
                                        fillColor: Colors.white),
                                    value: bloodGroupType,
                                    items: _bloodGroupTypes
                                        .map((type) => DropdownMenuItem(
                                              child: Text(type),
                                              value: type,
                                            ))
                                        .toList(),
                                    onChanged: (value) {
                                      setState(() {
                                        bloodGroupType = value;
                                        print(
                                            "blood group on select: $bloodGroupType");
                                      });
                                    },
                                    iconEnabledColor: Color(0xFF606E87),
                                    iconDisabledColor: Color(0xFF606E87),
                                  ),
                                ),
                                SizedBox(
                                  width: 6,
                                ),
                                Expanded(
                                  child: DropdownButtonFormField(
                                    validator: (String type) {
                                      if (type == null)
                                        return 'Relation Type Required';
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.red),
                                          borderRadius: const BorderRadius.all(
                                            const Radius.circular(26),
                                          ),
                                        ),
                                        filled: true,
                                        hintStyle: TextStyle(
                                          color: Color(0xFF9A9A9A),
                                        ),
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
                                ),
                                SizedBox(
                                  width: 8,
                                  height: 90,
                                ),
                              ],
                            ),

                            InkWell(
                              onTap: _selectDob,
                              child: IgnorePointer(
                                child: TextFormField(
                                  controller: _dobController,
                                  validator: (String _selectDob) {
                                    if (_selectDob.isEmpty)
                                      return 'Enter the Date Of Birth';

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
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 18,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 28),
                              child: InkWell(
                                onTap: () async {
                                  if (_formKey.currentState.validate() &&
                                      gender != null) {
                                    await _savePatientDetails();
                                    Navigator.pop(context);
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
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
