import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

class NavigationScreenWidget extends StatefulWidget {
  const NavigationScreenWidget({Key key}) : super(key: key);

  @override
  _NavigationScreenWidgetState createState() => _NavigationScreenWidgetState();
}

class _NavigationScreenWidgetState extends State<NavigationScreenWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Color(0xFFF5F5F5),
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Align(
            alignment: AlignmentDirectional(0, 0),
            child: DefaultTabController(
              length: 3,
              initialIndex: 0,
              child: Column(
                children: [
                  TabBar(
                    labelColor: FlutterFlowTheme.of(context).primaryColor,
                    labelStyle: FlutterFlowTheme.of(context).bodyText1,
                    indicatorColor: FlutterFlowTheme.of(context).secondaryColor,
                    tabs: [
                      Tab(
                        text: 'Example 1',
                      ),
                      Tab(
                        text: 'Example 2',
                      ),
                      Tab(
                        text: 'Example 3',
                      ),
                    ],
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        Text(
                          'Tab View 1',
                          style:
                              FlutterFlowTheme.of(context).bodyText1.override(
                                    fontFamily: 'Poppins',
                                    fontSize: 32,
                                  ),
                        ),
                        Text(
                          'Tab View 2',
                          style:
                              FlutterFlowTheme.of(context).bodyText1.override(
                                    fontFamily: 'Poppins',
                                    fontSize: 32,
                                  ),
                        ),
                        Text(
                          'Tab View 3',
                          style:
                              FlutterFlowTheme.of(context).bodyText1.override(
                                    fontFamily: 'Poppins',
                                    fontSize: 32,
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
      ),
    );
  }
}
