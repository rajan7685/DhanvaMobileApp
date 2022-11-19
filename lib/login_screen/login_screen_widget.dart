import 'dart:async';

import 'package:dhanva_mobile_app/global/providers/authentication_provider.dart';
import 'package:dhanva_mobile_app/global/services/shared_preference_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import '../verification_screen/verification_screen_widget.dart';
import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

ChangeNotifierProvider<AuthenticationProvider> _authProvider =
    ChangeNotifierProvider((ref) => AuthenticationProvider.instance);

class LoginScreenWidget extends ConsumerStatefulWidget {
  const LoginScreenWidget({Key key}) : super(key: key);

  @override
  ConsumerState<LoginScreenWidget> createState() => _LoginScreenWidgetState();
}

class _LoginScreenWidgetState extends ConsumerState<LoginScreenWidget> {
  TextEditingController mobileNumberController;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    mobileNumberController = TextEditingController();
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
      backgroundColor: FlutterFlowTheme.of(context).tertiaryColor,
      body: Stack(
        children: [
          Image.asset(
            'assets/images/login__1.png',
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 1,
            fit: BoxFit.cover,
          ),
          Align(
            alignment: AlignmentDirectional(0, -0.85),
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'Your',
                        style: FlutterFlowTheme.of(context).bodyText1.override(
                              fontFamily: 'Open Sans',
                              color: Colors.white,
                              fontSize: 35,
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                      Text(
                        'Health',
                        style: FlutterFlowTheme.of(context).bodyText1.override(
                              fontFamily: 'Poppins',
                              color: Color(0xFF4EDFFF),
                              fontSize: 35,
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                      Text(
                        'is our',
                        style: FlutterFlowTheme.of(context).bodyText1.override(
                              fontFamily: 'Poppins',
                              color: Colors.white,
                              fontSize: 35,
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                      Text(
                        'Priority',
                        style: FlutterFlowTheme.of(context).bodyText1.override(
                              fontFamily: 'Poppins',
                              color: Color(0xFF4EDFFF),
                              fontSize: 35,
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: AlignmentDirectional(-0.85, -0.5),
            child: Image.asset(
              'assets/images/Group_119.png',
              width: MediaQuery.of(context).size.width * 0.58,
              height: 360,
              fit: BoxFit.cover,
            ),
          ),
          Align(
            alignment: AlignmentDirectional(0, 1),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 360,
              decoration: BoxDecoration(
                color: Color(0xFFF3F4F4),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(0),
                  bottomRight: Radius.circular(0),
                  topLeft: Radius.circular(50),
                  topRight: Radius.circular(50),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Wrap(
                    spacing: 0,
                    runSpacing: 0,
                    alignment: WrapAlignment.start,
                    crossAxisAlignment: WrapCrossAlignment.start,
                    direction: Axis.horizontal,
                    runAlignment: WrapAlignment.start,
                    verticalDirection: VerticalDirection.down,
                    clipBehavior: Clip.none,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(38, 20, 38, 0),
                        child: Text(
                          'Get Your Online Consultation FREE',
                          style:
                              FlutterFlowTheme.of(context).bodyText1.override(
                                    fontFamily: 'Open Sans',
                                    color: Color(0xFF282828),
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                      ),
                    ],
                  ),
                  Align(
                    alignment: AlignmentDirectional(0, 0),
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(12, 12, 12, 0),
                      child: Form(
                        key: _formKey,
                        child: TextFormField(
                          controller: mobileNumberController,
                          validator: (String number) {
                            if (number.isEmpty) {
                              return 'Please enter your mobile number';
                            }
                            if (number.length != 10) {
                              return 'Please enter a valid mobile number';
                            }
                            return null;
                          },
                          maxLength: 10,
                          onChanged: (val) {
                            _formKey.currentState.validate();
                          },
                          obscureText: false,
                          decoration: InputDecoration(
                            labelText: 'Mobile Number',
                            labelStyle:
                                FlutterFlowTheme.of(context).bodyText1.override(
                                      fontFamily: 'Open Sans',
                                      color: Color(0xFF9A9A9A),
                                      fontSize: 18,
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
                          style:
                              FlutterFlowTheme.of(context).bodyText1.override(
                                    fontFamily: 'Open Sans',
                                    color: Color(0xFF606E87),
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                  ),
                          textAlign: TextAlign.start,
                          keyboardType: TextInputType.phone,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 50, 0, 0),
                    child: FFButtonWidget(
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          await ref.read(_authProvider).attemptLogin(
                              mobile: mobileNumberController.text,
                              fcm: SharedPreferenceService.loadString(
                                  key: FcmTokenKey));
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => VerificationScreenWidget(
                                mobile: mobileNumberController.text,
                              ),
                            ),
                          );
                        }
                      },
                      text: 'Login',
                      options: FFButtonOptions(
                        width: 280,
                        height: 45,
                        color: Color(0xFF00A8A3),
                        textStyle:
                            FlutterFlowTheme.of(context).subtitle2.override(
                                  fontFamily: 'Open Sans',
                                  color: Color(0xFFF3F4F4),
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                        elevation: 2,
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
        ],
      ),
    );
  }
}
