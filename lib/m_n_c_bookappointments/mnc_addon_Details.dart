import 'dart:convert';
import 'dart:ffi';
import 'dart:io';
import 'package:dhanva_mobile_app/main.dart';
import 'package:path_provider/path_provider.dart';
import 'package:dhanva_mobile_app/appointments_screen/appointment_model.dart';
import 'package:dhanva_mobile_app/components/notification_icon_button.dart';
import 'package:dhanva_mobile_app/global/models/patient.dart';
import 'package:dhanva_mobile_app/global/services/api_services/medical_appoinment_service.dart';
import 'package:dhanva_mobile_app/global/services/mock_json_data_service.dart';
import 'package:dhanva_mobile_app/global/services/shared_preference_service.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:open_file/open_file.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import '../app_guide_screen2/app_guide_screen2_widget.dart';
import '../components/appointments_bottom_sheet_widget.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

import '../global/services/api_services/api_service_base.dart';
import '../h_v_t_assestment_screen/h_v_t_assestment_screen_widget.dart';
import 'mnc_check_screen.dart';
import 'mnc_start_appointment.dart';

class MncAddonDetailsScreenWidget extends StatefulWidget {
  final Map<String, dynamic> data;
  final String mncId;

  const MncAddonDetailsScreenWidget(
      {Key key, @required this.mncId, @required this.data})
      : super(key: key);

  @override
  _MncAddonDetailsScreenWidgetState createState() =>
      _MncAddonDetailsScreenWidgetState();
}

