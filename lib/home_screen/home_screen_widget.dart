import 'dart:convert';

import 'package:dhanva_mobile_app/components/notification_icon_button.dart';
import 'package:dhanva_mobile_app/global/models/patient.dart';
import 'package:dhanva_mobile_app/global/services/api_services/api_service_base.dart';
import 'package:dhanva_mobile_app/global/services/shared_preference_service.dart';
import 'package:dhanva_mobile_app/home_screen/models/quick_service_ui_model.dart';
import 'package:dhanva_mobile_app/home_screen/providers/home_services_provider.dart';
import 'package:dhanva_mobile_app/psychometrics_assesment_screen/models/psychometrics_assesment_question.dart';
import 'package:dhanva_mobile_app/psychometrics_assesment_screen/psychometrics_assesment_screen.dart';
import 'package:dhanva_mobile_app/start_booking_screen/start_booking_screen_widget.dart';
import 'package:dhanva_mobile_app/start_booking_screen2/start_booking_screen2_widget.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../app_guide_screen1/app_guide_screen1_widget.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:flutter_svg/flutter_svg.dart';

// ChangeNotifierProvider<HomeServicesProvider> _servicesProvider =
// ChangeNotifierProvider((ref) => HomeServicesProvider());

// mock data
final List<PsychometricsAssesmentQuestion> _questions = [
  PsychometricsAssesmentQuestion(
      question: 'I am task oriented to achieve certain goals.',
      options: ['YEP! THAT IS ME', 'I HAVE NO IDEA', 'NOPE THAT CAN\'T BE ME']),
  PsychometricsAssesmentQuestion(
      question: 'I get bored easily when discussing abstract things.',
      options: ['YEP! THAT IS ME', 'I HAVE NO IDEA', 'NOPE THAT CAN\'T BE ME']),
  PsychometricsAssesmentQuestion(
      question: 'I like to try things out myself.',
      options: ['YEP! THAT IS ME', 'I HAVE NO IDEA', 'NOPE THAT CAN\'T BE ME']),
  PsychometricsAssesmentQuestion(
      question: 'I like to know where I\'m going before leaving my house.',
      options: ['YEP! THAT IS ME', 'I HAVE NO IDEA', 'NOPE THAT CAN\'T BE ME']),
];

class HomeScreenWidget extends ConsumerStatefulWidget {
  const HomeScreenWidget({Key key}) : super(key: key);

  @override
  ConsumerState<HomeScreenWidget> createState() => _HomeScreenWidgetState();
}

class _HomeScreenWidgetState extends ConsumerState<HomeScreenWidget> {
  PageController pageViewController;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  bool isDataLoaded = false;
  List<QuickServiceUiModel> homeServices;

  @override
  void initState() {
    super.initState();
    SharedPreferenceService.init();
    loadServicesData();
    // ref.read(_servicesProvider).fetchServicesList(init: true);
  }

  void loadServicesData() async {
    setState(() {
      isDataLoaded = false;
    });
    String _servicesApi = 'http://api2.dhanva.icu/services/get_online';
    await SharedPreferenceService.init();
    Response res = await ApiService.dio.get(_servicesApi,
        options: Options(headers: {
          'Authorization': SharedPreferenceService.loadString(key: AuthTokenKey)
        }));

    SharedPreferenceService.saveString(
        key: OnlineHospitalKey, value: res.data['hospitalId']);
    homeServices = List.generate((res.data['services'] as List).length,
        (index) => QuickServiceUiModel.fromJson(res.data['services'][index]));
    // when loaded
    setState(() {
      isDataLoaded = true;
    });
  }

  // void loadHospitalKey() async {
  //   // data processing
  //   await SharedPreferenceService.init();
  //   try {
  //     Response res = await ApiService.dio.get(
  //         'http://api2.dhanva.icu/hospital/get_all',
  //         options: Options(headers: {
  //           'Authorization':
  //               SharedPreferenceService.loadString(key: AuthTokenKey)
  //         }));
  //     dynamic data = (res.data as List)
  //         .singleWhere((json) => json['hospital_name'] == 'Online');

