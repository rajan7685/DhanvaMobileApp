import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import '../main.dart';
import '../custom_code/widgets/index.dart' as custom_widgets;
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

class VerificationScreenWidget extends StatefulWidget {
  const VerificationScreenWidget({Key key}) : super(key: key);

  @override
  _VerificationScreenWidgetState createState() =>
      _VerificationScreenWidgetState();
}

class _VerificationScreenWidgetState extends State<VerificationScreenWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

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
                    'Please Check your Message for a  six-digit security code and enter below',
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
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Didn\'t receive a code?',
                        style: FlutterFlowTheme.of(context).bodyText1.override(
                              fontFamily: 'Poppins',
                              color: Color(0xFF606E87),
                              fontSize: 14,
                            ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(2, 0, 0, 0),
                        child: Text(
                          'Resend code',
                          style:
                              FlutterFlowTheme.of(context).bodyText1.override(
                                    fontFamily: 'Poppins',
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
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
                      await Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              NavBarPage(initialPage: 'HomeScreen'),
                        ),
                        (r) => false,
                      );
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
