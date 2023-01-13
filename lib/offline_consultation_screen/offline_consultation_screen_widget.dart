import 'dart:convert';

import 'package:dhanva_mobile_app/components/notification_icon_button.dart';
import 'package:dhanva_mobile_app/doctors_by_hospital_screen/doctors_by_hospital_screen_widget.dart';
import 'package:dhanva_mobile_app/flutter_flow/flutter_flow_theme.dart';
import 'package:dhanva_mobile_app/global/models/patient.dart';
import 'package:dhanva_mobile_app/global/services/api_services/api_service_base.dart';
import 'package:dhanva_mobile_app/global/services/shared_preference_service.dart';
import 'package:dhanva_mobile_app/offline_consultation_screen/services_by_hospital_screen.dart';
import 'package:dhanva_mobile_app/profile_screen/edit_profile_screen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

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
  TextEditingController searchController;
  String _hospitalListApi = 'https://api2.dhanva.icu/hospital/get_all_enabled';

  // Future<void> _checkNetworkConnectivity() async {
  //   ConnectivityResult connectivityResult =
  //       await Connectivity().checkConnectivity();
  //   print(connectivityResult.name);
  //   print(connectivityResult.name);
  //   if (connectivityResult == ConnectivityResult.mobile) {
  //     // ScaffoldMessenger.of(context).showSnackBar(
  //     //     SnackBar(content: Text('You are connected to a mobile network')));
  //     // // I am connected to a mobile network.
  //   } else if (connectivityResult == ConnectivityResult.wifi) {
  //     // ScaffoldMessenger.of(context).showSnackBar(
  //     //     SnackBar(content: Text('You are connected to a wifi network')));
  //     // // I am connected to a wifi network.
  //   } else {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(content: Text('You are not connected to internet')));
  //   }
  // }

  // ignore: unused_field

  Map<String, dynamic> _hospitalListData;
  Map<String, dynamic> _searchResults;

  void _loadHospitalData() async {
    await Future.delayed(Duration(milliseconds: 850));
    Response res = await ApiService.dio.get(_hospitalListApi,
        options: Options(headers: {
          'Authorization': SharedPreferenceService.loadString(key: AuthTokenKey)
        }));
    _hospitalJsonList = res.data;
    // remove the online services
    _hospitalJsonList
        .removeWhere((jsonData) => jsonData['hospital_name'] == 'Online');
    // print(res.data);
    setState(() {
      isDataLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadHospitalData();
    searchController = TextEditingController();
    // _checkNetworkConnectivity();
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
                      'Medical Centers',
                      textAlign: TextAlign.start,
                      style: FlutterFlowTheme.of(context).bodyText1.override(
                            fontFamily: 'Open Sans',
                            color: Color(0xFFF3F4F4),
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    Text(
                      'Find Medical Centers Near You',
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
                        ? Center(child: CircularProgressIndicator())
                        : Column(
                            children: [
                              TextFormField(
                                textInputAction: TextInputAction.search,
                                keyboardType: TextInputType.text,
                                textAlign: TextAlign.start,
                                style: FlutterFlowTheme.of(context)
                                    .bodyText1
                                    .override(
                                      fontFamily: 'Open Sans',
                                      color: Color(0xFF606E87),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                obscureText: false,
                                onChanged: (val) => {
                                  setState(() => {searchController.text = val})
                                },
                                decoration: InputDecoration(
                                  labelText: 'Search Medical Center',
                                  labelStyle: FlutterFlowTheme.of(context)
                                      .bodyText1
                                      .override(
                                        fontFamily: 'Open Sans',
                                        color: Color(0xFF9A9A9A),
                                        fontSize: 14,
                                        fontWeight: FontWeight.normal,
                                      ),
                                  hintStyle: FlutterFlowTheme.of(context)
                                      .bodyText1
                                      .override(
                                        fontFamily: 'Open Sans',
                                        color: Color(0xFF606E87),
                                        fontWeight: FontWeight.normal,
                                      ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0xFFC1C1C1),
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0xFFC1C1C1),
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  filled: true,
                                  fillColor: Colors.white,
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  height: double.maxFinite,
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 10, 0, 0),
                                    child: RefreshIndicator(
                                      onRefresh: () async {
                                        setState(() {
                                          isDataLoading = true;
                                        });
                                        _loadHospitalData();
                                      },
                                      child: ListView.builder(
                                          padding: EdgeInsets.zero,
                                          scrollDirection: Axis.vertical,
                                          itemCount: _hospitalJsonList.length,
                                          itemBuilder: (context, index) =>
                                              _buildHospitalListItem(
                                                  context, index)),
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
      ),
    );
  }

  Widget _buildHospitalListItem(BuildContext context, int index) {
    String hospitalName =
        _hospitalJsonList[index]['hospital_name'].toString().toLowerCase();
    String searchText = searchController.text.toLowerCase();
    print("building box");
    if (searchText.length > 0 && !hospitalName.contains(searchText)) {
      return SizedBox();
    }

    return Container(
      padding: EdgeInsets.only(bottom: 12),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Color(0xFFEEEEEE),
      ),
      child: InkWell(
        onTap: () async {
          Patient _patient = Patient.fromJson(
              jsonDecode(SharedPreferenceService.loadString(key: PatientKey)));
          if (_patient.name == null)
            await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => EditProfileScreenWidget(),
              ),
            );
          else
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
                  // Text(
                  //   '2km away',
                  //   style: FlutterFlowTheme.of(context).bodyText1.override(
                  //         fontFamily: 'Poppins',
                  //         fontSize: 12,
                  //       ),
                  // ),
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