  //     // OnlineHospitalKey
  //     SharedPreferenceService.saveString(
  //         key: OnlineHospitalKey, value: data['_id']);
  //     loadServicesData();
  //   } catch (w) {
  //     print('error ${w.toString()}');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    Patient patient = Patient.fromJson(
        jsonDecode(SharedPreferenceService.loadString(key: PatientKey)));
    String _patientFirstName = patient.name.split(' ')[0];
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Color(0xFFF3F4F4),
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Stack(
            alignment: AlignmentDirectional(0, 0),
            children: [
              Align(
                alignment: AlignmentDirectional(0, -1),
                child: Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.45,
                  decoration: BoxDecoration(
                    color: Color(0xFFEEEEEE),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: Image.asset(
                        'assets/images/page_bgbg.png',
                      ).image,
                    ),
                  ),
                  alignment: AlignmentDirectional(0, 0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: AlignmentDirectional(0, -1),
                        child: Padding(
                          padding:
                              EdgeInsetsDirectional.fromSTEB(12, 10, 12, 0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              NotificationIconButton(),
                              // Container(
                              //   width: 55,
                              //   height: 55,
                              //   decoration: BoxDecoration(
                              //     color: Color(0xFF00827F),
                              //     borderRadius: BorderRadius.circular(16),
                              //   ),
                              //   child: Icon(
                              //     Icons.notifications_outlined,
                              //     color: Colors.white,
                              //     size: 24,
                              //   ),
                              // ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(16, 2, 0, 0),
                        child: Text(
                          "Hello $_patientFirstName",
                          style: FlutterFlowTheme.of(context).title2.override(
                                fontFamily: 'Open Sans',
                                color: Color(0xFFF3F4F4),
                                fontSize: 32,
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(16, 4, 0, 0),
                        child: Text(
                          'How are you today?',
                          style:
                              FlutterFlowTheme.of(context).bodyText1.override(
                                    fontFamily: 'Open Sans',
                                    color: Color(0xFFF3F4F4),
                                    fontSize: 17,
                                  ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(16, 3, 0, 0),
                        child: Text(
                          'Let\'s Get a FREE TeleConsultation',
                          style:
                              FlutterFlowTheme.of(context).bodyText1.override(
                                    fontFamily: 'Open Sans',
                                    color: Color(0xFF00FFF7),
                                    fontSize: 18,
                                  ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: AlignmentDirectional(0, 1),
                child: Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.66,
                  decoration: BoxDecoration(
                    color: Color(0xFFEEEEEE),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(0),
                      bottomRight: Radius.circular(0),
                      topLeft: Radius.circular(45),
                      topRight: Radius.circular(45),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(16, 18, 16, 0),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: double.infinity,
                            height: 140,
                            decoration: BoxDecoration(
                              color: Color(0xFFEEEEEE),
                            ),
                            child: Container(
                              width: double.infinity,
                              height: 500,
                              child: Stack(
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 0, 0, 50),
                                    child: PageView(
                                      controller: pageViewController ??=
                                          PageController(initialPage: 0),
                                      scrollDirection: Axis.horizontal,
                                      children: [
                                        InkWell(
                                          onTap: () async {
                                            await Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    PsychometricsAssesmentScreen(
                                                  questions: _questions,
                                                ),
                                              ),
                                            );
                                          },
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(16),
                                            child: Image.asset(
                                              'assets/images/Group_555.png',
                                              width: double.infinity,
                                              height: double.infinity,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        Image.network(
                                          'https://picsum.photos/seed/355/600',
                                          width: 100,
                                          height: 100,
                                          fit: BoxFit.cover,
                                        ),
                                        Image.network(
                                          'https://picsum.photos/seed/516/600',
                                          width: 100,
                                          height: 100,
                                          fit: BoxFit.cover,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Align(
                                    alignment: AlignmentDirectional(0, 1),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 0, 0, 10),
                                      child: SmoothPageIndicator(
                                        controller: pageViewController ??=
                                            PageController(initialPage: 0),
                                        count: 3,
                                        axisDirection: Axis.horizontal,
                                        onDotClicked: (i) {
                                          pageViewController.animateToPage(
                                            i,
                                            duration:
                                                Duration(milliseconds: 500),
                                            curve: Curves.ease,
                                          );
                                        },
                                        effect: SlideEffect(
                                          spacing: 2,
                                          radius: 16,
                                          dotWidth: 12,
                                          dotHeight: 12,
                                          dotColor: Color(0xFF9E9E9E),
                                          activeDotColor: Color(0xFF3F51B5),
                                          paintStyle: PaintingStyle.stroke,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Text(
                            'Find your Specialist Quickly',
                            style: FlutterFlowTheme.of(context).title1.override(
                                  fontFamily: 'Poppins',
                                  color: Color(0xFF282828),
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          SizedBox(
                            height: 18,
                          ),
                          Container(
                              height: 145,
                              decoration: BoxDecoration(
                                color: Color(0xFFEEEEEE),
                              ),
                              child: isDataLoaded == false
                                  ? Center(
                                      child: CircularProgressIndicator(),
                                    )
                                  : QuickServicesListView(
                                      services: homeServices)
                              // child: Consumer(
                              //   builder: (context, ref, child) {
                              //     HomeServicesProvider _prov =
                              //         ref.watch(_servicesProvider);
                              //     if (_prov.isLoading) {
                              //       return Center(
                              //           child: CircularProgressIndicator());
                              //     } else {
                              //       return QuickServicesListView(
                              //         services: _prov.quickServices,
                              //       );
                              //     }
                              //   },
                              // ),
                              ),
                          // Padding(
                          //   padding: EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
                          //   child: FFButtonWidget(
                          //     onPressed: () {
                          //       print('Button pressed ...');
                          //     },
                          //     text: 'More',
                          //     options: FFButtonOptions(
                          //       width: double.infinity,
                          //       height: 50,
                          //       color: Colors.transparent,
                          //       textStyle: FlutterFlowTheme.of(context)
                          //           .subtitle2
                          //           .override(
                          //             fontFamily: 'Poppins',
                          //             color: Color(0xFF00A8A3),
                          //           ),
                          //       borderSide: BorderSide(
                          //         color: Color(0xFF00A8A3),
                          //         width: 2,
                          //       ),
                          //       borderRadius: 12,
                          //     ),
                          //   ),
                          // ),
                          InkWell(
                            onTap: () async {
                              await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => AppGuideScreen1Widget(),
                                ),
                              );
                            },
                            child: Container(
                              width: double.infinity,
                              height: 120,
                              decoration: BoxDecoration(
                                color: Color(0xFFEEEEEE),
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: Image.asset(
                                    'assets/images/Group_558.png',
                                  ).image,
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

class QuickServicesListView extends StatelessWidget {
  final List<QuickServiceUiModel> services;

  const QuickServicesListView({
    @required this.services,
    Key key,
  }) : super(key: key);

  Widget _buildServiceCard(BuildContext context, int index) {
    return Container(
      width: 100,
      decoration: BoxDecoration(
        color: Color(0xFFEEEEEE),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0, 0, 12, 0),
            child: InkWell(
              onTap: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => StartBookingScreen2Widget(
                      service: services[index],
                      hospitalId: SharedPreferenceService.loadString(
                          key: OnlineHospitalKey),
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
                  services[index].iconLink,
                  fit: BoxFit.fitHeight,
                ),
              ),
            ),
          ),
          Text(
            services[index].name,
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
    return ListView.builder(
      padding: EdgeInsets.zero,
      scrollDirection: Axis.horizontal,
      itemCount: services.length,
      itemBuilder: (context, index) => _buildServiceCard(context, index),
    );
  }
}
