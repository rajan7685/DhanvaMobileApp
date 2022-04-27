import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

class NextIconButtonWidget extends StatefulWidget {
  const NextIconButtonWidget({Key key}) : super(key: key);

  @override
  _NextIconButtonWidgetState createState() => _NextIconButtonWidgetState();
}

class _NextIconButtonWidgetState extends State<NextIconButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Next',
          style: FlutterFlowTheme.of(context).title1.override(
                fontFamily: 'Open Sans',
                fontSize: 20,
                color: Color(0xFFF3F4F4),
              ),
        ),
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(8, 0, 0, 0),
          child: Image.asset(
            'assets/images/Layer_2.png',
            width: 25,
            height: 25,
            fit: BoxFit.fill,
          ),
        ),
      ],
    );
  }
}
