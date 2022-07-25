import 'package:dhanva_mobile_app/flutter_flow/flutter_flow_radio_button.dart';
import 'package:dhanva_mobile_app/flutter_flow/flutter_flow_theme.dart';
import 'package:dhanva_mobile_app/psychometrics_assesment_screen/models/psychometrics_assesment_question.dart';
import 'package:flutter/material.dart';

class PsychometricsAssesmentScreen extends StatefulWidget {
  final List<PsychometricsAssesmentQuestion> questions;

  const PsychometricsAssesmentScreen({Key key, @required this.questions})
      : super(key: key);

  @override
  State<PsychometricsAssesmentScreen> createState() =>
      _PsychometricsAssesmentScreenState();
}

class _PsychometricsAssesmentScreenState
    extends State<PsychometricsAssesmentScreen> {
  List<String> _radioButtonValues = [];
  int _currentStep = 0;

  void intitiallizeRadioButtonValues() {
    widget.questions.forEach((element) {
      _radioButtonValues.add('');
    });
  }

  @override
  void initState() {
    super.initState();
    intitiallizeRadioButtonValues();
  }

  List<Widget> _buildQuestionSteps() {
    return List.generate(
        widget.questions.length,
        (int index) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Q: ${widget.questions[index].question}',
                  style: FlutterFlowTheme.of(context).bodyText1.override(
                        fontFamily: 'Poppins',
                        color: Color(0xFF151515),
                      ),
                ),
                FlutterFlowRadioButton(
                    direction: Axis.vertical,
                    buttonPosition: RadioButtonPosition.left,
                    radioButtonColor: Color(0xFF00A8A3),
                    inactiveRadioButtonColor: Color(0x8A314A51),
                    toggleable: false,
                    horizontalAlignment: WrapAlignment.start,
                    verticalAlignment: WrapCrossAlignment.start,
                    options: [...(widget.questions[index].options)],
                    onChanged: (String val) {
                      setState(() {
                        _radioButtonValues[index] = val;
                      });
                    })
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFF3F4F4),
        iconTheme: IconThemeData(color: Color(0xFF00A8A3)),
        automaticallyImplyLeading: false,
        leading: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(0, 0, 10, 0),
          child: InkWell(
            onTap: () async {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back,
              color: Color(0xFF00A8A3),
              size: 28,
            ),
          ),
        ),
        actions: [],
        centerTitle: true,
        elevation: 0,
      ),
      backgroundColor: Color(0xFFF3F4F4),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Psychometrics',
              style: FlutterFlowTheme.of(context).title1.override(
                    fontFamily: 'Open Sans',
                    color: Color(0xFF272727),
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              'Assesment',
              style: FlutterFlowTheme.of(context).title1.override(
                    fontFamily: 'Open Sans',
                    color: Color(0xFF272727),
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            SizedBox(
              height: 16,
            ),
            Expanded(
              child: Stepper(
                elevation: 0,
                type: StepperType.horizontal,
                currentStep: _currentStep,
                physics: BouncingScrollPhysics(),
                onStepContinue: () {
                  _currentStep < 3 ? setState(() => _currentStep += 1) : null;
                },
                onStepCancel: () {
                  _currentStep > 0 ? setState(() => _currentStep -= 1) : null;
                },
                steps: List.generate(
                  4,
                  (int index) => Step(
                    title: Text('Step ${index + 1}'),
                    content: Column(
                      children: _buildQuestionSteps(),
                    ),
                    isActive: _currentStep == index,
                    state: _currentStep >= 0
                        ? StepState.complete
                        : StepState.disabled,
                  ),
                ),
              ),
            )
          ],
        ),
      )),
    );
  }
}
