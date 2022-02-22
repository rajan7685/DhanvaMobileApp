import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

class NewsViewScreenWidget extends StatefulWidget {
  const NewsViewScreenWidget({Key key}) : super(key: key);

  @override
  _NewsViewScreenWidgetState createState() => _NewsViewScreenWidgetState();
}

class _NewsViewScreenWidgetState extends State<NewsViewScreenWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: Color(0xFFEDF3F3),
        iconTheme: IconThemeData(color: Color(0xFF00A8A3)),
        automaticallyImplyLeading: true,
        actions: [],
        centerTitle: true,
        elevation: 0,
      ),
      backgroundColor: Color(0xFFF5F5F5),
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(12, 0, 12, 0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 28, 0, 0),
                    child: Image.network(
                      'https://picsum.photos/seed/813/600',
                      width: MediaQuery.of(context).size.width,
                      height: 160,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          '1hr ago',
                          style:
                              FlutterFlowTheme.of(context).bodyText1.override(
                                    fontFamily: 'Open Sans',
                                    color: Colors.black,
                                    fontSize: 12,
                                  ),
                        ),
                        Expanded(
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 0, 8, 0),
                                child: Icon(
                                  Icons.favorite_border,
                                  color: Color(0xFF101820),
                                  size: 20,
                                ),
                              ),
                              Icon(
                                Icons.share_rounded,
                                color: Colors.black,
                                size: 20,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Wrap(
                    spacing: 0,
                    runSpacing: 0,
                    alignment: WrapAlignment.start,
                    crossAxisAlignment: WrapCrossAlignment.start,
                    direction: Axis.horizontal,
                    runAlignment: WrapAlignment.start,
                    verticalDirection: VerticalDirection.down,
                    clipBehavior: Clip.none,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
                        child: Text(
                          '‘Science is flawed’: COVID-19, ivermectin, and beyond',
                          style: FlutterFlowTheme.of(context).title2.override(
                                fontFamily: 'Poppins',
                                color: Colors.black,
                                fontSize: 17,
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                      ),
                    ],
                  ),
                  Align(
                    alignment: AlignmentDirectional(-1, 0),
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                      child: Text(
                        'Author: Ravichandran',
                        style: FlutterFlowTheme.of(context).bodyText1.override(
                              fontFamily: 'Poppins',
                              color: Colors.black,
                              fontSize: 12,
                            ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
                    child: Text(
                      'There are no two ways about it: Science is flawed. We’re not talking about the philosophical leanings of science or the origins of white coats and linoleum-floored laboratories, but about the nuts and bolts of the process by which we determine whether things are true or false.\n\n\n In the decades before the pandemic, scientists spent endless hours wrestling with the painful fact that much of the knowledge base of science and medicine is reliant on research that is flawed, broken, or potentially never occurred at all. Science has a gap between its mechanics and outputs.\n\n\n The mechanics of science are fine. The machines always get bigger and more efficient. New tools are always developed. Techniques become more sophisticated over time, and more knowledge is acquired. The outputs of science are not. The culture of academia demands publication and warrants little retrospection about potential errors — this means that mistakes are rarely corrected, and even outright fraud is often left undetected in academic literature. \n\n\nEnter the pandemic And then along came a pandemic, and the gaps in science widened to an inescapable chasm. While biomedical research has had obvious and immediate success in COVID-19 mitigation, it has been accompanied by an enormous tidal wave of garbage, which instantly overwhelmed our garbage mitigation mechanisms. From fraud to wasteful research to papers so error-filled that \n\n\n\nit is amazing that they’ve been published, the pandemic has produced a tidal wave of woeful scientific output that has, nevertheless, had staggering consequences for people’s lives. Take ivermectin. It is an amazingly successful antiparasitic medication that has treated literally billions of people in the time since it was invented, and it has almost eliminated some parasitic diseases from the world. It has also been globally promoted as a cure for COVID-19 by a group of passionate fans. \n\nIt is likely that more ivermectin has been taken to prevent or treat COVID-19 than any other single medication, except perhaps dexamethasone.',
                      style: FlutterFlowTheme.of(context).bodyText1.override(
                            fontFamily: 'Open Sans',
                            color: Colors.black,
                          ),
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
