import 'dart:convert';

import 'package:dhanva_mobile_app/components/notification_icon_button.dart';
import 'package:dhanva_mobile_app/family_members_screen/add_family_members_screen.dart';
import 'package:dhanva_mobile_app/family_members_screen/update_family_member_screen.dart';
import 'package:dhanva_mobile_app/global/models/patient.dart';
import 'package:dhanva_mobile_app/global/services/api_services/api_service_base.dart';
import 'package:dhanva_mobile_app/global/services/shared_preference_service.dart';
import 'package:dio/dio.dart';

import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

class FamilyMembersScreenWidget extends StatefulWidget {
  const FamilyMembersScreenWidget({Key key}) : super(key: key);

  @override
  _FamilyMembersScreenWidgetState createState() =>
      _FamilyMembersScreenWidgetState();
}

class _FamilyMembersScreenWidgetState extends State<FamilyMembersScreenWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  bool isLoading = true;
  List<dynamic> _familyMemberList;
  Patient patient;
  Future<void> _loadMembersData() async {
    await SharedPreferenceService.init();
    patient = Patient.fromJson(
        jsonDecode(SharedPreferenceService.loadString(key: PatientKey)));
    Response res = await ApiService.dio.get(
        "http://api3.dhanva.icu/patient/getPatientRelations/${patient.id}",
        options: Options(headers: {
          'Authorization': SharedPreferenceService.loadString(key: AuthTokenKey)
        }));
    _familyMemberList = res.data;
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    _loadMembersData();
    super.initState();
  }

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
              child: NotificationIconButton()),
        ],
        centerTitle: true,
        elevation: 0,
      ),
      backgroundColor: Color(0xFFF3F4F4),
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
                    'Family Members',
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
                      'Manage your Family Members',
                      style: FlutterFlowTheme.of(context).bodyText1.override(
                            fontFamily: 'Open Sans',
                            fontSize: 18,
                          ),
                    ),
                  ],
                ),
                if (isLoading)
                  Expanded(child: Center(child: CircularProgressIndicator()))
                else
                  Expanded(
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
                      child: ListView.builder(
                        padding: EdgeInsets.zero,
                        scrollDirection: Axis.vertical,
                        itemCount: _familyMemberList.length,
                        itemBuilder: (_, int index) {
                          return InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) =>
                                            UpdateFamilyMemberWidget(
                                                memberData:
                                                    _familyMemberList[index])));
                              },
                              child: _buildFamilyMember(context, index));
                        },
                      ),
                    ),
                  ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(12, 18, 12, 10),
                  child: Container(
                    height: 55,
                    decoration: BoxDecoration(
                      color: Color(0xFFEEEEEE),
                      borderRadius: BorderRadius.circular(36),
                      border: Border.all(
                        color: Color(0xFF00A8A3),
                        width: 2,
                      ),
                    ),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    AddFamilyMembersScreenWidget()));
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 0, 12, 0),
                            child: Text(
                              'Add Member',
                              style: FlutterFlowTheme.of(context)
                                  .bodyText1
                                  .override(
                                    fontFamily: 'Open Sans',
                                    color: Color(0xFF00A8A3),
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ),
                          Icon(
                            Icons.add_circle_outline_sharp,
                            color: Color(0xFF00A8A3),
                            size: 32,
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  /**
   * 
   */

  Row _buildFamilyMember(BuildContext context, int index) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Image.asset(
          'assets/images/4781820_avatar_male_man_people_person_icon_active.png',
          width: 30,
          height: 30,
          fit: BoxFit.cover,
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(8, 0, 0, 0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // if (index != 0)
                Text(
                  _familyMemberList[index]['type'],
                  style: FlutterFlowTheme.of(context).bodyText1.override(
                        fontFamily: 'Poppins',
                        color: Color(0xFF6D6D6D),
                        fontSize: 11,
                      ),
                ),
                Text(
                  _familyMemberList[index]['user']['name'],
                  style: FlutterFlowTheme.of(context).bodyText1.override(
                        fontFamily: 'Poppins',
                        color: Color(0xFF6D6D6D),
                        fontSize: 16,
                      ),
                ),
              ],
            ),
          ),
        ),
        Icon(
          Icons.arrow_forward_ios,
          color: Color(0xFF6D6D6D),
          size: 32,
        ),
      ],
    );
  }
}
