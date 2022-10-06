// TODO Implement this library.import '../flutter_flow/flutter_flow_icon_button.dart';
import 'dart:io';

import 'package:file_picker/file_picker.dart';

import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HvtBottomsheetWidget extends StatefulWidget {
  const HvtBottomsheetWidget({Key key}) : super(key: key);

  @override
  _HvtBottomsheetWidgetState createState() => _HvtBottomsheetWidgetState();
}

class _HvtBottomsheetWidgetState extends State<HvtBottomsheetWidget> {
  TextEditingController textController1;
  TextEditingController textController2;
  TextEditingController reportDateController;
  DateTime _datetime;

  void _selectReportDate() async {
    final DateTime pickedDate = await showDatePicker(
        helpText: 'Select Investigation date',
        cancelText: 'Cancel',
        confirmText: 'Select',
        context: context,
        initialDate: _datetime ??
            DateTime(
                DateTime.now().year, DateTime.now().month, DateTime.now().day),
        firstDate: DateTime(1900),
        lastDate: DateTime(2025));
    if (pickedDate != null && pickedDate != _datetime)
      setState(() {
        _datetime = pickedDate;
        reportDateController.text = DateFormat('MMM d, yyyy').format(_datetime);
      });
  }

  @override
  void initState() {
    super.initState();
    textController1 = TextEditingController();
    textController2 = TextEditingController();
    // reportDateController = TextEditingController(
    //     text: widget.newRecord
    //         ? ''
    //         : DateFormat('MMM d, yyyy').format(widget.medicalRecord.createdAt));
  }

