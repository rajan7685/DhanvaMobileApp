import 'package:dhanva_mobile_app/components/notification_icon_button.dart';
import 'package:dhanva_mobile_app/flutter_flow/flutter_flow_theme.dart';
import 'package:dhanva_mobile_app/home_screen/models/quick_service_ui_model.dart';
import 'package:dhanva_mobile_app/home_screen/providers/home_services_provider.dart';
import 'package:dhanva_mobile_app/start_booking_screen/start_booking_screen_widget.dart';
import 'package:dhanva_mobile_app/start_booking_screen2/start_booking_screen2_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

ChangeNotifierProvider<HomeServicesProvider> _servicesProvider =
    ChangeNotifierProvider((ref) => HomeServicesProvider());

class ServicesByHospitalScreen extends ConsumerStatefulWidget {
  final Map<String, dynamic> hospitalDetails;

  const ServicesByHospitalScreen({Key key, @required this.hospitalDetails})
      : super(key: key);

  @override
  ConsumerState<ServicesByHospitalScreen> createState() =>
      _ServicesByHospitalScreenState();
}

class _ServicesByHospitalScreenState
    extends ConsumerState<ServicesByHospitalScreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    ref.read(_servicesProvider).fetchServicesList(init: true);
    //
  }

  Widget _buildServiceCard(BuildContext context, QuickServiceUiModel model) {
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
                      pageTitle: 'Start Offline Booking',
                      service: model,
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
                child: SvgPicture.network(
                  model.iconLink,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
          SizedBox(height: 2),
          Text(
            model.name,
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
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.arrow_back_rounded,
                        color: Colors.white,
                        size: 34,
                      ),
                    ),
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
                    Text(
                      widget.hospitalDetails['hospital_name'],
                      textAlign: TextAlign.start,
                      style: FlutterFlowTheme.of(context).bodyText1.override(
                            fontFamily: 'Open Sans',
                            color: Color(0xFFF3F4F4),
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    Text(
                      'Find your Specialist',
                      textAlign: TextAlign.start,
                      style: FlutterFlowTheme.of(context).bodyText1.override(
                            fontFamily: 'Open Sans',
                            color: Color(0xFFF3F4F4),
                            fontSize: 22,
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
                  height: MediaQuery.of(context).size.height * 0.78,
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
                    child: Consumer(
                      builder: (context, ref, child) {
                        HomeServicesProvider _prov =
                            ref.watch(_servicesProvider);
                        if (_prov.isLoading) {
                          return Center(child: CircularProgressIndicator());
                        } else {
                          return GridView.builder(
                              physics: BouncingScrollPhysics(),
                              itemCount: _prov.quickServices.length,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      mainAxisSpacing: 18,
                                      crossAxisCount: 3,
                                      crossAxisSpacing: 22,
                                      mainAxisExtent: 120),
                              itemBuilder: (_, int index) => _buildServiceCard(
                                  context, _prov.quickServices[index]));
                        }
                      },
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
