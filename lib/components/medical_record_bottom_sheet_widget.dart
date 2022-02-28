import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

class MedicalRecordBottomSheetWidget extends StatefulWidget {
  const MedicalRecordBottomSheetWidget({Key key}) : super(key: key);

  @override
  _MedicalRecordBottomSheetWidgetState createState() =>
      _MedicalRecordBottomSheetWidgetState();
}

class _MedicalRecordBottomSheetWidgetState
    extends State<MedicalRecordBottomSheetWidget> {
  TextEditingController textController1;
  TextEditingController textController2;
  TextEditingController textController3;
  TextEditingController textController4;
  TextEditingController textController5;

  @override
  void initState() {
    super.initState();
    textController1 = TextEditingController(text: 'SomeOne');
    textController2 = TextEditingController(text: 'Xray');
    textController3 = TextEditingController(text: 'DR A R Rajesh');
    textController4 = TextEditingController(text: 'Dec 30, 2022');
    textController5 = TextEditingController(text: '06:30 PM');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        color: Color(0xFFF3F4F4),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(0),
          bottomRight: Radius.circular(0),
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(12, 16, 12, 0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            TextFormField(
              controller: textController1,
              obscureText: false,
              decoration: InputDecoration(
                labelText: 'Patient Name',
                labelStyle: FlutterFlowTheme.of(context).bodyText1.override(
                      fontFamily: 'Open Sans',
                      color: Color(0xFF9A9A9A),
                    ),
                hintText: '[Some hint text...]',
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xFFC1C1C1),
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xFFC1C1C1),
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: Colors.white,
              ),
              style: FlutterFlowTheme.of(context).bodyText1.override(
                    fontFamily: 'Open Sans',
                    color: Color(0xFF485163),
                    fontWeight: FontWeight.w500,
                  ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
              child: TextFormField(
                controller: textController2,
                obscureText: false,
                decoration: InputDecoration(
                  labelText: 'Type of scan or test',
                  labelStyle: FlutterFlowTheme.of(context).bodyText1.override(
                        fontFamily: 'Open Sans',
                        color: Color(0xFF9A9A9A),
                      ),
                  hintText: '[Some hint text...]',
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xFFC1C1C1),
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xFFC1C1C1),
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
                style: FlutterFlowTheme.of(context).bodyText1.override(
                      fontFamily: 'Open Sans',
                      color: Color(0xFF485163),
                      fontWeight: FontWeight.w500,
                    ),
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
              child: TextFormField(
                controller: textController3,
                obscureText: false,
                decoration: InputDecoration(
                  labelText: 'Doctor Name',
                  labelStyle: FlutterFlowTheme.of(context).bodyText1.override(
                        fontFamily: 'Open Sans',
                        color: Color(0xFF9A9A9A),
                      ),
                  hintText: '[Some hint text...]',
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xFFC1C1C1),
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xFFC1C1C1),
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
                style: FlutterFlowTheme.of(context).bodyText1.override(
                      fontFamily: 'Open Sans',
                      color: Color(0xFF485163),
                      fontWeight: FontWeight.w500,
                    ),
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 12, 0),
                      child: TextFormField(
                        controller: textController4,
                        obscureText: false,
                        decoration: InputDecoration(
                          labelText: 'Report Date',
                          labelStyle:
                              FlutterFlowTheme.of(context).bodyText1.override(
                                    fontFamily: 'Open Sans',
                                    color: Color(0xFF9A9A9A),
                                  ),
                          hintText: '[Some hint text...]',
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFFC1C1C1),
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFFC1C1C1),
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                        style: FlutterFlowTheme.of(context).bodyText1.override(
                              fontFamily: 'Open Sans',
                              color: Color(0xFF485163),
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                      child: TextFormField(
                        controller: textController5,
                        obscureText: false,
                        decoration: InputDecoration(
                          labelText: 'Report Time',
                          labelStyle:
                              FlutterFlowTheme.of(context).bodyText1.override(
                                    fontFamily: 'Open Sans',
                                    color: Color(0xFF9A9A9A),
                                  ),
                          hintText: '[Some hint text...]',
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFFC1C1C1),
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFFC1C1C1),
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                        style: FlutterFlowTheme.of(context).bodyText1.override(
                              fontFamily: 'Open Sans',
                              color: Color(0xFF485163),
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    'Upload your Report',
                    style: FlutterFlowTheme.of(context).bodyText1.override(
                          fontFamily: 'Open Sans',
                          color: Color(0xFF1E1E1E),
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    width: 55,
                    height: 55,
                    decoration: BoxDecoration(
                      color: Color(0xFFEEEEEE),
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: Color(0xFF5A6771),
                        width: 4,
                      ),
                    ),
                    child: Icon(
                      Icons.add,
                      color: Color(0xFF535F6B),
                      size: 42,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 18, 0, 0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    'Download All',
                    style: FlutterFlowTheme.of(context).bodyText1.override(
                          fontFamily: 'Open Sans',
                          color: Color(0xFF00A8A3),
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
