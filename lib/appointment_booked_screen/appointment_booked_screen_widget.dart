import 'dart:convert';

import 'package:dhanva_mobile_app/components/next_icon_button_widget.dart';
import 'package:dhanva_mobile_app/flutter_flow/flutter_flow_radio_button.dart';
import 'package:dhanva_mobile_app/global/models/doctor.dart';
import 'package:dhanva_mobile_app/global/models/patient.dart';
import 'package:dhanva_mobile_app/global/services/api_services/api_service_base.dart';
import 'package:dhanva_mobile_app/global/services/api_services/doctors_details_service.dart';
import 'package:dhanva_mobile_app/global/services/shared_preference_service.dart';
import 'package:dhanva_mobile_app/home_screen/models/quick_service_ui_model.dart';
import 'package:dio/dio.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import '../booking_success_screen/booking_success_screen_widget.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

class AppointmentBookedScreenWidget extends StatefulWidget {
  final String doctorId;
  final String hospitalId;
  final String doctorName;
  final DateTime date;
  final String timeString;
  final String symtopms;
  final String patientId;
  final String patientRelationType;
  final QuickServiceUiModel service;
  final bool isOnline;

  const AppointmentBookedScreenWidget(
      {Key key,
      @required this.date,
      @required this.hospitalId,
      @required this.patientRelationType,
      @required this.symtopms,
      @required this.patientId,
      @required this.timeString,
      @required this.doctorName,
      @required this.doctorId,
      @required this.service,
      this.isOnline = true,
      Map<String, dynamic> data})
      : super(key: key);

  @override
  _AppointmentBookedScreenWidgetState createState() =>
      _AppointmentBookedScreenWidgetState();
}

