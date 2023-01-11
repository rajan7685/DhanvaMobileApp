import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class mncAmountBreakupWidget extends StatefulWidget {
  const mncAmountBreakupWidget({Key key}) : super(key: key);

  @override
  _mncAmountBreakupWidgetState createState() => _mncAmountBreakupWidgetState();
}

class _mncAmountBreakupWidgetState extends State<mncAmountBreakupWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFFEDF3F3),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(24, 16, 24, 4),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  'Price Breakdown',
                  style: FlutterFlowTheme.of(context).bodyText2.override(
                        fontFamily: 'Open Sans',
                        color: Color(0xFF7C8791),
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(24, 4, 24, 0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Base Price',
                  style: FlutterFlowTheme.of(context).bodyText2.override(
                        // fontFamily: 'Outfit',
                        fontFamily: 'Open Sans',
                        color: Color(0xFF7C8791),
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                      ),
                ),
                Text(
                  '₹ 156.00',
                  style: FlutterFlowTheme.of(context).subtitle2.override(
                        //fontFamily: 'Outfit',
                        fontFamily: 'Open Sans',
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                      ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(24, 4, 24, 0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Medical Professional Fee',
                  style: FlutterFlowTheme.of(context).bodyText2.override(
                        // fontFamily: 'Outfit',
                        fontFamily: 'Open Sans',
                        color: Color(0xFF7C8791),
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                      ),
                ),
                Text(
                  '₹ 24.20',
                  style: FlutterFlowTheme.of(context).subtitle2.override(
                        // fontFamily: 'Outfit',
                        fontFamily: 'Open Sans',
                        color: Color(0xFF090F13),
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                      ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(24, 4, 24, 0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Miscellaneous Fee',
                  style: FlutterFlowTheme.of(context).bodyText2.override(
                        // fontFamily: 'Outfit',
                        fontFamily: 'Open Sans',
                        color: Color(0xFF7C8791),
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                      ),
                ),
                Text(
                  '₹ 40.00',
                  style: FlutterFlowTheme.of(context).subtitle2.override(
                        //  fontFamily: 'Outfit',
                        fontFamily: 'Open Sans',
                        color: Color(0xFF090F13),
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                      ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(24, 4, 24, 24),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      'Total',
                      style: FlutterFlowTheme.of(context).subtitle1.override(
                            //  fontFamily: 'Outfit',
                            fontFamily: 'Open Sans',
                            color: Color(0xFF7C8791),
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                  ],
                ),
                Text(
                  '₹230.20',
                  style: FlutterFlowTheme.of(context).title1.override(
//fontFamily: 'Outfit',
                        fontFamily: 'Open Sans',
                        color: Color(0xFF090F13),
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
