import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dhanva_mobile_app/global/providers/authentication_provider.dart';
import 'package:dhanva_mobile_app/main.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import '../custom_code/widgets/index.dart' as custom_widgets;
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

ChangeNotifierProvider<AuthenticationProvider> _authProvider =
    ChangeNotifierProvider((ref) => AuthenticationProvider.instance);

class VerificationScreenWidget extends ConsumerStatefulWidget {
  final String mobile;
  const VerificationScreenWidget({Key key, @required this.mobile})
      : super(key: key);

  @override
  ConsumerState<VerificationScreenWidget> createState() =>
      _VerificationScreenWidgetState();
}

class _VerificationScreenWidgetState
    extends ConsumerState<VerificationScreenWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  String _otp = '';
  int resendTimeoutTime = 1 * 60; // 1.0 is seconds modifier

  void handleResendTimer({int minutes = 1}) {
    resendTimeoutTime = minutes * 60;
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (this.mounted)
        setState(() {
          resendTimeoutTime = resendTimeoutTime - 1;
        });
      if (resendTimeoutTime == 0) timer.cancel();
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) => handleResendTimer(),
    );
    getConnectivity();
    super.initState();
  }

  StreamSubscription subscription;
  bool isDeviceConnected = false;
  bool isAlertSet = false;

  Future<void> _checkNetworkConnectivity() async {
    ConnectivityResult connectivityResult =
        await Connectivity().checkConnectivity();
    print(connectivityResult.name);
    print(connectivityResult.name);
    if (connectivityResult == ConnectivityResult.mobile) {
      // ScaffoldMessenger.of(context).showSnackBar(
      //     SnackBar(content: Text('You are connected to a mobile network')));
      // // I am connected to a mobile network.
    } else if (connectivityResult == ConnectivityResult.wifi) {
      // ScaffoldMessenger.of(context).showSnackBar(
      //     SnackBar(content: Text('You are connected to a wifi network')));
      // // I am connected to a wifi network.
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('You are not connected to internet')));
    }
  }

  getConnectivity() =>
      subscription = Connectivity().onConnectivityChanged.listen(
        (ConnectivityResult result) async {
          isDeviceConnected = await InternetConnectionChecker().hasConnection;
          if (!isDeviceConnected && isAlertSet == false) {
            showDialogBox();
            setState(() => isAlertSet = true);
          }
        },
      );
  showDialogBox() => showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('No Connection'),
          content: const Text('Please check your internet connection'),
          actions: <Widget>[
            TextButton(
              onPressed: () async {
                Navigator.pop(context, 'Cancel');
                setState(() => isAlertSet = false);
                isDeviceConnected =
                    await InternetConnectionChecker().hasConnection;
                if (!isDeviceConnected && isAlertSet == false) {
                  showDialogBox();
                  setState(() => isAlertSet = true);
                }
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: Color(0xFFF3F4F4),
        automaticallyImplyLeading: false,
        leading: InkWell(
          onTap: () async {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_rounded,
            color: Color(0xFF00A8A3),
            size: 36,
          ),
        ),
        actions: [],
        centerTitle: true,
        elevation: 0,
      ),
      backgroundColor: Color(0xFFF3F4F4),
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(18, 0, 18, 0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      'Verification',
                      style: FlutterFlowTheme.of(context).title1.override(
                            fontFamily: 'Poppins',
                            fontSize: 32,
                          ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 0, 38, 0),
                  child: Text(
                    'Please Check your Message for a four-digit security code and enter below',
                    style: FlutterFlowTheme.of(context).bodyText1.override(
                          fontFamily: 'Open Sans',
                          color: Color(0xFF606E87),
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 40, 0, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      custom_widgets.OTPWidget(
                        width: 340,
                        height: 65,
                        otpLength: 4,
                        fieldFillColor: Colors.white,
                        textColor: Color(0xFF606E86),
                        borderRadius: 12.0,
                        fieldWidth: 55.0,
                        fieldHeight: 55.0,
                        onComplete: (String otp) {
                          _otp = otp;
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 28,
                ),
                if (resendTimeoutTime != 0)
                  Text(
                    'Please wait for $resendTimeoutTime seconds',
                    style: FlutterFlowTheme.of(context).bodyText1.override(
                          fontFamily: 'Poppins',
                          color: Color(0xFF606E87),
                          fontSize: 14,
                        ),
                  ),
                if (resendTimeoutTime == 0)
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Didn\'t receive a code?',
                          style:
                              FlutterFlowTheme.of(context).bodyText1.override(
                                    fontFamily: 'Poppins',
                                    color: Color(0xFF606E87),
                                    fontSize: 14,
                                  ),
                        ),
                        InkWell(
                          onTap: () async {
                            await ref
                                .read(_authProvider)
                                .attemptLogin(mobile: widget.mobile);
                            handleResendTimer();
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text(
                                    'A new otp has been sent to ${widget.mobile}')));
                          },
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(2, 0, 0, 0),
                            child: Text(
                              ' Resend code',
                              style: FlutterFlowTheme.of(context)
                                  .bodyText1
                                  .override(
                                    fontFamily: 'Poppins',
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 80, 0, 0),
                  child: FFButtonWidget(
                    onPressed: () async {
                      if (_otp.isNotEmpty) {
                        String res = await ref
                            .read(_authProvider)
                            .verifyLoginOtp(mobile: widget.mobile, otp: _otp);
                        ScaffoldMessenger.of(context)
                            .showSnackBar(SnackBar(content: Text(res)));
                        //print('hai $res ');
                        if (res == 'Logged in successfully') {
                          // print('hai');
                          await Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  NavBarPage(initialPage: 'HomeScreen'),
                            ),
                            (r) => false,
                          );
                        }
                      }
                      if (_otp.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Please enter the OTP')));
                      }

                      //print(_otp);
                    },
                    text: 'Verify',
                    options: FFButtonOptions(
                      width: 280,
                      height: 50,
                      color: Color(0xFF00A8A3),
                      textStyle:
                          FlutterFlowTheme.of(context).subtitle2.override(
                                fontFamily: 'Poppins',
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                      borderSide: BorderSide(
                        color: Colors.transparent,
                        width: 1,
                      ),
                      borderRadius: 22,
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