class _AppointmentBookedScreenWidgetState
    extends State<AppointmentBookedScreenWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  Razorpay _rzPay;
  String _paymentValueType;

  Patient p = Patient.fromJson(
      jsonDecode(SharedPreferenceService.loadString(key: PatientKey)));

  bool isDataLoading = true;

  Future<void> _bookAppointment({@required String transactionId}) async {
    Response res = await ApiService.dio.post(
        '${ApiService.protocol}api2.dhanva.icu/payment/add',
        options: Options(headers: {
          'Authorization': SharedPreferenceService.loadString(key: AuthTokenKey)
        }),
        data: {
          "amount": widget.service.amount,
          "transaction_id": transactionId,
          // two params (more) ->
          "meta_info": {
            "payment_type": _paymentValueType,
            "booking_type": widget.isOnline ? "Online" : "Offline",
            "relation_type": widget.patientRelationType
          },
          "payment_status_string": "Success",
          "patient_id": widget.patientId,
          "is_online": widget.isOnline,
          "status": 0
        });
    //${ApiService.protocol}ae7a-49-204-130-5.ngrok.io
    print("date format check ${widget.date.toString().split(' ')[0]}");
    Response bookingRes = await ApiService.dio.post(
        '${ApiService.protocol}api2.dhanva.icu/appointment/book',
        options: Options(headers: {
          'Authorization': SharedPreferenceService.loadString(key: AuthTokenKey)
        }),
        data: {
          "symptoms": widget.symtopms,
          "appointmentDate": widget.date.toString().split(' ')[0],
          "patient_id": widget.patientId,
          "name": widget.doctorName,
          "time_slot": widget.timeString,
          "payment_info": res.data['_id'],
          "doctor": widget.doctorId,
          "serviceId": widget.service.id,
          "hospital_id": widget.hospitalId
        });
    print('Booking response > ${bookingRes.data}');
  }

  Future<void> _makePayment() async {
    var options = {
      'key': 'rzp_test_xbbqVc7yVFG9f6',
      'amount': widget.service.amount * 100,
      'name': widget.service.name,
      'description': 'Service',
      'prefill': {'contact': p.phone, 'email': p.email}
    };
    try {
      _rzPay.open(options);
    } catch (err) {
      print(err.toString());
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) async {
    print('Payment success : $response');
    await _bookAppointment(transactionId: response.paymentId);
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (_) => BookingSuccessScreenWidget()));
  }

  void _handlePaymentError(PaymentFailureResponse response) async {
    print('Payment Failure : ${response.code} ${response.message}');
    Map<String, dynamic> res = jsonDecode(response.message);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
            "Payment failed : ${res['error']['description']}\nPlease try again")));
  }

  void _handleExternalWallet(ExternalWalletResponse response) async {
    print('Payment external : $response');
  }

  @override
  void initState() {
    super.initState();
    print(widget.timeString);
    _rzPay = Razorpay();
    _rzPay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _rzPay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _rzPay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    print("raw date ${widget.date.toString()}");
    print("Formatted date ${widget.date.toString().split(' ')[0]}");
  }

  @override
  void dispose() {
    super.dispose();
    //
  }

  @override
  Widget build(BuildContext context) {
    print(widget.isOnline);
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: Color(0xFFEDF3F3),
        iconTheme: IconThemeData(color: Color(0xFF00A8A3)),
        automaticallyImplyLeading: true,
        actions: [],
        centerTitle: true,
        elevation: 0,
      ),
      backgroundColor: Color(0xFFEDF3F3),
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(12, 9, 12, 0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Align(
                  alignment: AlignmentDirectional(-1, 0),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                    child: Text(
                      'Your Appointment',
                      style: FlutterFlowTheme.of(context).bodyText1.override(
                            fontFamily: 'Open Sans',
                            color: Color(0xFF606E87),
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),
                ),
                Align(
                  alignment: AlignmentDirectional(-1, 0),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                    child: Text(
                      'Will be booked with',
                      style: FlutterFlowTheme.of(context).bodyText1.override(
                            fontFamily: 'Open Sans',
                            color: Color(0xFF606E87),
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),
                ),
                Card(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(12, 12, 12, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: Image.network(
                                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR0kigo369AKCLUVSYPBs4K54t0WQbsfL9Lmw&usqp=CAU',
                                width: 80,
                                height: 80,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Dr.${widget.doctorName}",
                                      style: FlutterFlowTheme.of(context)
                                          .bodyText1
                                          .override(
                                            fontFamily: 'Poppins',
                                            color: Color(0xFF606E87),
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600,
                                          ),
                                    ),
                                    Text(
                                      "",
                                      //widget.education,
                                      style: FlutterFlowTheme.of(context)
                                          .bodyText1
                                          .override(
                                            fontFamily: 'Open Sans',
                                            color: Color(0xFF606E87),
                                            fontSize: 12,
                                          ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 12, 0, 0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0, 0, 0, 4),
                                            child: Icon(
                                              Icons.calendar_today,
                                              color: Color(0xFF606E87),
                                              size: 14,
                                            ),
                                          ),
                                          Align(
                                            alignment:
                                                AlignmentDirectional(0, 0),
                                            child: Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(8, 0, 0, 0),
                                              child: Text(
                                                '${DateFormat('MMM d, yyyy h:mma').format(widget.date)}',
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyText1
                                                        .override(
                                                          fontFamily: 'Poppins',
                                                          color:
                                                              Color(0xFF9A9A9A),
                                                          fontSize: 14,
                                                        ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Align(
                        alignment: AlignmentDirectional(-1, 0),
                        child: Padding(
                          padding:
                              EdgeInsetsDirectional.fromSTEB(12, 12, 12, 0),
                          child: Text(
                            'Symptoms',
                            style:
                                FlutterFlowTheme.of(context).bodyText1.override(
                                      fontFamily: 'Open Sans',
                                      color: Color(0xFF606E87),
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: AlignmentDirectional(-1, 0),
                        child: Padding(
                          padding:
                              EdgeInsetsDirectional.fromSTEB(12, 10, 12, 12),
                          child: Text(
                            widget.symtopms,
                            style:
                                FlutterFlowTheme.of(context).bodyText1.override(
                                      fontFamily: 'Open Sans',
                                      color: Color(0xFF606E87),
                                      fontSize: 12,
                                    ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 6,
                    ),
                    Text(
                      "Payment Type",
                      style: FlutterFlowTheme.of(context).bodyText1.override(
                          fontFamily: 'Open Sans',
                          color: Color(0xFF606E87),
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(height: 7),
                Align(
                  alignment: Alignment.centerLeft,
                  child: FlutterFlowRadioButton(
                    options: [
                      if (widget.service.paymentType == 0) 'Free',
                      if (widget.service.paymentType == 1 ||
                          widget.service.paymentType == 3)
                        'Online Payment',
                      if (widget.service.paymentType == 2 ||
                          widget.service.paymentType == 3)
                        'Cash (Offline)',
                    ],
                    onChanged: (value) {
                      setState(() {
                        _paymentValueType = value;
                      });
                    },
                    optionHeight: 25,
                    textStyle: FlutterFlowTheme.of(context).bodyText1.override(
                          fontFamily: 'Open Sans',
                          color: Color(0xFF606E87),
                          fontSize: 16,
                        ),
                    selectedTextStyle:
                        FlutterFlowTheme.of(context).bodyText1.override(
                              fontFamily: 'Open Sans',
                              color: Color(0xFF606E87),
                              fontSize: 16,
                            ),
                    buttonPosition: RadioButtonPosition.left,
                    direction: Axis.vertical,
                    radioButtonColor: Color(0xFF00A8A3),
                    inactiveRadioButtonColor: Color(0xFF00A8A3),
                    toggleable: false,
                    horizontalAlignment: WrapAlignment.end,
                    verticalAlignment: WrapCrossAlignment.start,
                  ),
                ),
                Spacer(),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 12),
                  child: InkWell(
                    onTap: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BookingSuccessScreenWidget(),
                        ),
                      );
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.75,
                      height: 55,
                      decoration: BoxDecoration(
                        color: Color(0xFF00A8A3),
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(
                          color: Color(0xFF00A8A3),
                          width: 2,
                        ),
                      ),
                      child: InkWell(
                        onTap: () async {
                          if (_paymentValueType == null) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text(
                                    'Please select a payment mode to proceed')));
                          } else {
                            if (_paymentValueType == 'Free' ||
                                _paymentValueType == 'Cash (Offline)') {
                              await _bookAppointment(
                                  transactionId: DateTime.now()
                                      .millisecondsSinceEpoch
                                      .toString());
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Booked')),
                              );
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (_) =>
                                      BookingSuccessScreenWidget()));
                            } else {
                              // through UPI/Debit
                              _makePayment();
                            }
                          }
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Pay \u20B9${widget.service.amount.toInt()}',
                              style: FlutterFlowTheme.of(context)
                                  .bodyText1
                                  .override(
                                    fontFamily: 'Open Sans',
                                    color: Colors.white,
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                              child: Image.asset(
                                'assets/images/Layer_2.png',
                                width: 35,
                                height: 35,
                                fit: BoxFit.contain,
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
      ),
    );
  }
}
