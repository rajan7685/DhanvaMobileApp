import 'package:dhanva_mobile_app/components/notification_icon_button.dart';
import 'package:dhanva_mobile_app/global/services/api_services/api_service_base.dart';
import 'package:dhanva_mobile_app/global/services/shared_preference_service.dart';
import 'package:dhanva_mobile_app/home_screen/models/quick_service_ui_model.dart';
import 'package:dhanva_mobile_app/start_booking_screen2/start_booking_screen2_widget.dart';
import 'package:dio/dio.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../doctors_by_hospital_screen/doctors_by_hospital_screen_widget.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class HospitalScreenWidget extends StatefulWidget {
  const HospitalScreenWidget({Key key}) : super(key: key);

  @override
  _HospitalScreenWidgetState createState() => _HospitalScreenWidgetState();
}

class _HospitalScreenWidgetState extends State<HospitalScreenWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  bool _isDataLoading = true;
  List<dynamic> _servicesList;
  String _hospitalId;

  Future<void> _loadServicesData() async {
    Response res = await ApiService.dio.get(
        'http://api2.dhanva.icu/services/get_online',
        options: Options(headers: {
          'Authorization': SharedPreferenceService.loadString(key: AuthTokenKey)
        }));
    _servicesList = res.data['services'];
    _hospitalId = res.data['hospitalId'];
    setState(() {
      _isDataLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadServicesData();
    //
  }

  Widget _buildServiceCard(BuildContext context, Map<String, dynamic> model) {
    return Container(
      width: 100,
      decoration: BoxDecoration(
        color: Color(0xFFEEEEEE),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
            child: InkWell(
              onTap: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => StartBookingScreen2Widget(
                      isOnline: false,
                      hospitalId: _hospitalId,
                      pageTitle: 'Start Online Booking',
                      service: QuickServiceUiModel.fromJson(model),
                    ),
                  ),
                );
              },
              child: Container(
                width: 85,
                height: 85,
                decoration: BoxDecoration(
                  color: Color(0xFFEEEEEE),
                  shape: BoxShape.rectangle,
                ),
                child: model['icon'] == null
                    ? Image.network(
                        'https://img.icons8.com/external-kiranshastry-gradient-kiranshastry/2x/external-health-medical-kiranshastry-gradient-kiranshastry.png',
                        fit: BoxFit.contain,
                      )
                    : SvgPicture.network(
                        model['icon'],
                        fit: BoxFit.contain,
                      ),
              ),
            ),
          ),
          SizedBox(height: 2),
          Text(
            model['name'],
            maxLines: 2,
            overflow: TextOverflow.fade,
            style: FlutterFlowTheme.of(context).bodyText1.override(
                  fontFamily: 'Open Sans',
                  color: Color(0xFF282828),
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
          ),
        ],
      ),
    );
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
                  // mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Spacer(),
                    Container(
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
                    SizedBox(
                      width: 12,
                    ),
                    NotificationIconButton()
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(12, 72, 0, 0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Text(
                    //   widget.hospitalDetails['hospital_name'],
                    //   textAlign: TextAlign.start,
                    //   style: FlutterFlowTheme.of(context).bodyText1.override(
                    //         fontFamily: 'Open Sans',
                    //         color: Color(0xFFF3F4F4),
                    //         fontSize: 24,
                    //         fontWeight: FontWeight.bold,
                    //       ),
                    // ),
                    Text(
                      'Find your Specialist',
                      textAlign: TextAlign.start,
                      style: FlutterFlowTheme.of(context).bodyText1.override(
                            fontFamily: 'Open Sans',
                            color: Color(0xFFF3F4F4),
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
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
                    color: Color(0xFFEEEEEE),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(0),
                      bottomRight: Radius.circular(0),
                      topLeft: Radius.circular(36),
                      topRight: Radius.circular(36),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(12),
                    child: _isDataLoading
                        ? Center(child: CircularProgressIndicator())
                        : GridView.builder(
                            physics: BouncingScrollPhysics(),
                            itemCount: _servicesList.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    mainAxisSpacing: 18,
                                    crossAxisCount: 3,
                                    crossAxisSpacing: 22,
                                    mainAxisExtent: 120),
                            itemBuilder: (_, int index) => _buildServiceCard(
                                context, _servicesList[index])),
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
