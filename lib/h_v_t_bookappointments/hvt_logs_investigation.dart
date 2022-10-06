import 'dart:io';

import 'package:dhanva_mobile_app/h_v_t_bookappointments/hvt_bookdoctor_screen.dart';
import 'package:dhanva_mobile_app/home_screen/home_screen_widget.dart';
import 'package:file_picker/file_picker.dart';

import '../components/hvt_bottomsheet_widget.dart';
// import '../flutter_flow/flutter_flow_icon_button.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dhanva_mobile_app/components/notification_icon_button.dart';

class hvtLogsInvestigationWidget extends StatefulWidget {
  const hvtLogsInvestigationWidget({Key key}) : super(key: key);

  @override
  _hvtLogsInvestigationWidgetState createState() =>
      _hvtLogsInvestigationWidgetState();
}

class _hvtLogsInvestigationWidgetState
    extends State<hvtLogsInvestigationWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  int tabIndex;
  List<dynamic> _chats = [
    {
      "message": "hi how are you",
      "date_time": DateTime.now().toString(),
      "all_read": true
    },
    {
      "message": "hi how are you",
      "date_time": DateTime.now().toString(),
      "all_read": false
    }
  ];

  @override
  void initState() {
    super.initState();

    // textController16 = TextEditingController(text: 'Type your message...');
    tabIndex = 0;
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget chatWidget(int index, {@required bool me}) {
    print(_chats[index]['profile']);
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(!me ? 10 : 0, 20, me ? 10 : 0, 0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: me ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0, 0, 5, 0),
            child: Container(
              width: 45,
              height: 45,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: Image.network(
                _chats[index]['profile'] == null ||
                        (_chats[index]['profile'] as String).isEmpty
                    ? "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRYL2_7f_QDJhq5m9FYGrz5W4QI5EUuDLSdGA&usqp=CAU"
                    : _chats[index]['profile'],
                fit: BoxFit.cover,
              ),
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                    child: InkWell(
                      onTap: () {
                        // if (_chats[index]['document'] != null)
                        //   _downloadFile(fileUrl: _chats[index]['document']);
                      },
                      child: Container(
                        constraints: BoxConstraints(
                          minWidth: MediaQuery.of(context).size.width * 0.2,
                          maxWidth: MediaQuery.of(context).size.width * 0.75,
                        ),
                        decoration: BoxDecoration(
                          color: Color(0xFF00A8A3),
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(0),
                            bottomRight: _chats[index]['document'] == null
                                ? Radius.circular(10)
                                : Radius.circular(0),
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(12, 7, 12, 7),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              // if (_chats[index]['document'] != null)
                              //   Icon(
                              //     Icons.file_download,
                              //     size: 13,
                              //     color: Colors.white,
                              //   ),
                              // if (_chats[index]['document'] != null)
                              //   SizedBox(
                              //     width: 6,
                              //   ),
                              Flexible(
                                child: Text(
                                  _chats[index]['message'],
                                  style: FlutterFlowTheme.of(context)
                                      .bodyText1
                                      .override(
                                        fontFamily: 'Poppins',
                                        color: Colors.white,
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
              SizedBox(
                height: 2,
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    DateFormat('hh:mm a').format(
                        DateTime.parse(_chats[index]['date_time']).toLocal()),
                    // _chats[index]['date_time'],
                    style: FlutterFlowTheme.of(context).bodyText1.override(
                          fontFamily: 'Poppins',
                          color: Color(0xFF00A8A3),
                          fontSize: 6,
                        ),
                  ),
                  //Spacer(),
                  SizedBox(width: 8),
                  if (me)
                    Icon(
                      FontAwesomeIcons.checkDouble,
                      color: _chats[index]['all_read']
                          ? Color(0xFF00A8A3)
                          : Colors.white,
                      size: 9,
                    ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Color(0xFF00A8A3),
      floatingActionButton: tabIndex == 1
          ? FloatingActionButton(
              onPressed: () async {
                await showModalBottomSheet(
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  context: context,
                  builder: (context) {
                    return Padding(
                      padding: MediaQuery.of(context).viewInsets,
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.7,
                        child: HvtBottomsheetWidget(),
                      ),
                    );
                  },
                ).then((value) => setState(() {}));
              },
              backgroundColor: Color(0xFF00A8A3),
              elevation: 8,
              child: Icon(
                Icons.add,
                color: Color(0xFFF3F4F4),
                size: 30,
              ),
            )
          : null,
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Stack(children: [
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.5,
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
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HomeScreenWidget(),
                          ));
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
                        //
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
                    'Start Your HVT',
                    textAlign: TextAlign.start,
                    style: FlutterFlowTheme.of(context).bodyText1.override(
                          fontFamily: 'Open Sans',
                          color: Color(0xFFF3F4F4),
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  Text(
                    'Logs and Investigation',
                    style: FlutterFlowTheme.of(context).bodyText1.override(
                          fontFamily: 'Open Sans',
                          color: Color(0xFFF3F4F4),
                          fontSize: 16,
                          fontWeight: FontWeight.w300,
                        ),
                  ),
                  // // Text(
                  // //   'Subscription Plan',
                  // //   style: FlutterFlowTheme.of(context).bodyText1.override(
                  // //         fontFamily: 'Open Sans',
                  // //         color: Color(0xFFF3F4F4),
                  // //         fontSize: 16,
                  // //         fontWeight: FontWeight.w300,
                  // //       ),
                  // ),
                ],
              ),
            ),
            // Row(
            //   mainAxisSize: MainAxisSize.max,
            //   children: [
            //     Padding(
            //       padding: EdgeInsetsDirectional.fromSTEB(4, 0, 0, 0),
            //       child: Text(
            //         'Subscription Plan',
            //         style: FlutterFlowTheme.of(context).bodyText1.override(
            //               fontFamily: 'Open Sans',
            //               color: Color(0xFFF3F4F4),
            //               fontWeight: FontWeight.w600,
            //             ),
            //       ),
            //     ),
            //     Expanded(
            //       child: Padding(
            //         padding: EdgeInsetsDirectional.fromSTEB(120, 0, 5, 0),
            //         child: TextFormField(
            //           controller: textController1,
            //           autofocus: true,
            //           obscureText: false,
            //           decoration: InputDecoration(
            //             hintStyle: FlutterFlowTheme.of(context).bodyText2,
            //             enabledBorder: UnderlineInputBorder(
            //               borderSide: BorderSide(
            //                 color: Color(0xFF00A8A3),
            //                 width: 1,
            //               ),
            //               borderRadius: BorderRadius.circular(100),
            //             ),
            //             focusedBorder: UnderlineInputBorder(
            //               borderSide: BorderSide(
            //                 color: Color(0xFF00A8A3),
            //                 width: 1,
            //               ),
            //               borderRadius: BorderRadius.circular(100),
            //             ),
            //             errorBorder: UnderlineInputBorder(
            //               borderSide: BorderSide(
            //                 color: Color(0x00000000),
            //                 width: 1,
            //               ),
            //               borderRadius: BorderRadius.circular(100),
            //             ),
            //             focusedErrorBorder: UnderlineInputBorder(
            //               borderSide: BorderSide(
            //                 color: Color(0x00000000),
            //                 width: 1,
            //               ),
            //               borderRadius: BorderRadius.circular(100),
            //             ),
            //             filled: true,
            //             fillColor: Color(0xFFF3F4F4),
            //             suffixIcon: Icon(
            //               Icons.local_play,
            //               color: Color(0xFF070000),
            //               size: 22,
            //             ),
            //           ),
            //           style: FlutterFlowTheme.of(context).bodyText1.override(
            //                 fontFamily: 'Open Sans',
            //                 color: Colors.black,
            //               ),
            //           textAlign: TextAlign.end,
            //         ),
            //       ),
            //     ),
            //   ],
            // ),
            Align(
             // alignment: AlignmentDirectional(0, 1),
               alignment: AlignmentDirectional(0, 2),
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
                  padding: EdgeInsetsDirectional.fromSTEB(0, 22, 0, 0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: DefaultTabController(
                          length: 2,
                          initialIndex: 0,
                          child: Column(
                            children: [
                              TabBar(
                                onTap: (int value) {
                                  setState(() {
                                    tabIndex = value;
                                  });
                                },
                                isScrollable: true,
                                labelColor: Color.fromARGB(255, 0, 168, 162),
                                labelStyle: FlutterFlowTheme.of(context)
                                    .bodyText1
                                    .override(
                                      fontFamily: 'Open Sans',
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                indicatorColor:
                                    Color.fromARGB(255, 0, 168, 162),
                                indicatorWeight: 2,
                                tabs: [
                                  Tab(
                                    text: 'Logs',
                                  ),
                                  Tab(
                                    text: 'Investigation',
                                  ),
                                ],
                              ),
                              Expanded(
                                child: TabBarView(
                                  children: [
                                    Column(
                                      children: [
                                        Expanded(
                                          child: ListView.builder(
                                            itemBuilder: ((context, index) =>
                                                chatWidget(index,
                                                    me: index % 2 == 0
                                                        ? true
                                                        : false)),
                                            itemCount: _chats.length,
                                            shrinkWrap: true,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    .95,
                                                child: TextFormField(
                                                  textAlignVertical:
                                                      TextAlignVertical.center,
                                                  maxLines: 1,
                                                  //controller: _chatController,
                                                  obscureText: false,
                                                  decoration: InputDecoration(
                                                    isCollapsed: true,
                                                    //  InkWell(
                                                    //     // onTap: _pickFile,
                                                    //     child: Transform.rotate(
                                                    //       angle: 45,
                                                    //       child: Icon(
                                                    //         Icons.attach_file,
                                                    //         size: 25,
                                                    //         color: Color(0xFF209A1F),
                                                    //       ),
                                                    //     ),
                                                    //   ),
                                                    suffix: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        InkWell(
                                                          onTap: () async {
                                                            FilePickerResult
                                                                result =
                                                                await FilePicker
                                                                    .platform
                                                                    .pickFiles();

                                                            if (result !=
                                                                null) {
                                                              File file = File(
                                                                  result
                                                                      .files
                                                                      .single
                                                                      .path);
                                                            } else {
                                                              // ScaffoldMessenger
                                                              //         .of(
                                                              //             context)
                                                              //     .showSnackBar(
                                                              //         SnackBar(
                                                              //             content:
                                                              //                 Text('Please select a file')));
                                                            }
                                                          },
                                                          child:
                                                              Transform.rotate(
                                                            angle: 45,
                                                            child: Icon(
                                                              Icons.attach_file,
                                                              size: 25,
                                                              color: Color(
                                                                  0xFF00A8A3),
                                                            ),
                                                          ),
                                                        ),
                                                        InkWell(
                                                          // onTap: _sendMessage,
                                                          child: Image.asset(
                                                            'assets/images/7830587_send_email_icon.png',
                                                            width: 20,
                                                            height: 20,
                                                            fit: BoxFit.cover,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    isDense: true,
                                                    // labelText: 'Last Name',
                                                    hintText:
                                                        'Type here to send...',
                                                    fillColor: Colors.white,
                                                    contentPadding:
                                                        const EdgeInsets
                                                                .symmetric(
                                                            vertical: 10,
                                                            horizontal: 8),
                                                    filled: true,

                                                    enabledBorder:
                                                        UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color:
                                                            Color(0x00000000),
                                                        width: 1,
                                                      ),
                                                      borderRadius:
                                                          const BorderRadius
                                                              .only(
                                                        topLeft:
                                                            Radius.circular(
                                                                4.0),
                                                        topRight:
                                                            Radius.circular(
                                                                4.0),
                                                      ),
                                                    ),
                                                    focusedBorder:
                                                        UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color:
                                                            Color(0x00000000),
                                                        width: 1,
                                                      ),
                                                      borderRadius:
                                                          const BorderRadius
                                                              .only(
                                                        topLeft:
                                                            Radius.circular(
                                                                4.0),
                                                        topRight:
                                                            Radius.circular(
                                                                4.0),
                                                      ),
                                                    ),
                                                  ),
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyText1
                                                      .override(
                                                        fontFamily: 'Poppins',
                                                        color:
                                                            Color(0xFF606E87),
                                                        fontSize: 16,
                                                      ),
                                                ),
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                    ListView.builder(
                                      itemBuilder: ((context, index) =>
                                          chatWidget(index, me: false)),
                                      itemCount: _chats.length,
                                      shrinkWrap: true,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }

  FlutterFlowIconButton(
      {Color borderColor,
      int borderRadius,
      int borderWidth,
      int buttonSize,
      Icon icon,
      Null Function() onPressed}) {}
}
