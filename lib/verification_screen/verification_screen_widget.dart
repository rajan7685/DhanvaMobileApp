import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
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
        leading: Icon(
          Icons.arrow_back_rounded,
          color: Color(0xFF00A8A3),
          size: 36,
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
            padding: EdgeInsetsDirectional.fromSTEB(18, 0, 0, 0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      'Verification',
                      style: FlutterFlowTheme.title1.override(
                        fontFamily: 'Poppins',
                        fontSize: 32,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 0, 38, 0),
                  child: Text(
                    'Please Chekch your Message for a  six-digit security code and enter below',
                    style: FlutterFlowTheme.bodyText1.override(
                      fontFamily: 'Open Sans',
                      color: Color(0xFF606E87),
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
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
