import '../app_guide_screen1/app_guide_screen1_widget.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import '../psychometrics_assesent_step1/psychometrics_assesent_step1_widget.dart';
import '../start_booking_screen/start_booking_screen_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomeScreenWidget extends StatefulWidget {
  const HomeScreenWidget({Key key}) : super(key: key);

  @override
  _HomeScreenWidgetState createState() => _HomeScreenWidgetState();
}

class _HomeScreenWidgetState extends State<HomeScreenWidget> {
  PageController pageViewController;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
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
                              Container(
                                width: 55,
                                height: 55,
                                decoration: BoxDecoration(
                                  color: Color(0xFF00827F),
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Icon(
                                  Icons.notifications_outlined,
                                  color: Colors.white,
                                  size: 24,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(16, 2, 0, 0),
                        child: Text(
                          'Hello User',
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
                  height: MediaQuery.of(context).size.height * 0.62,
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
                                                    PsychometricsAssesentStep1Widget(),
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
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          Container(
                            height: 145,
                            decoration: BoxDecoration(
                              color: Color(0xFFEEEEEE),
                            ),
                            child: ListView(
                              padding: EdgeInsets.zero,
                              scrollDirection: Axis.horizontal,
                              children: [
                                Container(
                                  width: 100,
                                  height: 100,
                                  decoration: BoxDecoration(
                                    color: Color(0xFFEEEEEE),
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0, 0, 12, 0),
                                        child: InkWell(
                                          onTap: () async {
                                            await Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    StartBookingScreenWidget(),
                                              ),
                                            );
                                          },
                                          child: Container(
                                            width: 100,
                                            height: 100,
                                            decoration: BoxDecoration(
                                              color: Color(0xFFEEEEEE),
                                              image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image: Image.asset(
                                                  'assets/images/Group_270.png',
                                                ).image,
                                              ),
                                              shape: BoxShape.rectangle,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Text(
                                        'Dental Specialist',
                                        style: FlutterFlowTheme.of(context)
                                            .bodyText1
                                            .override(
                                              fontFamily: 'Open Sans',
                                              color: Color(0xFF282828),
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: 100,
                                  height: 100,
                                  decoration: BoxDecoration(
                                    color: Color(0xFFEEEEEE),
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0, 0, 12, 0),
                                        child: Container(
                                          width: 100,
                                          height: 100,
                                          decoration: BoxDecoration(
                                            color: Color(0xFFEEEEEE),
                                            image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: Image.asset(
                                                'assets/images/Group_274.png',
                                              ).image,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Text(
                                        'Heart Specialist',
                                        style: FlutterFlowTheme.of(context)
                                            .bodyText1
                                            .override(
                                              fontFamily: 'Open Sans',
                                              color: Color(0xFF282828),
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: 100,
                                  height: 100,
                                  decoration: BoxDecoration(
                                    color: Color(0xFFEEEEEE),
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0, 0, 12, 0),
                                        child: Container(
                                          width: 100,
                                          height: 100,
                                          decoration: BoxDecoration(
                                            color: Color(0xFFEEEEEE),
                                            image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: Image.asset(
                                                'assets/images/Group_277.png',
                                              ).image,
                                            ),
                                            shape: BoxShape.rectangle,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        'Bone Specialist',
                                        style: FlutterFlowTheme.of(context)
                                            .bodyText1
                                            .override(
                                              fontFamily: 'Open Sans',
                                              color: Color(0xFF282828),
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: 100,
                                  height: 100,
                                  decoration: BoxDecoration(
                                    color: Color(0xFFEEEEEE),
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Container(
                                        width: 100,
                                        height: 100,
                                        decoration: BoxDecoration(
                                          color: Color(0xFFEEEEEE),
                                          image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: Image.asset(
                                              'assets/images/Group_281.png',
                                            ).image,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        'Eye Specialist',
                                        style: FlutterFlowTheme.of(context)
                                            .bodyText1
                                            .override(
                                              fontFamily: 'Open Sans',
                                              color: Color(0xFF282828),
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
                            child: FFButtonWidget(
                              onPressed: () {
                                print('Button pressed ...');
                              },
                              text: 'More',
                              options: FFButtonOptions(
                                width: double.infinity,
                                height: 50,
                                color: Color(0x003474E0),
                                textStyle: FlutterFlowTheme.of(context)
                                    .subtitle2
                                    .override(
                                      fontFamily: 'Poppins',
                                      color: Color(0xFF00A8A3),
                                    ),
                                borderSide: BorderSide(
                                  color: Color(0xFF00A8A3),
                                  width: 2,
                                ),
                                borderRadius: 12,
                              ),
                            ),
                          ),
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
