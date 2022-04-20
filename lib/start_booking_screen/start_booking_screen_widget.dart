import 'dart:convert';

import 'package:dhanva_mobile_app/components/notification_icon_button.dart';
import 'package:dhanva_mobile_app/global/models/doctor.dart';
import 'package:dhanva_mobile_app/global/models/patient.dart';
import 'package:dhanva_mobile_app/global/providers/doctor_record_provider.dart';
import 'package:dhanva_mobile_app/global/services/shared_preference_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../appointment_booked_screen/appointment_booked_screen_widget.dart';
import '../components/next_icon_button_widget.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

ChangeNotifierProvider<DoctorRecordProvider> _doctorsProvider =
    ChangeNotifierProvider((ref) => DoctorRecordProvider());

class StartBookingScreenWidget extends StatefulWidget {
  final String serviceName;
  final List<String> departments;
  final double price;

  const StartBookingScreenWidget(
      {Key key,
      @required this.serviceName,
      @required this.departments,
      @required this.price})
      : super(key: key);

  @override
  _StartBookingScreenWidgetState createState() =>
      _StartBookingScreenWidgetState();
}

class _StartBookingScreenWidgetState extends State<StartBookingScreenWidget> {
  TextEditingController textController1;
  TextEditingController textController2;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  Patient p = Patient.fromJson(
      jsonDecode(SharedPreferenceService.loadString(key: PatientKey)));
  int _selectedDoctorIndex = 0;

  @override
  void initState() {
    super.initState();
    textController1 = TextEditingController(text: p.name);
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
                                    'https://www.pngkey.com/png/detail/1010-10107790_kathi-online-avatar-maker.png',
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
                      widget.serviceName,
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
                                    fontSize: 16,
                                  ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
                          child: TextFormField(
                            controller: textController2,
                            obscureText: false,
                            decoration: InputDecoration(
                              hintText: 'Health problems or Symptomps',
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
                            maxLines: 4,
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
                            child: DoctorCardListView(),
                          ),
                        ),
                        // Spacer(),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 4, 0, 32),
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.7,
                            height: 55,
                            decoration: BoxDecoration(
                              color: Color(0xFF00A8A3),
                              borderRadius: BorderRadius.circular(18),
                            ),
                            child: InkWell(
                              onTap: () async {
                                await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        AppointmentBookedScreenWidget(
                                      price: widget.price,
                                      patient: p,
                                      // doctor: ,
                                    ),
                                  ),
                                );
                              },
                              child: NextIconButtonWidget(
                                  //
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
}

class DoctorCardListView extends ConsumerStatefulWidget {
  const DoctorCardListView({Key key}) : super(key: key);

  @override
  ConsumerState<DoctorCardListView> createState() => _DoctorCardListViewState();
}

class _DoctorCardListViewState extends ConsumerState<DoctorCardListView> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    ref.read(_doctorsProvider).fetchAllDoctors(init: true);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      DoctorRecordProvider _docRecords = ref.watch(_doctorsProvider);
      if (_docRecords.isLoading) {
        return Center(
          child: CircularProgressIndicator(),
        );
      } else {
        return ListView.builder(
            shrinkWrap: true,
            physics: BouncingScrollPhysics(),
            itemCount: _docRecords.doctors.length,
            itemBuilder: (_, int index) => GestureDetector(
                  onTap: () => setState(() => _selectedIndex = index),
                  child: DoctorCard(
                    isSelected: _selectedIndex == index,
                    doctor: _docRecords.doctors[index],
                  ),
                ));
      }
    });
  }
}

class DoctorCard extends StatelessWidget {
  final bool isSelected;
  final Doctor doctor;

  const DoctorCard({Key key, @required this.doctor, @required this.isSelected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 4),
      width: double.maxFinite,
      decoration: BoxDecoration(
        color: Color(0xFFEEEEEE),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isSelected ? Color(0xFF00A8A3) : Colors.white,
        ),
      ),
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(
                doctor.profilePic.isEmpty
                    ? 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR0kigo369AKCLUVSYPBs4K54t0WQbsfL9Lmw&usqp=CAU'
                    : doctor.profilePic,
                width: 80,
                height: 100,
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
                      child: Text(
                        doctor.name,
                        style: FlutterFlowTheme.of(context).bodyText1.override(
                              fontFamily: 'Open Sans',
                              color: Color(0xFF606E87),
                              fontSize: 18,
                            ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 6, 0, 0),
                      child: Text(
                        doctor.designation,
                        style: FlutterFlowTheme.of(context).bodyText1.override(
                              fontFamily: 'Open Sans',
                              color: Color(0xFF606E87),
                              fontSize: 16,
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
    );
  }
}
