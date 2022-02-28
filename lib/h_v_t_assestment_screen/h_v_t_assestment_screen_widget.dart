import '../flutter_flow/flutter_flow_radio_button.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

class HVTAssestmentScreenWidget extends StatefulWidget {
  const HVTAssestmentScreenWidget({Key key}) : super(key: key);

  @override
  _HVTAssestmentScreenWidgetState createState() =>
      _HVTAssestmentScreenWidgetState();
}

class _HVTAssestmentScreenWidgetState extends State<HVTAssestmentScreenWidget> {
  String radioButtonValue1;
  TextEditingController textController;
  String radioButtonValue2;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    textController = TextEditingController(text: 'Someone Sick');
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
                          Container(
                            width: 45,
                            height: 45,
                            decoration: BoxDecoration(
                              color: Color(0xFF00827F),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Align(
                              alignment: AlignmentDirectional(0, 0),
                              child: Icon(
                                Icons.notifications_outlined,
                                color: Color(0xFFF3F4F4),
                                size: 24,
                              ),
                            ),
                          ),
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
                      'HVT Appointment',
                      style: FlutterFlowTheme.of(context).bodyText1.override(
                            fontFamily: 'Open Sans',
                            color: Color(0xFFF3F4F4),
                            fontSize: 16,
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
                  height: MediaQuery.of(context).size.height * 0.72,
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
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
                            child: TextFormField(
                              controller: textController,
                              obscureText: false,
                              decoration: InputDecoration(
                                labelText: 'Patient Name',
                                labelStyle: FlutterFlowTheme.of(context)
                                    .bodyText1
                                    .override(
                                      fontFamily: 'Open Sans',
                                      color: Color(0xFF9A9A9A),
                                      fontSize: 16,
                                    ),
                                hintText: '[Some hint text...]',
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
                              style: FlutterFlowTheme.of(context)
                                  .bodyText1
                                  .override(
                                    fontFamily: 'Open Sans',
                                    color: Color(0xFF606E87),
                                    fontSize: 18,
                                  ),
                            ),
                          ),
                          Text(
                            'Pre Assesment Questionarie',
                            style:
                                FlutterFlowTheme.of(context).bodyText1.override(
                                      fontFamily: 'Open Sans',
                                      color: Color(0xFF111111),
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                    ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
                            child: Text(
                              'Please choose the shape',
                              style: FlutterFlowTheme.of(context)
                                  .bodyText1
                                  .override(
                                    fontFamily: 'Open Sans',
                                    color: Color(0xFF171717),
                                    fontWeight: FontWeight.w500,
                                  ),
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Image.network(
                                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ4WqcVTv96rNdgWKQLBpi8yV1ZeTRLBZZ1lQ&usqp=CAU',
                                  width: 100,
                                  height: 100,
                                  fit: BoxFit.cover,
                                ),
                                Image.network(
                                  'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAOEAAADhCAMAAAAJbSJIAAAAM1BMVEX///8AAAB6enpTU1Pt7e3q6urV1dXX19dPT0+VlZV3d3fw8PDFxcXCwsKwsLBLS0upqalt39wOAAABRUlEQVR4nO3UyXGDAAAEQVnCAiFf+UfrBChKD10D3RHsfPZwAAD25DidNmO6LBVOHxsyLxWeXr3qno77LRyHvuvXWuFw6y29s3Gt8PPZax7hrDBPYZ/CPoV9CvsU9insU9insE9hn8I+hX0K+xT2KexT2KewT2Gfwj6FfQr7FPYp7FPYp7BPYZ/CPoV9CvsU9insU9insE9hn8I+hX0K+xT2KexT2KewT2Gfwj6FfQr7FPYp7FPYp7BPYZ/CPoV9CvsU9insU9insE9hn8I+hX0K+xT2KexT2KewT2Gfwj6FfQr7FPYp7FPYp7BPYZ/CPoV9CvsU9insU9insE9hn8I+hX0K+xT2KexT2KewT2Gfwj6FfQr7FPYp7FPYt/PC4dlrHmFcK/wez3njz1rhZuy08PfVq+5pXiq8zBvyd+stAQA0/APCdChfMYDn+QAAAABJRU5ErkJggg==',
                                  width: 100,
                                  height: 100,
                                  fit: BoxFit.cover,
                                ),
                                Image.network(
                                  'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAOsAAADWCAMAAAAHMIWUAAAAeFBMVEX39/cAAAD////8/PxERESurq719fWlpaWKiory8vLHx8fT09Pj4+Pq6upLS0vf3996enq9vb0+Pj61tbVtbW03NzddXV2YmJhSUlJycnKAgIAuLi4ZGRkeHh7Dw8PY2NiSkpIvLy8QEBBlZWUdHR0mJiZISEioqKh5HB6lAAAGCklEQVR4nO2d2VoUMRBG6QRQFFwYcQVlUXz/N9R0GLb5e8lSqYWcC5xvFCZl0p3kdFXY2+t0Op1Op9PpyMVzN6Ad7jN3C5rhN8MXx92IVpwPwwl3G9rgLodh+PQyOvZkCLx9CfcndzPGevoCOta/HSIb+x3rzu5iHQ65m0KNPwhhfg5fXpsfxSHKC/cu/HHM3RZa3PcQ5E/3a+xd0x3rj0OMX92e+xBevLF8e3Ljhfr+f4hH4cWV4Vj9zxDh9zB03avw8pXdUez/hACP4usfD68NEvvyb+xL/+a+jy0yXqNn2+jitfvL5iX7/N67vScbxI9z6s1DbO51eOOjxY51+yG0J3v08Ma1wVj9JkR2+XjIxrWxRR1zHTrx6VvudKerLTCKl+d71riXNadjRvGy/zwq98mgjoniZTeoE3s6Jg7Wb7sxuS/hLw4sdWwUL/AmdGFMx8xMLv6jMR0zLoR/44FqTMfciRccq7elY+YX+aZ0jPu6FS+YcYT/MBHrI/GCMaRjoniZm1XcIzWjmjvxMjdEo475oL9jo3iZvxofVKpq1t1lTeiYHfGCMaFj3O3K3fi4sqJvDyFxtXu5PDgN6Bg/7IoXTNQxiucdKF4w6nUMFi8Y5Tomipe1TzFU65hJ8YJRrWNmxAvmd/j3dO0hJHkaUaxjxoXwn5QhGTe6CnVMXPZNiBeMf69Tx8R2Jy7nleqYJfGCieNeWcdmZkOo1DE+U6sozI55kvGSgkIdEzVoTovV6Rj3Lf9+OuqYd2o6dqV4wSjTMWWPow7DN18oiRVkvCR9uyodEzJehvyOSd4f8ZEgXjCKdEyKeMGo0TFp4gVT/t/VhETxgok6RnyxUryxlC5o/bUCHVNpwlChYw6TxQtGQXbMbMZLCvJ1TJZ4wYjXMXniBZO/LWzCYsZLCsJ1TK54mfhpV4J1TLZ4wYguVnpaalSO4GKlEvGCEatjisQLRqyOiRkvdVc64yrsXFysheJl4ocK1THnw8qMlxREFisVixeMSB1DZRIE6hi6JonLjqkiXjDidIwnNLp+zI4RU6xEOjUI0zG0T2BE6Zhq4gUjqVjJUyewC9Ix9E/CxZwdU1W8YMTomLrihe8zVlBZvGCE6Jg1pUbliMiOaXWPFFCsRCBeMAJ0DIV4mYBbx6wuNarwUew6BpzxQgWzjiESLxhmHdM2hYNVx0yd8ULFSeVnKAkQihcMY7ESQyodV7ESwyTApmOOSMULhknHZJQalcOjY8jFC4ZFx3BtshjOjmkgXjAMOmb5jBcqmp8ds+KMFyqaFyvVznhJofGdgldON50BmokXTFMdE1cvjEkM44qtySc1FC8TDWi3EvcNxQummY5pKl4wzXbOEmpnGumYGqVG5TTJjmkuXjBNsmPcFfN8c4c/J9cx/PZ92xB6HVOr1Kgcch3DIl4w1MVKFUuNyiHegNQsNSqHtFhJSNbCFlIdIyQb5R7Cs2OaZLykQDjO5BXzkemY+qVG5RAVKzGLFwyRjhGVxXsPSeYyu3jB0KzP6fcVWRA88BYgXjAE2TGjB7iVNoID1XWMwOqneyr7LyHiBVNZx9Q544WKqmfHiBEvmLo6Rox4wVRc5hCXGpVTLztGlHjBVNMxIsoKFqhUrMSW8ZJCJR0jTbxgqugYceIFU0XHcGa8pFDh7BhB5ZgLFOsYSWW2CxTrmIalRsUUnh0jVLxgSlftQsULpig7Rqx4wRTpGAkZLykU2JPWpUblZGfHiBYvmOxiJS/xmKgFxuyY6+R0deHiBZOpY8apeeLXScslS8cIynhJIWdRy1RqVE7GZkWDeMEk6xgV4gWTrGN0iBdMYtuViBdMYrFSmzNeqEi61+gRL5iEOURkxksKCTpGk3iZYK2OEXYeYQ7r1/LspUblrNQxysQLZqWO0SZeMKt0jIxSo3JW6BiF4gWzIjtG0a9LW2LJbasUL5jFqZPjjBcqFnSMgIP56jGvY9SKF8zsFiZuho6dt4E7nNYxcZN7uzmwwuZmUjlEeWEPoGOieDEIUIRH3G0iY0fH+MuzfZuc7no278wCZ51Op9PpdDqdTqdjln9/zk28o9KrJgAAAABJRU5ErkJggg==',
                                  width: 100,
                                  height: 100,
                                  fit: BoxFit.contain,
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
                            child: Text(
                              '1. How healthy do you consider yourself on a scale of 1 to 10?',
                              style: FlutterFlowTheme.of(context)
                                  .bodyText1
                                  .override(
                                    fontFamily: 'Open Sans',
                                    color: Color(0xFF171717),
                                    fontWeight: FontWeight.w500,
                                  ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(0, 2, 0, 0),
                            child: FlutterFlowRadioButton(
                              options: [
                                '1',
                                '2',
                                '3',
                                '4',
                                '5',
                                '6',
                                '7',
                                '8',
                                '9',
                                '10'
                              ],
                              onChanged: (value) {
                                setState(() => radioButtonValue1 = value);
                              },
                              optionHeight: 25,
                              textStyle: FlutterFlowTheme.of(context)
                                  .bodyText1
                                  .override(
                                    fontFamily: 'Poppins',
                                    color: Colors.black,
                                  ),
                              textPadding:
                                  EdgeInsetsDirectional.fromSTEB(4, 0, 16, 0),
                              buttonPosition: RadioButtonPosition.left,
                              direction: Axis.horizontal,
                              radioButtonColor: Color(0xFF00A8A3),
                              inactiveRadioButtonColor: Color(0x8A000000),
                              toggleable: false,
                              horizontalAlignment: WrapAlignment.spaceEvenly,
                              verticalAlignment: WrapCrossAlignment.start,
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
                            child: Text(
                              '2. How often  do you get a health checkup?',
                              style: FlutterFlowTheme.of(context).bodyText1,
                            ),
                          ),
                          FlutterFlowRadioButton(
                            options: [
                              'Once in Months',
                              'Once a year',
                              'On when needed',
                              'Never get it done',
                              'Other'
                            ],
                            onChanged: (value) {
                              setState(() => radioButtonValue2 = value);
                            },
                            optionHeight: 35,
                            textStyle:
                                FlutterFlowTheme.of(context).bodyText1.override(
                                      fontFamily: 'Poppins',
                                      color: Colors.black,
                                    ),
                            buttonPosition: RadioButtonPosition.left,
                            direction: Axis.vertical,
                            radioButtonColor: Color(0xFF00A8A3),
                            inactiveRadioButtonColor: Color(0x8A000000),
                            toggleable: false,
                            horizontalAlignment: WrapAlignment.start,
                            verticalAlignment: WrapCrossAlignment.start,
                          ),
                          Align(
                            alignment: AlignmentDirectional(0, 0),
                            child: Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 24, 0, 0),
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.82,
                                height: 55,
                                decoration: BoxDecoration(
                                  color: Color(0xFF00A8A3),
                                  borderRadius: BorderRadius.circular(24),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Next Slot at 11:00 AM',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyText1
                                          .override(
                                            fontFamily: 'Open Sans',
                                            color: Colors.white,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          8, 0, 0, 0),
                                      child: Image.asset(
                                        'assets/images/Layer_2.png',
                                        width: 30,
                                        height: 30,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Align(
                            alignment: AlignmentDirectional(0, 0),
                            child: Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 4, 0, 4),
                              child: Text(
                                'Or, ',
                                style: FlutterFlowTheme.of(context).bodyText1,
                              ),
                            ),
                          ),
                          Align(
                            alignment: AlignmentDirectional(0, 0),
                            child: Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 0, 0, 12),
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.82,
                                height: 55,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(24),
                                  border: Border.all(
                                    color: Color(0xFF00A8A3),
                                    width: 2,
                                  ),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Schedule your Slot',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyText1
                                          .override(
                                            fontFamily: 'Open Sans',
                                            color: Color(0xFF00A8A3),
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          8, 0, 0, 0),
                                      child: Image.asset(
                                        'assets/images/Group_608.png',
                                        width: 30,
                                        height: 30,
                                        fit: BoxFit.contain,
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
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
