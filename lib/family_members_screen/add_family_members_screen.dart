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

class AddFamilyMembersScreenWidget extends StatefulWidget {
  const AddFamilyMembersScreenWidget({Key key}) : super(key: key);

  @override
  State<AddFamilyMembersScreenWidget> createState() =>
      _AddFamilyMembersScreenWidgetState();
}

class _AddFamilyMembersScreenWidgetState
    extends State<AddFamilyMembersScreenWidget> {
  String valueChoose;
  final _formKey = GlobalKey<FormState>();
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

  List<String> relationList = [];
  String _patientRelationUpdateApi =
      '${ApiService.protocol}api3.dhanva.icu/patient/update';
  String _patientRelationAddApi =
      '${ApiService.protocol}api3.dhanva.icu/patient/add_relation';
  String _patientRelationConsts =
      '${ApiService.protocol}api3.dhanva.icu/patient/get_relation_constants';

  Future<void> _getBloodGroup() {
    _bloodGroupTypes = ['A+', 'B+', 'AB+', 'AB-', 'O+', 'O-', 'A-', 'B-'];
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
  }

  void apiCalls() async {
    await _getBloodGroup();
    await _loadRelationTypeButton();

    setState(() {
      isApiLoading = false;
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
        _patientAgeController.text =
            (DateTime.now().year - pickedDate.year).toString();
      });
  }

  Future<void> _addMember() async {
    try {
      await SharedPreferenceService.init();
      Patient patient = Patient.fromJson(
          jsonDecode(SharedPreferenceService.loadString(key: PatientKey)));
      print('Sending to $_patientRelationAddApi');
      var d = {
        //
        "name": _patientNameController.text,
        "email": _patientEmailController.text,
        "phone": _patientPhoneController.text,
        "dob": _dob.toUtc().toString(),
        "bloodGroup": bloodGroupType,
        "age": _patientAgeController.text,
        "emergency_contact": _emergencyPhoneController.text,
        "height": _heightController.text,
        "weight": _weightController.text,
        "relation_type": patientRelationType,
        "gender": gender,
        "parent": patient.id
      };
      print("MY request: ${d}");
      Response res = await ApiService.dio.post(_patientRelationAddApi,
          data: d,
          options: Options(headers: {
            'Authorization':
                SharedPreferenceService.loadString(key: AuthTokenKey)
          }));
      print("check add res${res.data}");

      if (res.statusCode == 200) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Member has been added')));
        _patientNameController.clear();
        _patientAgeController.clear();
        _patientPhoneController.clear();
        _patientEmailController.clear();
        _emergencyPhoneController.clear();
        _bgController.clear();
        _heightController.clear();
        _weightController.clear();
        _dobController.clear();
        // gender =
        patientRelationType = null;
        setState(() {
          // update data in ui
        });
      } else if (res.statusCode == 400)
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Please use a djkashksjd')));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Something went wrong : ${e.toString()}')));
    }
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
                  'Family Member',
                  style: FlutterFlowTheme.of(context).bodyText1.override(
                        fontFamily: 'Open Sans',
                        color: Color(0xFF00A8A3),
                        fontSize: 24,
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
                          if (name.isEmpty) return 'Name is Required';
                          return null;
                        },
                        onChanged: (val) {
                          _formKey.currentState.validate();
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
                                  inactiveRadioButtonColor: Color(0x8A314A51),
                                  toggleable: false,
                                  horizontalAlignment: WrapAlignment.start,
                                  verticalAlignment: WrapCrossAlignment.start,
                                )),
                                Expanded(
                                  child: TextFormField(
                                    controller: _patientAgeController,
                                    enabled: false,
                                    validator: (String number) {
                                      if (number.isEmpty)
                                        return 'Age is Required';
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
                                      return 'Contact is Required';
                                    if (phone.length < 10)
                                      return 'Enter valid number';
                                    if (phone.length > 11)
                                      return 'Enter valid number';

                                    return null;
                                  },
                                  maxLength: 11,
                                  onChanged: (val) {
                                    _formKey.currentState.validate();
                                  },
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    errorMaxLines: 2,
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
                                      return 'Phone No is Required';
                                    if (phone.length < 10)
                                      return 'Enter valid number';
                                    if (phone.length > 11)
                                      return 'Enter valid number';

                                    return null;
                                  },
                                  maxLength: 11,
                                  onChanged: (val) {
                                    _formKey.currentState.validate();
                                  },
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    errorMaxLines: 2,
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
                                      return 'Email is Required';
                                    else if (!RegExp(
                                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                        .hasMatch(email))
                                      return 'Please enter the valid email';
                                    return null;
                                  },
                                  onChanged: (val) {
                                    _formKey.currentState.validate();
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
                                    if (phone.isEmpty) return 'Height*';

                                    return null;
                                  },
                                  onChanged: (val) {
                                    _formKey.currentState.validate();
                                  },
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    suffix: Text("cm"),
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
                                    if (phone.isEmpty) return 'Weight*';

                                    return null;
                                  },
                                  onChanged: (val) {
                                    _formKey.currentState.validate();
                                  },
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    suffix: Text('kg'),
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
                                /* Expanded(
                                    child: TextFormField(
                                  controller: _bgController,
                                  validator: (String phone) {
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
                                )),*/
                              ],
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 0,
                      ),
                      // relation dropdown,
                      Row(
                        children: [
                          Expanded(
                            child: DropdownButtonFormField(
                              validator: (String type) {
                                if (type == null) return 'Blood group Required';
                                return null;
                              },
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.red),
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
                                    borderSide: BorderSide(color: Colors.red),
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
                          ),
                          SizedBox(
                            height: 90,
                          ),
                        ],
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
                            onChanged: (val) {
                              _formKey.currentState.validate();
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
                          onTap: () {
                            if (_formKey.currentState.validate()) {
                              if (gender == null)
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content:
                                            Text('Please select your gender')));
                              Navigator.pop(context);
                              // Add member call here
                              if (gender != null) {
                                print('all OK');
                                _addMember();
                              }
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
                                  'Add',
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
                      ),
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