class _MncAddonDetailsScreenWidgetState
    extends State<MncAddonDetailsScreenWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  bool isDataLoading = true;
  List<dynamic> addons = [];

  Future<void> _loadmncAddonList({bool init = false}) async {
    if (!init)
      setState(() {
        isDataLoading = true;
      });
    Patient patient = Patient.fromJson(
        jsonDecode(SharedPreferenceService.loadString(key: PatientKey)));
    Response res = await ApiService.dio.get(
        "${ApiService.protocol}${ApiService.baseUrl2}mnc/list/addon/${widget.mncId}",
        options: Options(headers: {
          'Authorization': SharedPreferenceService.loadString(key: AuthTokenKey)
        }));
    addons = res.data["addOnPayments"];
    setState(() {
      isDataLoading = false;
    });
    print("addon list ${res.data}");
  }

  @override
  void initState() {
    super.initState();
    _loadmncAddonList(init: true);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(5, 0, 0, 0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(5, 0, 12, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: () async {
                          // if (widget.shouldPopNormally)
                          //   Navigator.pop(context);
                          // else
                          Navigator.pop(context);
                        },
                        child: Icon(
                          Icons.arrow_back_rounded,
                          color: Color(0xFF00A8A3),
                          size: 35,
                        ),
                      ),
                      // Expanded(
                      //   child: Row(
                      //     mainAxisSize: MainAxisSize.max,
                      //     mainAxisAlignment: MainAxisAlignment.end,
                      //     children: [
                      //       //
                      //       NotificationIconButton()
                      //     ],
                      //   ),
                      // ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
                  child: Text(
                    'MNC Addon Payments',
                    style: FlutterFlowTheme.of(context).bodyText1.override(
                          fontFamily: 'Open Sans',
                          color: Color(0xFF00A8A3),
                          fontSize: 32,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ),
                Expanded(
                  child: isDataLoading
                      ? Center(child: CircularProgressIndicator())
                      : (addons.length == 0
                          ? Center(
                              child: Text('There\s no Addon payment pending'))
                          : RefreshIndicator(
                              onRefresh: () async {
                                // _loadmncAppointments();
                              },
                              child: ListView.builder(
                                itemCount: addons.length,
                                itemBuilder: (_, int index) => GestureDetector(
                                  child: ExpansionTile(
                                    title: Text(
                                      addons[index]["name"],
                                      style: FlutterFlowTheme.of(context)
                                          .bodyText1
                                          .override(
                                            fontFamily: 'Open Sans',
                                            color: Color(0xFF606E87),
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600,
                                          ),
                                    ),
                                    children: [
                                      Column(
                                        children: [
                                          AddonCard(
                                            addonDetails: addons[index],
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AddonCard extends StatefulWidget {
  final Map<String, dynamic> addonDetails;

  const AddonCard({Key key, @required this.addonDetails}) : super(key: key);

  @override
  State<AddonCard> createState() => _AddonCardState();
}

class _AddonCardState extends State<AddonCard> {
  Razorpay _rzPay;

  @override
  void initState() {
    super.initState();

    _rzPay = Razorpay();
    _rzPay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _rzPay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _rzPay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
    //
    super.dispose();
  }

  Future<void> _sendMncAddonPaymentDetails(
      {@required String transactionId}) async {
    print(transactionId);
    print("""
    //   addon booking req body
    "amount":${widget.addonDetails["amount"]},
          "transaction_id": ${transactionId},
          "meta_info": {"payment_type": "Card", "isOnline": true},
          "payment_status_string": "Success",
          "patient_id": ${Patient.fromJson(jsonDecode(SharedPreferenceService.loadString(key: PatientKey))).id},
          "status": "0",
          "mnc_id":${widget.addonDetails["mnc_id"]},
          "addOnId":${widget.addonDetails["_id"]},
    //    
    //   """);
    Response res = await ApiService.dio.post(
        "${ApiService.protocol}${ApiService.baseUrl2}mnc/payment/addon",
        options: Options(headers: {
          'Authorization': SharedPreferenceService.loadString(key: AuthTokenKey)
        }),
        data: {
          "amount": widget.addonDetails["amount"],
          "transaction_id": transactionId,
          "meta_info": {"payment_type": "Card", "isOnline": true},
          "payment_status_string": "Success",
          "patient_id": Patient.fromJson(jsonDecode(
                  SharedPreferenceService.loadString(key: PatientKey)))
              .id,
          "status": "0",
          "mnc_id": widget.addonDetails["mnc_id"],
          "addOnId": widget.addonDetails["_id"],
        });
    print("initial payment details${res.data}");
  }

  Future<void> _makePayment() async {
    Patient p = Patient.fromJson(
        jsonDecode(SharedPreferenceService.loadString(key: PatientKey)));
    var options = {
      'key': 'rzp_test_xbbqVc7yVFG9f6',
      'amount': int.parse(widget.addonDetails["amount"]) * 100,
      'name': "AddOn Payment",
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
    Navigator.pop(context);
    _sendMncAddonPaymentDetails(transactionId: response.paymentId);
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
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      color: Colors.white,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(12, 12, 12, 12),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ClipRRect(
            //   borderRadius: BorderRadius.circular(12),
            //   child: Image.network(
            //     'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQvDVXm8awuyibcdpoTSPoePE6-OKncWYyNK9QF-YO66FyUIWHrlF8hbvBU7Gml5eoeeGw&usqp=CAU',
            //     width: 70,
            //     height: 85,
            //     fit: BoxFit.contain,
            //   ),
            // ),
            Expanded(
              child: Align(
                alignment: AlignmentDirectional(0, 0.15),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                        child: Row(
                          children: [
                            Text(
                              "Amount : ",
                              // "12 Sept 12:00AM",
                              style: FlutterFlowTheme.of(context)
                                  .bodyText1
                                  .override(
                                    fontFamily: 'Open Sans',
                                    fontSize: 15,
                                  ),
                            ),
                            Text(
                              "\u20B9${widget.addonDetails["amount"]}",
                              style: FlutterFlowTheme.of(context)
                                  .bodyText1
                                  .override(
                                    fontFamily: 'Open Sans',
                                    fontSize: 17,
                                  ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          Spacer(),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(0, 6, 0, 0),
                            child: FFButtonWidget(
                              onPressed: () {
                                print('Button pressed ...');
                              },
                              text: widget.addonDetails["payment_done"]
                                  ? "Paid"
                                  : "Pending",
                              options: FFButtonOptions(
                                // width: 80,
                                height: 24,
                                color: Colors.white,
                                textStyle: FlutterFlowTheme.of(context)
                                    .subtitle2
                                    .override(
                                      fontFamily: 'Poppins',
                                      color: Color(0xFF0BA6C3),
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                borderSide: BorderSide(
                                  color: Color(0xFF0BA6C3),
                                  width: 2,
                                ),
                                borderRadius: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                        child: widget.addonDetails["payment"] != null
                            ? Text(
                                "Transcation date : ${DateFormat('MMM d, yyyy').format(
                                  DateTime.parse(
                                    widget.addonDetails["payment"]
                                        ['transaction_date'],
                                  ),
                                )}",
                                // "12 Sept 12:00AM",
                                style: FlutterFlowTheme.of(context)
                                    .bodyText1
                                    .override(
                                      fontFamily: 'Open Sans',
                                      fontSize: 15,
                                    ),
                              )
                            : SizedBox(),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      if (!widget.addonDetails["payment_done"])
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.30,
                              height: 35,
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
                                      'Pay \u20B9${widget.addonDetails["amount"].toString()}',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyText1
                                          .override(
                                            fontFamily: 'Open Sans',
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                    ),
                                    // Padding(
                                    //   padding:
                                    //       EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                                    //   child: Image.asset(
                                    //     'assets/images/Layer_2.png',
                                    //     width: 20,
                                    //     height: 20,
                                    //     fit: BoxFit.contain,
                                    //   ),
                                    // ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
