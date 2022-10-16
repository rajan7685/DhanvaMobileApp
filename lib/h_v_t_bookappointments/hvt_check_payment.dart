import 'dart:async';
import 'dart:convert';

import 'package:dhanva_mobile_app/components/next_icon_button_widget.dart';
import 'package:dhanva_mobile_app/flutter_flow/flutter_flow_radio_button.dart';
import 'package:dhanva_mobile_app/global/models/doctor.dart';
import 'package:dhanva_mobile_app/global/models/patient.dart';
import 'package:dhanva_mobile_app/global/services/api_services/api_service_base.dart';
import 'package:dhanva_mobile_app/global/services/api_services/doctors_details_service.dart';
import 'package:dhanva_mobile_app/global/services/shared_preference_service.dart';
import 'package:dhanva_mobile_app/h_v_t_bookappointments/hvt_logs_investigation.dart';
import 'package:dhanva_mobile_app/h_v_t_bookappointments/hvt_success_screen.dart';
import 'package:dhanva_mobile_app/home_screen/models/quick_service_ui_model.dart';
import 'package:dio/dio.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import '../booking_success_screen/booking_success_screen_widget.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

Doctor _selectedDoctor;

class hvtCheckPaymentScreenWidget extends StatefulWidget {
  final Map<String, dynamic> data;
  final int hvtPayment;
  final String hvtId;
  final String hvtStatus;
  hvtCheckPaymentScreenWidget(
      {Key key,
      @required this.data,
      @required this.hvtPayment,
      @required this.hvtId,
      @required this.hvtStatus})
      : super(key: key);

  @override
  _hvtCheckPaymentScreenWidgetState createState() =>
      _hvtCheckPaymentScreenWidgetState();
}

class _hvtCheckPaymentScreenWidgetState
    extends State<hvtCheckPaymentScreenWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  Razorpay _rzPay;
  String _paymentValueType = "Online Payment";

  Patient p = Patient.fromJson(
      jsonDecode(SharedPreferenceService.loadString(key: PatientKey)));

  bool isDataLoading = true;

  Future<void> _makePayment() async {
    var options = {
      'key': 'rzp_test_xbbqVc7yVFG9f6',
      'amount': widget.hvtPayment * 100,
      'name': "Inital payment",
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
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (_) => hvtLogsInvestigationWidget()));
    _sendInitialPaymentDetails(transactionId: response.paymentId);
  }

  void _handlePaymentError(PaymentFailureResponse response) async {
    print('Payment Failure : ${response.code} ${response.message}');

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content:
            Text("Payment failed : ${response.message}\nPlease try again")));
  }

  void _handleExternalWallet(ExternalWalletResponse response) async {
    print('Payment external : $response');
  }

  @override
  void initState() {
    super.initState();
    _rzPay = Razorpay();
    _rzPay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _rzPay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _rzPay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  Future<void> _sendInitialPaymentDetails(
      {@required String transactionId}) async {
    print(transactionId);
    print("""
    //   booking req body
    "amount":${widget.hvtPayment.toString()},
          "transaction_id": ${transactionId},
          "meta_info": {"payment_type": "Card", "isOnline": true},
          "payment_status_string": "Success",
          "patient_id": ${Patient.fromJson(
      jsonDecode(
        SharedPreferenceService.loadString(key: PatientKey),
      ),
    ).id}
          "status":${widget.hvtStatus},
          "hvt_id": ${widget.hvtId},
    //    
    //   """);
    Response res = await ApiService.dio.post(
        "${ApiService.protocol}${ApiService.baseUrl2}hvt/payment/initial",
        options: Options(headers: {
          'Authorization': SharedPreferenceService.loadString(key: AuthTokenKey)
        }),
        data: {
          "amount": widget.hvtPayment.toString(),
          "transaction_id": transactionId,
          "meta_info": {"payment_type": "Card", "isOnline": true},
          "payment_status_string": "Success",
          "patient_id": Patient.fromJson(jsonDecode(
                  SharedPreferenceService.loadString(key: PatientKey)))
              .id,
          "status": widget.hvtStatus,
          "hvt_id": widget.hvtId,
        });
    print("initial payment details${res.data}");
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: Color(0xFFEDF3F3),
        iconTheme: IconThemeData(color: Color(0xFF00A8A3)),
        //iconTheme: IconThemeData(color: Colors.black),
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
                      'Your HVT Appointment',
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
                                      widget.data["doctor"]["name"],
                                      // "${}",

                                      style: FlutterFlowTheme.of(context)
                                          .bodyText1
                                          .override(
                                            fontFamily: 'Poppins',
                                            color: Color(0xFF606E87),
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600,
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
                                                // "15-10-2022",
                                                '${DateFormat('MMM d, yyyy').format(DateTime.parse(widget.data["appointmentDate"]))} ${widget.data["time_slot"]}',
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
                            'HVT Goal',
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
                            widget.data["goal"],
                            // widget.symtopms,
                            style:
                                FlutterFlowTheme.of(context).bodyText1.override(
                                      fontFamily: 'Open Sans',
                                      color: Color(0xFF606E87),
                                      fontSize: 12,
                                    ),
                          ),
                        ),
                        // ),
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
                    initialValue: _paymentValueType,
                    options: [
                      'Online Payment',
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
                          builder: (context) => hvtLogsInvestigationWidget(),
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
                          _makePayment();
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Pay \u20B9${widget.hvtPayment.toString()}',
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
