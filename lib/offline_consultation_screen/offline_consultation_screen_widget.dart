import 'dart:convert';

import 'package:dhanva_mobile_app/components/notification_icon_button.dart';
import 'package:dhanva_mobile_app/doctors_by_hospital_screen/doctors_by_hospital_screen_widget.dart';
import 'package:dhanva_mobile_app/flutter_flow/flutter_flow_theme.dart';
import 'package:dhanva_mobile_app/offline_consultation_screen/services_by_hospital_screen.dart';
import 'package:flutter/material.dart';

class OfflineConsultationScreen extends StatefulWidget {
  const OfflineConsultationScreen({Key key}) : super(key: key);

  @override
  State<OfflineConsultationScreen> createState() =>
      _OfflineConsultationScreenState();
}

class _OfflineConsultationScreenState extends State<OfflineConsultationScreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  bool isDataLoading = true;
  List<dynamic> _hospitalJsonList;

  final String hospitalListData = """[
    {
        "location": {
            "coordinates": [
                111,
                111
            ],
            "type": "Point"
        },
        "hospital_name": "Test",
        "logo": "/appolo.png",
        "address_line_1": "test Street",
        "address_line_2": "Thirupalai",
        "service": [],
        "enabled": false,
        "_id": "62702fd41275131dcf0b64a9",
        "city": "Madurai",
        "hospital_license_number": "1234567890",
        "prescription_format": "<html></html>",
        "createdAt": "2022-05-02T19:24:04.312Z",
        "__v": 0
    },
    {
        "location": {
            "coordinates": [
                111,
                111
            ],
            "type": "Point"
        },
        "hospital_name": "Test 3",
        "logo": "/appolo.png",
        "address_line_1": "test Street",
        "address_line_2": "Thirupalai",
        "service": [
            "6005ed2fe29edb6ec7976d72",
            "6005ed42e29edb6ec7976d73"
        ],
        "enabled": true,
        "_id": "6270d49d93c9af9f5a968b99",
        "city": "Madurai",
        "hospital_license_number": "1234567890",
        "prescription_format": "<html></html>",
        "createdAt": "2022-05-03T07:07:09.711Z",
        "__v": 0
    }
]""";

  void _loadHospitalData() async {
    await Future.delayed(Duration(milliseconds: 850));
    _hospitalJsonList = jsonDecode(hospitalListData);
    setState(() {
      isDataLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadHospitalData();
  }

  @override
  void dispose() {
    //
    super.dispose();
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
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    // Container(
                    //   width: 45,
                    //   height: 45,
                    //   decoration: BoxDecoration(
                    //     color: Color(0xFF00827F),
                    //     borderRadius: BorderRadius.circular(12),
                    //   ),
                    //   child: Icon(
                    //     Icons.notifications_outlined,
                    //     color: Color(0xFFF3F4F4),
                    //     size: 24,
                    //   ),
                    // ),
                    NotificationIconButton()
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
                      'Hospitals',
                      textAlign: TextAlign.start,
                      style: FlutterFlowTheme.of(context).bodyText1.override(
                            fontFamily: 'Open Sans',
                            color: Color(0xFFF3F4F4),
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    Text(
                      'Find Hospitals Near You',
                      style: FlutterFlowTheme.of(context).bodyText1.override(
                            fontFamily: 'Open Sans',
                            color: Color(0xFFF3F4F4),
                            fontSize: 20,
                          ),
                    ),
                  ],
                ),
              ),
              Align(
                alignment: AlignmentDirectional(0, 1),
                child: Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.65,
                  decoration: BoxDecoration(
                    color: Color(0xFFEEEEEE),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(0),
                      bottomRight: Radius.circular(0),
                      topLeft: Radius.circular(36),
                      topRight: Radius.circular(36),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(14, 12, 14, 0),
                    child: isDataLoading
                        ? CircularProgressIndicator()
                        : ListView.builder(
                            padding: EdgeInsets.zero,
                            scrollDirection: Axis.vertical,
                            itemCount: _hospitalJsonList.length,
                            itemBuilder: (context, index) =>
                                _buildHospitalListItem(context, index)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHospitalListItem(BuildContext context, int index) {
    return Container(
      padding: EdgeInsets.only(bottom: 12),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Color(0xFFEEEEEE),
      ),
      child: InkWell(
        onTap: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ServicesByHospitalScreen(
                hospitalDetails: _hospitalJsonList[index],
              ),
            ),
          );
        },
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _hospitalJsonList[index]['hospital_name'],
                    style: FlutterFlowTheme.of(context).title1.override(
                          fontSize: 16,
                          fontFamily: 'Open Sans',
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                  ),
                  Text(
                    '2km away',
                    style: FlutterFlowTheme.of(context).bodyText1.override(
                          fontFamily: 'Poppins',
                          fontSize: 12,
                        ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
                    child: Text(
                      _hospitalJsonList[index]['address_line_1'],
                      style: FlutterFlowTheme.of(context).bodyText1.override(
                            fontFamily: 'Open Sans',
                            color: Colors.black,
                            fontSize: 14,
                          ),
                    ),
                  ),
                  Text(
                    '${_hospitalJsonList[index]['address_line_2']}, ${_hospitalJsonList[index]['city']}',
                    style: FlutterFlowTheme.of(context).bodyText1.override(
                          fontFamily: 'Open Sans',
                          color: Colors.black,
                          fontSize: 14,
                        ),
                  ),
                  // state with pin
                  // Text(
                  //   'Tamil Nadu 600016',
                  //   style: FlutterFlowTheme.of(context).bodyText1.override(
                  //         fontFamily: 'Open Sans',
                  //         color: Colors.black,
                  //         fontSize: 14,
                  //       ),
                  // ),
                  Text(
                    'Open 24 hrs',
                    style: FlutterFlowTheme.of(context).bodyText1.override(
                          fontFamily: 'Poppins',
                          color: Color(0xFF00A8A3),
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                ],
              ),
            ),
            // Icon(
            //   Icons.arrow_forward_ios_sharp,
            //   color: Color(0xFF606E87),
            //   size: 30,
            // ),
          ],
        ),
      ),
    );
  }
}