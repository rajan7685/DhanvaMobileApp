import '../components/next_icon_button_widget.dart';
import '../flutter_flow/flutter_flow_radio_button.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

class StartBookingScreen2Widget extends StatefulWidget {
  const StartBookingScreen2Widget({Key key}) : super(key: key);

  @override
  _StartBookingScreen2WidgetState createState() =>
      _StartBookingScreen2WidgetState();
}

class _StartBookingScreen2WidgetState extends State<StartBookingScreen2Widget> {
  String radioButtonValue1;
  String radioButtonValue2;
  TextEditingController textController1;
  TextEditingController textController2;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    textController1 = TextEditingController(text: 'Someone Sick');
    textController2 = TextEditingController();
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
                height: MediaQuery.of(context).size.height * 0.3,
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
                    Icon(
                      Icons.arrow_back_rounded,
                      color: Colors.white,
                      size: 34,
                    ),
                    Expanded(
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 0, 12, 0),
                            child: Container(
                              width: 45,
                              height: 45,
                              decoration: BoxDecoration(
                                color: Color(0xFFEEEEEE),
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: Image.network(
                                    'data:image/jpeg;base64,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',
                                  ).image,
                                ),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: Color(0xFF00FFF9),
                                  width: 2,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: 45,
                            height: 45,
                            decoration: BoxDecoration(
                              color: Color(0xFF00827F),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Align(
                              alignment: AlignmentDirectional(0, 0),
                              child: Icon(
                                Icons.notifications_outlined,
                                color: Color(0xFFF3F4F4),
                                size: 24,
                              ),
                            ),
                          ),
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
                      'Cardiologist Appointments',
                      style: FlutterFlowTheme.of(context).bodyText1.override(
                            fontFamily: 'Open Sans',
                            color: Color(0xFFF3F4F4),
                            fontSize: 20,
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
                  height: MediaQuery.of(context).size.height * 0.7,
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
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        TextFormField(
                          controller: textController1,
                          obscureText: false,
                          decoration: InputDecoration(
                            labelText: 'Patient Name',
                            labelStyle:
                                FlutterFlowTheme.of(context).bodyText1.override(
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
                          style:
                              FlutterFlowTheme.of(context).bodyText1.override(
                                    fontFamily: 'Open Sans',
                                    color: Color(0xFF606E87),
                                    fontSize: 18,
                                  ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
                          child: TextFormField(
                            controller: textController2,
                            obscureText: false,
                            decoration: InputDecoration(
                              hintText: 'Health problem',
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
                            style:
                                FlutterFlowTheme.of(context).bodyText1.override(
                                      fontFamily: 'Poppins',
                                      color: Color(0xFF606E87),
                                    ),
                            maxLines: 5,
                          ),
                        ),
                        Align(
                          alignment: AlignmentDirectional(-1, 0),
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
                            child: Text(
                              'Do you want to your doctor?',
                              style: FlutterFlowTheme.of(context)
                                  .bodyText1
                                  .override(
                                    fontFamily: 'Open Sans',
                                    color: Color(0xFF606E87),
                                    fontSize: 20,
                                  ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              FlutterFlowRadioButton(
                                options: ['Yes'],
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
                                      color: Color(0xFF606E87),
                                    ),
                                buttonPosition: RadioButtonPosition.left,
                                direction: Axis.vertical,
                                radioButtonColor: Color(0xFF00A8A3),
                                inactiveRadioButtonColor: Colors.white,
                                toggleable: false,
                                horizontalAlignment: WrapAlignment.start,
                                verticalAlignment: WrapCrossAlignment.start,
                              ),
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                                child: FlutterFlowRadioButton(
                                  options: ['Help me with available doctor'],
                                  initialValue: 'null',
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
                                  selectedTextStyle:
                                      FlutterFlowTheme.of(context)
                                          .bodyText1
                                          .override(
                                            fontFamily: 'Open Sans',
                                            color: Color(0xFF606E87),
                                          ),
                                  buttonPosition: RadioButtonPosition.left,
                                  direction: Axis.vertical,
                                  radioButtonColor: Color(0xFF00A8A3),
                                  inactiveRadioButtonColor: Color(0xFF606E87),
                                  toggleable: false,
                                  horizontalAlignment: WrapAlignment.start,
                                  verticalAlignment: WrapCrossAlignment.start,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Spacer(),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.7,
                          height: 55,
                          decoration: BoxDecoration(
                            color: Color(0xFF00A8A3),
                            borderRadius: BorderRadius.circular(18),
                          ),
                          child: NextIconButtonWidget(),
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
    );
  }
}