  @override
  void dispose() {
    textController1?.dispose();
    textController2?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        color: Color(0xFFF3F4F4),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(5, 0, 5, 0),
                    child: TextFormField(
                      controller: textController1,
                      autofocus: true,
                      obscureText: false,
                      decoration: InputDecoration(
                        labelText: 'Report Name',
                        hintText: 'Enter report name',
                        hintStyle: FlutterFlowTheme.of(context).bodyText2,
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFF606E87),
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFF606E87),
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0x00000000),
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0x00000000),
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                      style: FlutterFlowTheme.of(context).bodyText1.override(
                            fontFamily: 'Open Sans',
                            fontWeight: FontWeight.normal,
                          ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Padding(
          //   padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
          //   child: Row(
          //     mainAxisSize: MainAxisSize.max,
          //     children: [
          //       Expanded(
          //         child: Padding(
          //           padding: EdgeInsetsDirectional.fromSTEB(5, 0, 5, 0),
          //           child: TextFormField(
          //             controller: textController2,
          //             autofocus: true,
          //             obscureText: false,
          //             decoration: InputDecoration(
          //               labelText: 'Investigation Date',
          //               hintText: 'Enter the date',
          //               hintStyle: FlutterFlowTheme.of(context).bodyText2,
          //               enabledBorder: OutlineInputBorder(
          //                 borderSide: BorderSide(
          //                   color: Color(0xFF606E87),
          //                   width: 1,
          //                 ),
          //                 borderRadius: BorderRadius.circular(300),
          //               ),
          //               focusedBorder: OutlineInputBorder(
          //                 borderSide: BorderSide(
          //                   color: Color(0xFF606E87),
          //                   width: 1,
          //                 ),
          //                 borderRadius: BorderRadius.circular(300),
          //               ),
          //               errorBorder: OutlineInputBorder(
          //                 borderSide: BorderSide(
          //                   color: Color(0x00000000),
          //                   width: 1,
          //                 ),
          //                 borderRadius: BorderRadius.circular(300),
          //               ),
          //               focusedErrorBorder: OutlineInputBorder(
          //                 borderSide: BorderSide(
          //                   color: Color(0x00000000),
          //                   width: 1,
          //                 ),
          //                 borderRadius: BorderRadius.circular(300),
          //               ),
          //               filled: true,
          //               fillColor: Colors.white,
          //               suffixIcon: Icon(
          //                 Icons.date_range_sharp,
          //                 color: Colors.black,
          //                 size: 30,
          //               ),
          //             ),
          //             style: FlutterFlowTheme.of(context).bodyText1.override(
          //                   fontFamily: 'Open Sans',
          //                   fontWeight: FontWeight.normal,
          //                 ),
          //           ),
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 20),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(5, 0, 5, 0),
                    child: InkWell(
                      onTap: _selectReportDate,
                      child: IgnorePointer(
                        child: TextFormField(
                          controller: reportDateController,
                          obscureText: false,
                          decoration: InputDecoration(
                            enabled: true,
                            labelText: 'Investigation Date',
                            labelStyle:
                                FlutterFlowTheme.of(context).bodyText1.override(
                                      fontFamily: 'Open Sans',
                                      color: Color(0xFF9A9A9A),
                                    ),
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
                          style:
                              FlutterFlowTheme.of(context).bodyText1.override(
                                    fontFamily: 'Open Sans',
                                    color: Color(0xFF485163),
                                    fontWeight: FontWeight.w500,
                                  ),
                        ),
                      ),
                    ),
                  ),
                ),
                // Expanded(
                //   child: Padding(
                //     padding: EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                //     child: InkWell(
                //       onTap: _selectReportTime,
                //       child: IgnorePointer(
                //         child: TextFormField(
                //           controller: reportTimeController,
                //           enabled: false,
                //           obscureText: false,
                //           decoration: InputDecoration(
                //             enabled: true,
                //             labelText: 'Report Time',
                //             labelStyle: FlutterFlowTheme.of(context)
                //                 .bodyText1
                //                 .override(
                //                   fontFamily: 'Open Sans',
                //                   color: Color(0xFF9A9A9A),
                //                 ),
                //             enabledBorder: OutlineInputBorder(
                //               borderSide: BorderSide(
                //                 color: Color(0xFFC1C1C1),
                //                 width: 1,
                //               ),
                //               borderRadius: BorderRadius.circular(12),
                //             ),
                //             focusedBorder: OutlineInputBorder(
                //               borderSide: BorderSide(
                //                 color: Color(0xFFC1C1C1),
                //                 width: 1,
                //               ),
                //               borderRadius: BorderRadius.circular(12),
                //             ),
                //             filled: true,
                //             fillColor: Colors.white,
                //           ),
                //           style: FlutterFlowTheme.of(context)
                //               .bodyText1
                //               .override(
                //                 fontFamily: 'Open Sans',
                //                 color: Color(0xFF485163),
                //                 fontWeight: FontWeight.w500,
                //               ),
                //         ),
                //       ),
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
          Align(
            alignment: AlignmentDirectional(-0.75, -1),
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 10),
              child: InkWell(
                child: Icon(
                  Icons.upload_file,
                  color: Colors.black,
                  size: 40,
                ),
                onTap: () async {
                  FilePickerResult result =
                      await FilePicker.platform.pickFiles();

                  if (result != null) {
                    File file = File(result.files.single.path);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Please select a file')));
                  }
                },
              ),
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: Align(
                  alignment: AlignmentDirectional(0.05, 0.25),
                  child: FFButtonWidget(
                    onPressed: () {
                      print('Button pressed ...');
                    },
                    text: 'Send',
                    options: FFButtonOptions(
                      width: 130,
                      height: 40,
                      color: Color(0xFF00A8A3),
                      textStyle:
                          FlutterFlowTheme.of(context).subtitle2.override(
                                fontFamily: 'Open Sans',
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                      borderSide: BorderSide(
                        color: Colors.transparent,
                        width: 1,
                      ),
                      borderRadius: 8,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

FlutterFlowIconButton(
    {Color borderColor,
    int borderRadius,
    int borderWidth,
    int buttonSize,
    Icon icon,
    Null Function(),
    onPressed}) {}
