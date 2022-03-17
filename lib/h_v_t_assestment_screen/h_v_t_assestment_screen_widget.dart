import 'dart:math';

import 'package:dhanva_mobile_app/components/notification_icon_button.dart';

import '../booking_success_screen/booking_success_screen_widget.dart';
import '../flutter_flow/flutter_flow_radio_button.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

class HVTAssestmentScreenWidget extends StatefulWidget {
  const HVTAssestmentScreenWidget({Key key}) : super(key: key);

  @override
  _HVTAssestmentScreenWidgetState createState() =>
      _HVTAssestmentScreenWidgetState();
}

class _HVTAssestmentScreenWidgetState extends State<HVTAssestmentScreenWidget> {
  String radioButtonValue1;
  TextEditingController textController;
  String radioButtonValue2;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    textController = TextEditingController(text: 'Someone Sick');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Color(0xFFF5F5F5),
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Stack(
            children: [
              Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.5,
                decoration: BoxDecoration(
                  color: Color(0xFFEEEEEE),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: Image.asset(
                      'assets/images/page_bgbg.png',
                    ).image,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(12, 8, 12, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () async {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.arrow_back_rounded,
                        color: Colors.white,
                        size: 34,
                      ),
                    ),
                    Expanded(
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          //
                          NotificationIconButton()
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(12, 75, 0, 0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Start Booking',
                      textAlign: TextAlign.start,
                      style: FlutterFlowTheme.of(context).bodyText1.override(
                            fontFamily: 'Open Sans',
                            color: Color(0xFFF3F4F4),
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    Text(
                      'HVT Appointment',
                      style: FlutterFlowTheme.of(context).bodyText1.override(
                            fontFamily: 'Open Sans',
                            color: Color(0xFFF3F4F4),
                            fontSize: 16,
                            fontWeight: FontWeight.w300,
                          ),
                    ),
                  ],
                ),
              ),
              Align(
                alignment: AlignmentDirectional(0, 1),
                child: Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.77,
                  decoration: BoxDecoration(
                    color: Color(0xFFEDF3F3),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(0),
                      bottomRight: Radius.circular(0),
                      topLeft: Radius.circular(36),
                      topRight: Radius.circular(36),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(12, 16, 12, 0),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
                            child: TextFormField(
                              controller: textController,
                              obscureText: false,
                              decoration: InputDecoration(
                                labelText: 'Patient Name',
                                labelStyle: FlutterFlowTheme.of(context)
                                    .bodyText1
                                    .override(
                                      fontFamily: 'Open Sans',
                                      color: Color(0xFF9A9A9A),
                                      fontSize: 16,
                                    ),
                                hintText: '[Some hint text...]',
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0x00000000),
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0x00000000),
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                filled: true,
                                fillColor: Colors.white,
                              ),
                              style: FlutterFlowTheme.of(context)
                                  .bodyText1
                                  .override(
                                    fontFamily: 'Open Sans',
                                    color: Color(0xFF606E87),
                                    fontSize: 18,
                                  ),
                            ),
                          ),
                          Text(
                            'Pre Assesment Questionarie',
                            style:
                                FlutterFlowTheme.of(context).bodyText1.override(
                                      fontFamily: 'Open Sans',
                                      color: Color(0xFF111111),
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                    ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
                            child: Text(
                              'Please choose the shape',
                              style: FlutterFlowTheme.of(context)
                                  .bodyText1
                                  .override(
                                    fontFamily: 'Open Sans',
                                    color: Color(0xFF171717),
                                    fontWeight: FontWeight.w500,
                                  ),
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Image.network(
                                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ4WqcVTv96rNdgWKQLBpi8yV1ZeTRLBZZ1lQ&usqp=CAU',
                                  width: 65,
                                  height: 65,
                                  fit: BoxFit.cover,
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      14, 0, 0, 0),
                                  child: Transform.rotate(
                                    angle: pi,
                                    child: Image.network(
                                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQjVx1KDBtRTQ16NU4goJdtagyFvviKxmAfmA&usqp=CAU',
                                      width: 65,
                                      height: 65,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      14, 0, 0, 0),
                                  child: Image.network(
                                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRy94zzfDFC_EgfIo-OwzaLGxiGTRpkOPXicw&usqp=CAU',
                                    width: 65,
                                    height: 65,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
                            child: Text(
                              '1. How healthy do you consider yourself on a scale of 1 to 10?',
                              style: FlutterFlowTheme.of(context)
                                  .bodyText1
                                  .override(
                                    fontFamily: 'Open Sans',
                                    color: Color(0xFF171717),
                                    fontWeight: FontWeight.w500,
                                  ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(0, 2, 0, 0),
                            child: FlutterFlowRadioButton(
                              options: [
                                '1',
                                '2',
                                '3',
                                '4',
                                '5',
                                '6',
                                '7',
                                '8',
                                '9',
                                '10'
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
                              textPadding:
                                  EdgeInsetsDirectional.fromSTEB(4, 0, 16, 0),
                              buttonPosition: RadioButtonPosition.left,
                              direction: Axis.horizontal,
                              radioButtonColor: Color(0xFF00A8A3),
                              inactiveRadioButtonColor: Color(0x8A000000),
                              toggleable: false,
                              horizontalAlignment: WrapAlignment.spaceEvenly,
                              verticalAlignment: WrapCrossAlignment.start,
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
                            child: Text(
                              '2. How often  do you get a health checkup?',
                              style: FlutterFlowTheme.of(context).bodyText1,
                            ),
                          ),
                          FlutterFlowRadioButton(
                            options: [
                              'Once in Months',
                              'Once a year',
                              'On when needed',
                              'Never get it done',
                              'Other'
                            ],
                            onChanged: (value) {
                              setState(() => radioButtonValue2 = value);
                            },
                            optionHeight: 35,
                            textStyle:
                                FlutterFlowTheme.of(context).bodyText1.override(
                                      fontFamily: 'Poppins',
                                      color: Colors.black,
                                    ),
                            buttonPosition: RadioButtonPosition.left,
                            direction: Axis.vertical,
                            radioButtonColor: Color(0xFF00A8A3),
                            inactiveRadioButtonColor: Color(0x8A000000),
                            toggleable: false,
                            horizontalAlignment: WrapAlignment.start,
                            verticalAlignment: WrapCrossAlignment.start,
                          ),
                          Align(
                            alignment: AlignmentDirectional(0, 0),
                            child: Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 24, 0, 0),
                              child: InkWell(
                                onTap: () async {
                                  await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          BookingSuccessScreenWidget(),
                                    ),
                                  );
                                },
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.82,
                                  height: 55,
                                  decoration: BoxDecoration(
                                    color: Color(0xFF00A8A3),
                                    borderRadius: BorderRadius.circular(24),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Next Slot at 11:00 AM',
                                        style: FlutterFlowTheme.of(context)
                                            .bodyText1
                                            .override(
                                              fontFamily: 'Open Sans',
                                              color: Colors.white,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            8, 0, 0, 0),
                                        child: Image.asset(
                                          'assets/images/Layer_2.png',
                                          width: 30,
                                          height: 30,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Align(
                            alignment: AlignmentDirectional(0, 0),
                            child: Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 4, 0, 4),
                              child: Text(
                                'Or, ',
                                style: FlutterFlowTheme.of(context).bodyText1,
                              ),
                            ),
                          ),
                          Align(
                            alignment: AlignmentDirectional(0, 0),
                            child: Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 0, 0, 12),
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.82,
                                height: 55,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(24),
                                  border: Border.all(
                                    color: Color(0xFF00A8A3),
                                    width: 2,
                                  ),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Schedule your Slot',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyText1
                                          .override(
                                            fontFamily: 'Open Sans',
                                            color: Color(0xFF00A8A3),
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          8, 0, 0, 0),
                                      child: Image.asset(
                                        'assets/images/Layer_2__.png',
                                        width: 30,
                                        height: 30,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
