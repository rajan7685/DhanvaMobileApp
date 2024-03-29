import 'package:dhanva_mobile_app/psychometrics_assesent_step3/psychometrics_assesent_step3_widget.dart';

import '../flutter_flow/flutter_flow_radio_button.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import '../psychometric_assesent_result_screen/psychometric_assesent_result_screen_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

class PsychometricsAssesentStep4Widget extends StatefulWidget {
  const PsychometricsAssesentStep4Widget({Key key}) : super(key: key);

  @override
  _PsychometricsAssesentStep4WidgetState createState() =>
      _PsychometricsAssesentStep4WidgetState();
}

class _PsychometricsAssesentStep4WidgetState
    extends State<PsychometricsAssesentStep4Widget> {
  String radioButtonValue1;
  String radioButtonValue2;
  String radioButtonValue3;
  String radioButtonValue4;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: Color(0xFFF3F4F4),
        iconTheme: IconThemeData(color: Color(0xFF00A8A3)),
        automaticallyImplyLeading: false,
        leading: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(0, 0, 10, 0),
          child: InkWell(
            onTap: () async {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back,
              color: Color(0xFF00A8A3),
              size: 28,
            ),
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
            padding: EdgeInsetsDirectional.fromSTEB(12, 0, 12, 0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        'Psychometrics',
                        style: FlutterFlowTheme.of(context).title1.override(
                              fontFamily: 'Open Sans',
                              color: Color(0xFF272727),
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 1, 0, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
                          child: Text(
                            'Assesment',
                            style: FlutterFlowTheme.of(context).title1.override(
                                  fontFamily: 'Open Sans',
                                  color: Color(0xFF272727),
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
                    child: Container(
                      width: double.infinity,
                      height: 55,
                      decoration: BoxDecoration(
                        color: Color(0xFFEEEEEE),
                      ),
                      child: Stack(
                        children: [
                          Align(
                            alignment: AlignmentDirectional(0, 0),
                            child: Container(
                              width: double.infinity,
                              height: 4,
                              decoration: BoxDecoration(
                                color: Color(0xFF00A8A3),
                              ),
                            ),
                          ),
                          Align(
                            alignment: AlignmentDirectional(0, 0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: 60,
                                  height: 30,
                                  decoration: BoxDecoration(
                                    color: Color(0xFF00A8A3),
                                    borderRadius: BorderRadius.circular(24),
                                  ),
                                  child: Align(
                                    alignment: AlignmentDirectional(0, 0),
                                    child: Text(
                                      'Step 1',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyText1
                                          .override(
                                            fontFamily: 'Open Sans',
                                            color: Colors.white,
                                            fontSize: 13,
                                            fontWeight: FontWeight.w600,
                                          ),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 60,
                                  height: 30,
                                  decoration: BoxDecoration(
                                    color: Color(0xFF00A8A3),
                                    borderRadius: BorderRadius.circular(24),
                                  ),
                                  child: Align(
                                    alignment: AlignmentDirectional(0, 0),
                                    child: Text(
                                      'Step 2',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyText1
                                          .override(
                                            fontFamily: 'Open Sans',
                                            color: Colors.white,
                                            fontSize: 13,
                                            fontWeight: FontWeight.w600,
                                          ),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 60,
                                  height: 30,
                                  decoration: BoxDecoration(
                                    color: Color(0xFF00A8A3),
                                    borderRadius: BorderRadius.circular(24),
                                  ),
                                  child: Align(
                                    alignment: AlignmentDirectional(0, 0),
                                    child: Text(
                                      'Step 3',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyText1
                                          .override(
                                            fontFamily: 'Open Sans',
                                            color: Colors.white,
                                            fontSize: 13,
                                            fontWeight: FontWeight.w600,
                                          ),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 60,
                                  height: 30,
                                  decoration: BoxDecoration(
                                    color: Color(0xFF00A8A3),
                                    borderRadius: BorderRadius.circular(24),
                                  ),
                                  child: Align(
                                    alignment: AlignmentDirectional(0, 0),
                                    child: Text(
                                      'Step 4',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyText1
                                          .override(
                                            fontFamily: 'Open Sans',
                                            color: Colors.white,
                                            fontSize: 13,
                                            fontWeight: FontWeight.w600,
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
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Color(0xFFEEEEEE),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '31. I put my personal opinions aside in pursuit of fairness and justice.',
                            style:
                                FlutterFlowTheme.of(context).bodyText1.override(
                                      fontFamily: 'Poppins',
                                      color: Color(0xFF151515),
                                    ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                            child: FlutterFlowRadioButton(
                              options: [
                                'YEP! THAT IS ME',
                                'I AM REALLY INBETWEEN',
                                'NOPE THAT CAN\'T BE ME'
                              ],
                              onChanged: (value) {
                                setState(() => radioButtonValue1 = value);
                              },
                              optionHeight: 25,
                              textStyle: FlutterFlowTheme.of(context)
                                  .bodyText1
                                  .override(
                                    fontFamily: 'Poppins',
                                    color: Colors.black,
                                  ),
                              selectedTextStyle: FlutterFlowTheme.of(context)
                                  .bodyText1
                                  .override(
                                    fontFamily: 'Open Sans',
                                    color: Color(0xFF314A51),
                                  ),
                              buttonPosition: RadioButtonPosition.left,
                              direction: Axis.vertical,
                              radioButtonColor: Color(0xFF00A8A3),
                              inactiveRadioButtonColor: Color(0x8A314A51),
                              toggleable: false,
                              horizontalAlignment: WrapAlignment.start,
                              verticalAlignment: WrapCrossAlignment.start,
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
                            child: Text(
                              '32. I tend to sit at the back or corner of the room.',
                              style: FlutterFlowTheme.of(context)
                                  .bodyText1
                                  .override(
                                    fontFamily: 'Poppins',
                                    color: Color(0xFF151515),
                                  ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                            child: FlutterFlowRadioButton(
                              options: [
                                'YEP! THAT IS ME',
                                'I AM REALLY INBETWEEN',
                                'NOPE THAT CAN\'T BE ME'
                              ],
                              onChanged: (value) {
                                setState(() => radioButtonValue2 = value);
                              },
                              optionHeight: 25,
                              textStyle: FlutterFlowTheme.of(context)
                                  .bodyText1
                                  .override(
                                    fontFamily: 'Poppins',
                                    color: Colors.black,
                                  ),
                              selectedTextStyle: FlutterFlowTheme.of(context)
                                  .bodyText1
                                  .override(
                                    fontFamily: 'Open Sans',
                                    color: Color(0xFF314A51),
                                  ),
                              buttonPosition: RadioButtonPosition.left,
                              direction: Axis.vertical,
                              radioButtonColor: Color(0xFF00A8A3),
                              inactiveRadioButtonColor: Color(0x8A314A51),
                              toggleable: false,
                              horizontalAlignment: WrapAlignment.start,
                              verticalAlignment: WrapCrossAlignment.start,
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
                            child: Text(
                              '33. I like being the centre of attention.',
                              style: FlutterFlowTheme.of(context)
                                  .bodyText1
                                  .override(
                                    fontFamily: 'Poppins',
                                    color: Color(0xFF151515),
                                  ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                            child: FlutterFlowRadioButton(
                              options: [
                                'YEP! THAT IS ME',
                                'I AM REALLY INBETWEEN',
                                'NOPE THAT CAN\'T BE ME'
                              ],
                              onChanged: (value) {
                                setState(() => radioButtonValue3 = value);
                              },
                              optionHeight: 25,
                              textStyle: FlutterFlowTheme.of(context)
                                  .bodyText1
                                  .override(
                                    fontFamily: 'Poppins',
                                    color: Colors.black,
                                  ),
                              selectedTextStyle: FlutterFlowTheme.of(context)
                                  .bodyText1
                                  .override(
                                    fontFamily: 'Open Sans',
                                    color: Color(0xFF314A51),
                                  ),
                              buttonPosition: RadioButtonPosition.left,
                              direction: Axis.vertical,
                              radioButtonColor: Color(0xFF00A8A3),
                              inactiveRadioButtonColor: Color(0x8A314A51),
                              toggleable: false,
                              horizontalAlignment: WrapAlignment.start,
                              verticalAlignment: WrapCrossAlignment.start,
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
                            child: Text(
                              '34. I solve problems by leaping between different ideas and possibilities.',
                              style: FlutterFlowTheme.of(context)
                                  .bodyText1
                                  .override(
                                    fontFamily: 'Poppins',
                                    color: Color(0xFF151515),
                                  ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                            child: FlutterFlowRadioButton(
                              options: [
                                'YEP! THAT IS ME',
                                'I AM REALLY INBETWEEN',
                                'NOPE THAT CAN\'T BE ME'
                              ],
                              onChanged: (value) {
                                setState(() => radioButtonValue4 = value);
                              },
                              optionHeight: 25,
                              textStyle: FlutterFlowTheme.of(context)
                                  .bodyText1
                                  .override(
                                    fontFamily: 'Poppins',
                                    color: Colors.black,
                                  ),
                              selectedTextStyle: FlutterFlowTheme.of(context)
                                  .bodyText1
                                  .override(
                                    fontFamily: 'Open Sans',
                                    color: Color(0xFF314A51),
                                  ),
                              buttonPosition: RadioButtonPosition.left,
                              direction: Axis.vertical,
                              radioButtonColor: Color(0xFF00A8A3),
                              inactiveRadioButtonColor: Color(0x8A314A51),
                              toggleable: false,
                              horizontalAlignment: WrapAlignment.start,
                              verticalAlignment: WrapCrossAlignment.start,
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
                            child: Text(
                              '35. I like to complete my work before playing.',
                              style: FlutterFlowTheme.of(context)
                                  .bodyText1
                                  .override(
                                    fontFamily: 'Poppins',
                                    color: Color(0xFF151515),
                                  ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                            child: FlutterFlowRadioButton(
                              options: [
                                'YEP! THAT IS ME',
                                'I AM REALLY INBETWEEN',
                                'NOPE THAT CAN\'T BE ME'
                              ],
                              onChanged: (value) {
                                setState(() => radioButtonValue4 = value);
                              },
                              optionHeight: 25,
                              textStyle: FlutterFlowTheme.of(context)
                                  .bodyText1
                                  .override(
                                    fontFamily: 'Poppins',
                                    color: Colors.black,
                                  ),
                              selectedTextStyle: FlutterFlowTheme.of(context)
                                  .bodyText1
                                  .override(
                                    fontFamily: 'Open Sans',
                                    color: Color(0xFF314A51),
                                  ),
                              buttonPosition: RadioButtonPosition.left,
                              direction: Axis.vertical,
                              radioButtonColor: Color(0xFF00A8A3),
                              inactiveRadioButtonColor: Color(0x8A314A51),
                              toggleable: false,
                              horizontalAlignment: WrapAlignment.start,
                              verticalAlignment: WrapCrossAlignment.start,
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
                            child: Text(
                              '36. I don\'t let other people influence my thoughts or actions.',
                              style: FlutterFlowTheme.of(context)
                                  .bodyText1
                                  .override(
                                    fontFamily: 'Poppins',
                                    color: Color(0xFF151515),
                                  ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                            child: FlutterFlowRadioButton(
                              options: [
                                'YEP! THAT IS ME',
                                'I AM REALLY INBETWEEN',
                                'NOPE THAT CAN\'T BE ME'
                              ],
                              onChanged: (value) {
                                setState(() => radioButtonValue4 = value);
                              },
                              optionHeight: 25,
                              textStyle: FlutterFlowTheme.of(context)
                                  .bodyText1
                                  .override(
                                    fontFamily: 'Poppins',
                                    color: Colors.black,
                                  ),
                              selectedTextStyle: FlutterFlowTheme.of(context)
                                  .bodyText1
                                  .override(
                                    fontFamily: 'Open Sans',
                                    color: Color(0xFF314A51),
                                  ),
                              buttonPosition: RadioButtonPosition.left,
                              direction: Axis.vertical,
                              radioButtonColor: Color(0xFF00A8A3),
                              inactiveRadioButtonColor: Color(0x8A314A51),
                              toggleable: false,
                              horizontalAlignment: WrapAlignment.start,
                              verticalAlignment: WrapCrossAlignment.start,
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
                            child: Text(
                              '37. I use my sense of smell to help remember memories.',
                              style: FlutterFlowTheme.of(context)
                                  .bodyText1
                                  .override(
                                    fontFamily: 'Poppins',
                                    color: Color(0xFF151515),
                                  ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                            child: FlutterFlowRadioButton(
                              options: [
                                'YEP! THAT IS ME',
                                'I AM REALLY INBETWEEN',
                                'NOPE THAT CAN\'T BE ME'
                              ],
                              onChanged: (value) {
                                setState(() => radioButtonValue4 = value);
                              },
                              optionHeight: 25,
                              textStyle: FlutterFlowTheme.of(context)
                                  .bodyText1
                                  .override(
                                    fontFamily: 'Poppins',
                                    color: Colors.black,
                                  ),
                              selectedTextStyle: FlutterFlowTheme.of(context)
                                  .bodyText1
                                  .override(
                                    fontFamily: 'Open Sans',
                                    color: Color(0xFF314A51),
                                  ),
                              buttonPosition: RadioButtonPosition.left,
                              direction: Axis.vertical,
                              radioButtonColor: Color(0xFF00A8A3),
                              inactiveRadioButtonColor: Color(0x8A314A51),
                              toggleable: false,
                              horizontalAlignment: WrapAlignment.start,
                              verticalAlignment: WrapCrossAlignment.start,
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
                            child: Text(
                              '38. I make decisions based on my emotions.',
                              style: FlutterFlowTheme.of(context)
                                  .bodyText1
                                  .override(
                                    fontFamily: 'Poppins',
                                    color: Color(0xFF151515),
                                  ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                            child: FlutterFlowRadioButton(
                              options: [
                                'YEP! THAT IS ME',
                                'I AM REALLY INBETWEEN',
                                'NOPE THAT CAN\'T BE ME'
                              ],
                              onChanged: (value) {
                                setState(() => radioButtonValue4 = value);
                              },
                              optionHeight: 25,
                              textStyle: FlutterFlowTheme.of(context)
                                  .bodyText1
                                  .override(
                                    fontFamily: 'Poppins',
                                    color: Colors.black,
                                  ),
                              selectedTextStyle: FlutterFlowTheme.of(context)
                                  .bodyText1
                                  .override(
                                    fontFamily: 'Open Sans',
                                    color: Color(0xFF314A51),
                                  ),
                              buttonPosition: RadioButtonPosition.left,
                              direction: Axis.vertical,
                              radioButtonColor: Color(0xFF00A8A3),
                              inactiveRadioButtonColor: Color(0x8A314A51),
                              toggleable: false,
                              horizontalAlignment: WrapAlignment.start,
                              verticalAlignment: WrapCrossAlignment.start,
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
                            child: Text(
                              '39. I need time alone to recharge.',
                              style: FlutterFlowTheme.of(context)
                                  .bodyText1
                                  .override(
                                    fontFamily: 'Poppins',
                                    color: Color(0xFF151515),
                                  ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                            child: FlutterFlowRadioButton(
                              options: [
                                'YEP! THAT IS ME',
                                'I AM REALLY INBETWEEN',
                                'NOPE THAT CAN\'T BE ME'
                              ],
                              onChanged: (value) {
                                setState(() => radioButtonValue4 = value);
                              },
                              optionHeight: 25,
                              textStyle: FlutterFlowTheme.of(context)
                                  .bodyText1
                                  .override(
                                    fontFamily: 'Poppins',
                                    color: Colors.black,
                                  ),
                              selectedTextStyle: FlutterFlowTheme.of(context)
                                  .bodyText1
                                  .override(
                                    fontFamily: 'Open Sans',
                                    color: Color(0xFF314A51),
                                  ),
                              buttonPosition: RadioButtonPosition.left,
                              direction: Axis.vertical,
                              radioButtonColor: Color(0xFF00A8A3),
                              inactiveRadioButtonColor: Color(0x8A314A51),
                              toggleable: false,
                              horizontalAlignment: WrapAlignment.start,
                              verticalAlignment: WrapCrossAlignment.start,
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
                            child: Text(
                              '40. I like to keep my room organized and clean.',
                              style: FlutterFlowTheme.of(context)
                                  .bodyText1
                                  .override(
                                    fontFamily: 'Poppins',
                                    color: Color(0xFF151515),
                                  ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                            child: FlutterFlowRadioButton(
                              options: [
                                'YEP! THAT IS ME',
                                'I AM REALLY INBETWEEN',
                                'NOPE THAT CAN\'T BE ME'
                              ],
                              onChanged: (value) {
                                setState(() => radioButtonValue4 = value);
                              },
                              optionHeight: 25,
                              textStyle: FlutterFlowTheme.of(context)
                                  .bodyText1
                                  .override(
                                    fontFamily: 'Poppins',
                                    color: Colors.black,
                                  ),
                              selectedTextStyle: FlutterFlowTheme.of(context)
                                  .bodyText1
                                  .override(
                                    fontFamily: 'Open Sans',
                                    color: Color(0xFF314A51),
                                  ),
                              buttonPosition: RadioButtonPosition.left,
                              direction: Axis.vertical,
                              radioButtonColor: Color(0xFF00A8A3),
                              inactiveRadioButtonColor: Color(0x8A314A51),
                              toggleable: false,
                              horizontalAlignment: WrapAlignment.start,
                              verticalAlignment: WrapCrossAlignment.start,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Align(
                                alignment: AlignmentDirectional(0, 0),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 24, 0, 0),
                                  child: FFButtonWidget(
                                    onPressed: () async {
                                      await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              PsychometricsAssesentStep3Widget(),
                                        ),
                                      );
                                    },
                                    text: 'Back',
                                    options: FFButtonOptions(
                                      width: 130,
                                      height: 40,
                                      color: Color(0xFF00A8A3),
                                      textStyle: FlutterFlowTheme.of(context)
                                          .subtitle2
                                          .override(
                                            fontFamily: 'Open Sans',
                                            color: Colors.white,
                                          ),
                                      borderSide: BorderSide(
                                        color: Colors.transparent,
                                        width: 1,
                                      ),
                                      borderRadius: 12,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 50.0,
                              ),
                              Align(
                                alignment: AlignmentDirectional(0, 0),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 24, 0, 0),
                                  child: InkWell(
                                    onTap: () async {
                                      await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              PsychometricAssesentResultScreenWidget(),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      width: 130,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        color: Color(0xFF00A8A3),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Row(
                                        // mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Finish',
                                            style: FlutterFlowTheme.of(context)
                                                .subtitle2
                                                .override(
                                                  fontFamily: 'Open Sans',
                                                  color: Colors.white,
                                                ),
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    12, 0, 0, 0),
                                            child: Image.asset(
                                              'assets/images/Layer_2.png',
                                              width: 25,
                                              height: 25,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),

                              // Align(
                              //   alignment: AlignmentDirectional(0, 0),
                              //   child: Padding(
                              //     padding: EdgeInsetsDirectional.fromSTEB(
                              //         0, 24, 0, 0),
                              //     child: InkWell(
                              //       onTap: () async {
                              //         await Navigator.push(
                              //           context,
                              //           MaterialPageRoute(
                              //             builder: (context) =>
                              //                 PsychometricAssesentResultScreenWidget(),
                              //           ),
                              //         );
                              //       },
                              //       child: Container(
                              //         width: MediaQuery.of(context).size.width *
                              //             0.7,
                              //         height: 55,
                              //         decoration: BoxDecoration(
                              //           color: Color(0xFF00A8A3),
                              //           borderRadius: BorderRadius.circular(22),
                              //         ),
                              //         child: Row(
                              //           // mainAxisSize: MainAxisSize.max,
                              //           mainAxisAlignment:
                              //               MainAxisAlignment.center,
                              //           children: [
                              //             Text(
                              //               'Finish',
                              //               style: FlutterFlowTheme.of(context)
                              //                   .title1
                              //                   .override(
                              //                     fontFamily: 'Open Sans',
                              //                     color: Colors.white,
                              //                   ),
                              //             ),
                              //             Padding(
                              //               padding:
                              //                   EdgeInsetsDirectional.fromSTEB(
                              //                       12, 0, 0, 0),
                              //               child: Image.asset(
                              //                 'assets/images/Layer_2.png',
                              //                 width: 35,
                              //                 height: 35,
                              //                 fit: BoxFit.cover,
                              //               ),
                              //             ),
                              //           ],
                              //         ),
                              //       ),
                              //     ),
                              //   ),
                              // ),

                              //   Align(
                              //     alignment: AlignmentDirectional(0, 0),
                              //     child: Padding(
                              //       padding: EdgeInsetsDirectional.fromSTEB(
                              //           0, 24, 0, 0),
                              //       child: FFButtonWidget(
                              //         onPressed: () async {
                              //           await Navigator.push(
                              //             context,
                              //             MaterialPageRoute(
                              //               builder: (context) =>
                              //                   PsychometricAssesentResultScreenWidget(),
                              //             ),
                              //           );
                              //         },
                              //         text: 'Finish',
                              //         options: FFButtonOptions(
                              //           width: 130,
                              //           height: 40,
                              //           color: Color(0xFF00A8A3),
                              //           textStyle: FlutterFlowTheme.of(context)
                              //               .subtitle2
                              //               .override(
                              //                 fontFamily: 'Poppins',
                              //                 color: Colors.white,
                              //               ),
                              //           borderSide: BorderSide(
                              //             color: Colors.transparent,
                              //             width: 1,
                              //           ),
                              //           borderRadius: 12,
                              //         ),
                              //       ),
                              //     ),
                              //   ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
