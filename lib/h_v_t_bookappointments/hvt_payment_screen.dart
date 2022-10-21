import 'dart:convert';

import 'package:dhanva_mobile_app/components/next_icon_button_widget.dart';
import 'package:dhanva_mobile_app/flutter_flow/flutter_flow_radio_button.dart';
import 'package:dhanva_mobile_app/global/models/doctor.dart';
import 'package:dhanva_mobile_app/global/models/patient.dart';
import 'package:dhanva_mobile_app/global/services/api_services/api_service_base.dart';
import 'package:dhanva_mobile_app/global/services/api_services/doctors_details_service.dart';
import 'package:dhanva_mobile_app/global/services/shared_preference_service.dart';
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

class hvtPaymentScreenWidget extends StatefulWidget {
  Map<String, dynamic> data = {};
  String doctorId;
  String doctorName;

  // String goal;
  // String shape;
  // String appointmentDate;
  // String healthRating;
  // String checkupFrequency;
  // String patient_id;
  // String time_slot;
  // String payment_info;
  // String doctor;
  // String service_id;
  // DateTime date;
  // String timeString;

  hvtPaymentScreenWidget(
      {Key key,
      @required this.data,
      @required this.doctorId,
      @required this.doctorName})
      : super(key: key);
  // @required this.goal,
  // @required this.shape,
  // @required this.appointmentDate,
  // @required this.healthRating,
  // @required this.checkupFrequency,
  // @required this.patient_id,
  // @required this.time_slot,
  // @required this.payment_info,
  // @required this.doctor,
  // @required this.service_id,
  // @required this.doctor,
  // this.isOnline = true

  @override
  _hvtPaymentScreenWidgetState createState() => _hvtPaymentScreenWidgetState();
}

class _hvtPaymentScreenWidgetState extends State<hvtPaymentScreenWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  Razorpay _rzPay;
  String _paymentValueType = "Online Payment";

  String paymentId;

  Patient p = Patient.fromJson(
      jsonDecode(SharedPreferenceService.loadString(key: PatientKey)));

  bool isDataLoading = true;

  Future<void> _bookAppointment({@required String transactionId}) async {
    print("An Appointment is started booking!!!");
    Response res = await ApiService.dio.post(
        '${ApiService.protocol}api2.dhanva.icu/payment/add',
        options: Options(headers: {
          'Authorization': SharedPreferenceService.loadString(key: AuthTokenKey)
        }),
        data: {
          "amount": widget.data["amount"],
          "transaction_id": transactionId,
          "payment_status_string": "Success",
          "patient_id": widget.data["patient_id"],
          "status": 0
        });
    Response bookingRes = await ApiService.dio.post(
        '${ApiService.protocol}api2.dhanva.icu/hvt/book',
        options: Options(headers: {
          'Authorization': SharedPreferenceService.loadString(key: AuthTokenKey)
        }),
        data: {
          "shape": widget.data["shapes"],
          "goal": widget.data["goal"],
          "healthRating": widget.data["healthRating"],
          "checkupFrequency": widget.data["checkupFrequency"],
          "patient_id": widget.data["patient_id"],
          "appointmentDate":
              "${DateTime.parse(widget.data["appointmentDate"]).toString().split(" ")[0]}T00:00:00.000+0000",
          "time_slot": widget.data["time_slot"],
          "payment_info": res.data["_id"],
          "doctor": widget.doctorId,
          "service_id": "6340254a0ee969214e9d3063"
        });
    print('Booking response > ${bookingRes.data}');
    print('Booking status > ${bookingRes.statusCode}');
    print('Booking msg > ${bookingRes.statusMessage}');
  }

  Future<void> _makePayment() async {
    var options = {
      'key': 'rzp_test_xbbqVc7yVFG9f6',
      'amount': int.parse(widget.data["amount"]) * 100,
      'name': widget.data["name"],
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
        .push(MaterialPageRoute(builder: (_) => hvtSuccessScreenWidget()));
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
    _sendAllDetails();
    _loadAssessmentService();
    print("timeslot issue check${widget.data["appointmentDate"]}");
  }

  Future<void> _sendAllDetails() async {
    Response assesmentRes = await ApiService.dio.get(
        "${ApiService.protocol}${ApiService.baseUrl2}hvt/assessment-service",
        options: Options(headers: {
          'Authorization': SharedPreferenceService.loadString(key: AuthTokenKey)
        }));
  }

  Future<void> _loadAssessmentService() async {
    Response res = await ApiService.dio.get(
        "${ApiService.protocol}${ApiService.baseUrl2}hvt/assessment-service",
        options: Options(headers: {
          'Authorization': SharedPreferenceService.loadString(key: AuthTokenKey)
        }));
    print("assessment service ${res.data}");
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // print(widget.isOnline);
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
                                      //"Esskay",
                                      "${widget.doctorName}",
                                      style: FlutterFlowTheme.of(context)
                                          .bodyText1
                                          .override(
                                            fontFamily: 'Poppins',
                                            color: Color(0xFF606E87),
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600,
                                          ),
                                    ),
                                    // Text(
                                    //   'gallonhubb',
                                    //   style: FlutterFlowTheme.of(context)
                                    //       .bodyText1
                                    //       .override(
                                    //         fontFamily: 'Open Sans',
                                    //         color: Color(0xFF606E87),
                                    //         fontSize: 12,
                                    //       ),
                                    //),
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
                                                // 'hai',

                                                '${DateFormat('MMM d, yyyy h:mma').format(DateTime.parse(widget.data["appointmentDate"]))}',
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
                            // "to get better",
                            widget.data["goal"],
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
                          builder: (context) => hvtSuccessScreenWidget(),
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
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //       builder: (context) => hvtSuccessScreenWidget(),
                          //     ));
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
                                  builder: (_) => hvtSuccessScreenWidget()));
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
                              'Pay \u20B9${widget.data["amount"]}',
                              //${widget.service.amount.toInt()}',
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
