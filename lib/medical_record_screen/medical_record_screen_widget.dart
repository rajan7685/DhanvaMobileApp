import '../components/medical_record_bottom_sheet_widget.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

class MedicalRecordScreenWidget extends StatefulWidget {
  const MedicalRecordScreenWidget({Key key}) : super(key: key);

  @override
  _MedicalRecordScreenWidgetState createState() =>
      _MedicalRecordScreenWidgetState();
}

class _MedicalRecordScreenWidgetState extends State<MedicalRecordScreenWidget> {
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
            padding: EdgeInsetsDirectional.fromSTEB(0, 2, 14, 2),
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
                    'Medical Records',
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
                    Text(
                      'Have a look at medical records',
                      style: FlutterFlowTheme.of(context).bodyText1.override(
                            fontFamily: 'Open Sans',
                            fontSize: 18,
                          ),
                    ),
                    Expanded(
                      child: Align(
                        alignment: AlignmentDirectional(0.65, 0),
                        child: Image.asset(
                          'assets/images/Group_608.png',
                          width: 35,
                          height: 35,
                          fit: BoxFit.contain,
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
                                    child: MedicalRecordBottomSheetWidget(),
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
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(12, 8, 12, 8),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Image.asset(
                                    'assets/images/Group_607.png',
                                    width: 65,
                                    height: 65,
                                    fit: BoxFit.contain,
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          12, 0, 0, 0),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'C.T. scan',
                                            style: FlutterFlowTheme.of(context)
                                                .bodyText1
                                                .override(
                                                  fontFamily: 'Open Sans',
                                                  color: Colors.black,
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                          ),
                                          Text(
                                            'Srinavasa (Father)',
                                            style: FlutterFlowTheme.of(context)
                                                .bodyText1,
                                          ),
                                          Text(
                                            'Fr A R Rajesh',
                                            style: FlutterFlowTheme.of(context)
                                                .bodyText1,
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0, 8, 0, 0),
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
                                EdgeInsetsDirectional.fromSTEB(12, 8, 12, 8),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Image.asset(
                                  'assets/images/Group_610.png',
                                  width: 65,
                                  height: 65,
                                  fit: BoxFit.contain,
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        12, 0, 0, 0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'MRI scan',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyText1
                                              .override(
                                                fontFamily: 'Open Sans',
                                                color: Colors.black,
                                                fontSize: 20,
                                                fontWeight: FontWeight.w600,
                                              ),
                                        ),
                                        Text(
                                          'Srinavasa (Father)',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyText1,
                                        ),
                                        Text(
                                          'Fr A R Rajesh',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyText1,
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0, 8, 0, 0),
                                          child: Text(
                                            'Dec 20, 2021 1:02PM',
                                            style: FlutterFlowTheme.of(context)
                                                .bodyText1
                                                .override(
                                                  fontFamily: 'Open Sans',
                                                  fontSize: 12,
                                                ),
                                          ),
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
                                EdgeInsetsDirectional.fromSTEB(12, 8, 12, 8),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Image.asset(
                                  'assets/images/Group_607.png',
                                  width: 65,
                                  height: 65,
                                  fit: BoxFit.contain,
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        12, 0, 0, 0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'C.T. scan',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyText1
                                              .override(
                                                fontFamily: 'Open Sans',
                                                color: Colors.black,
                                                fontSize: 20,
                                                fontWeight: FontWeight.w600,
                                              ),
                                        ),
                                        Text(
                                          'Srinavasa (Father)',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyText1,
                                        ),
                                        Text(
                                          'Fr A R Rajesh',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyText1,
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0, 8, 0, 0),
                                          child: Text(
                                            'Dec 20, 2021 1:02PM',
                                            style: FlutterFlowTheme.of(context)
                                                .bodyText1
                                                .override(
                                                  fontFamily: 'Open Sans',
                                                  fontSize: 12,
                                                ),
                                          ),
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
