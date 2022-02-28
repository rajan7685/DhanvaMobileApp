import '../components/appointments_bottom_sheet_widget.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

class AppointmentsScreenWidget extends StatefulWidget {
  const AppointmentsScreenWidget({Key key}) : super(key: key);

  @override
  _AppointmentsScreenWidgetState createState() =>
      _AppointmentsScreenWidgetState();
}

class _AppointmentsScreenWidgetState extends State<AppointmentsScreenWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: Color(0xFFF3F4F4),
        iconTheme: IconThemeData(color: Color(0xFF00A8A3)),
        automaticallyImplyLeading: true,
        actions: [
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0, 0, 12, 0),
            child: Container(
              width: 45,
              height: 25,
              decoration: BoxDecoration(
                color: Color(0xFF00827F),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                Icons.notifications_none,
                color: Colors.white,
                size: 24,
              ),
            ),
          ),
        ],
        centerTitle: true,
        elevation: 0,
      ),
      backgroundColor: Color(0xFFF3F4F4),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print('FloatingActionButton pressed ...');
        },
        backgroundColor: FlutterFlowTheme.of(context).primaryColor,
        elevation: 8,
        child: Icon(
          Icons.add_rounded,
          color: Colors.white,
          size: 24,
        ),
      ),
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(12, 0, 12, 0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
                  child: Text(
                    'Appointments',
                    style: FlutterFlowTheme.of(context).bodyText1.override(
                          fontFamily: 'Open Sans',
                          color: Color(0xFF00A8A3),
                          fontSize: 32,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 2, 0, 0),
                      child: Text(
                        'Completed, Present & Upcoming',
                        style: FlutterFlowTheme.of(context).bodyText1.override(
                              fontFamily: 'Open Sans',
                              fontSize: 18,
                            ),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: ListView(
                    padding: EdgeInsets.zero,
                    scrollDirection: Axis.vertical,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
                        child: InkWell(
                          onTap: () async {
                            await showModalBottomSheet(
                              isScrollControlled: true,
                              backgroundColor: Colors.transparent,
                              context: context,
                              builder: (context) {
                                return Padding(
                                  padding: MediaQuery.of(context).viewInsets,
                                  child: Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.65,
                                    child: AppointmentsBottomSheetWidget(),
                                  ),
                                );
                              },
                            );
                          },
                          child: Card(
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            color: Colors.white,
                            elevation: 2,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  12, 12, 12, 12),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: Image.network(
                                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQvDVXm8awuyibcdpoTSPoePE6-OKncWYyNK9QF-YO66FyUIWHrlF8hbvBU7Gml5eoeeGw&usqp=CAU',
                                      width: 70,
                                      height: 85,
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                  Expanded(
                                    child: Align(
                                      alignment: AlignmentDirectional(0, 0.15),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            12, 0, 0, 0),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisSize: MainAxisSize.max,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                                  'Srinavasn',
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyText1
                                                      .override(
                                                        fontFamily: 'Open Sans',
                                                        color: Colors.black,
                                                        fontSize: 22,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                ),
                                                Text(
                                                  ' (Father)',
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyText1
                                                      .override(
                                                        fontFamily: 'Open Sans',
                                                        fontSize: 12,
                                                      ),
                                                ),
                                              ],
                                            ),
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(0, 2, 0, 0),
                                              child: Text(
                                                'Dec 20, 2021 1:02PM',
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyText1
                                                        .override(
                                                          fontFamily:
                                                              'Open Sans',
                                                          fontSize: 12,
                                                        ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(0, 6, 0, 0),
                                              child: FFButtonWidget(
                                                onPressed: () {
                                                  print('Button pressed ...');
                                                },
                                                text: 'Booked',
                                                options: FFButtonOptions(
                                                  width: 80,
                                                  height: 26,
                                                  color: Colors.white,
                                                  textStyle: FlutterFlowTheme
                                                          .of(context)
                                                      .subtitle2
                                                      .override(
                                                        fontFamily: 'Poppins',
                                                        color:
                                                            Color(0xFF0BA6C3),
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                  borderSide: BorderSide(
                                                    color: Color(0xFF0BA6C3),
                                                    width: 2,
                                                  ),
                                                  borderRadius: 12,
                                                ),
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
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
                        child: Card(
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          color: Colors.white,
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(12, 12, 12, 12),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Image.network(
                                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQvDVXm8awuyibcdpoTSPoePE6-OKncWYyNK9QF-YO66FyUIWHrlF8hbvBU7Gml5eoeeGw&usqp=CAU',
                                    width: 70,
                                    height: 85,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                                Expanded(
                                  child: Align(
                                    alignment: AlignmentDirectional(0, 0.15),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          12, 0, 0, 0),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisSize: MainAxisSize.max,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                'Srinavasn',
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyText1
                                                        .override(
                                                          fontFamily:
                                                              'Open Sans',
                                                          color: Colors.black,
                                                          fontSize: 22,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        ),
                                              ),
                                              Text(
                                                ' (Father)',
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyText1
                                                        .override(
                                                          fontFamily:
                                                              'Open Sans',
                                                          fontSize: 12,
                                                        ),
                                              ),
                                            ],
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0, 2, 0, 0),
                                            child: Text(
                                              'Dec 20, 2021 1:02PM',
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyText1
                                                      .override(
                                                        fontFamily: 'Open Sans',
                                                        fontSize: 12,
                                                      ),
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0, 6, 0, 0),
                                            child: FFButtonWidget(
                                              onPressed: () {
                                                print('Button pressed ...');
                                              },
                                              text: 'Cancelled',
                                              options: FFButtonOptions(
                                                width: 110,
                                                height: 26,
                                                color: Colors.white,
                                                textStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .subtitle2
                                                        .override(
                                                          fontFamily: 'Poppins',
                                                          color:
                                                              Color(0xFFC3180B),
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                borderSide: BorderSide(
                                                  color: Color(0xFFC3180B),
                                                  width: 2,
                                                ),
                                                borderRadius: 12,
                                              ),
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
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
                        child: Card(
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          color: Colors.white,
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(12, 12, 12, 12),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Image.network(
                                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQvDVXm8awuyibcdpoTSPoePE6-OKncWYyNK9QF-YO66FyUIWHrlF8hbvBU7Gml5eoeeGw&usqp=CAU',
                                    width: 70,
                                    height: 85,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                                Expanded(
                                  child: Align(
                                    alignment: AlignmentDirectional(0, 0.15),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          12, 0, 0, 0),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisSize: MainAxisSize.max,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                'Srinavasn',
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyText1
                                                        .override(
                                                          fontFamily:
                                                              'Open Sans',
                                                          color: Colors.black,
                                                          fontSize: 22,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        ),
                                              ),
                                              Text(
                                                ' (Father)',
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyText1
                                                        .override(
                                                          fontFamily:
                                                              'Open Sans',
                                                          fontSize: 12,
                                                        ),
                                              ),
                                            ],
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0, 2, 0, 0),
                                            child: Text(
                                              'Dec 20, 2021 1:02PM',
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyText1
                                                      .override(
                                                        fontFamily: 'Open Sans',
                                                        fontSize: 12,
                                                      ),
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0, 6, 0, 0),
                                            child: FFButtonWidget(
                                              onPressed: () {
                                                print('Button pressed ...');
                                              },
                                              text: 'Booked',
                                              options: FFButtonOptions(
                                                width: 80,
                                                height: 26,
                                                color: Colors.white,
                                                textStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .subtitle2
                                                        .override(
                                                          fontFamily: 'Poppins',
                                                          color:
                                                              Color(0xFF0BA6C3),
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                borderSide: BorderSide(
                                                  color: Color(0xFF0BA6C3),
                                                  width: 2,
                                                ),
                                                borderRadius: 12,
                                              ),
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
                    ],
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
