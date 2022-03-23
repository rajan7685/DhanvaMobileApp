// Automatic FlutterFlow imports
import '../../flutter_flow/flutter_flow_theme.dart';
import '../../flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';

// Begin custom widget code
class OTPWidget extends StatefulWidget {
  const OTPWidget(
      {Key key,
      this.width,
      this.height,
      this.otpLength,
      this.fieldFillColor,
      this.textColor,
      this.borderRadius,
      this.fieldWidth,
      this.fieldHeight,
      @required this.onComplete})
      : super(key: key);

  final double width;
  final double height;
  final int otpLength;
  final Color fieldFillColor;
  final Color textColor;
  final double borderRadius;
  final double fieldWidth;
  final double fieldHeight;
  final Function(String) onComplete;

  @override
  _OTPWidgetState createState() => _OTPWidgetState();
}

class _OTPWidgetState extends State<OTPWidget> {
  final List<TextEditingController> _controllers = [];
  List<int> otp = List.filled(4, 0);
  final String _hollowCirleUnicode = '\u25cb';
  final String _filledCirleUnicode = '\u25cf';

  void _initiallizeEditingControllers() {
    for (int i = 0; i < widget.otpLength; i++) {
      _controllers.add(TextEditingController());
    }
  }

  void _disposeEditingControllers() {
    for (int i = 0; i < widget.otpLength; i++) {
      _controllers[i].dispose();
    }
  }

  @override
  void initState() {
    super.initState();
    _initiallizeEditingControllers();
  }

  void checkValidity() {
    bool result = _controllers.every((c) => c.text.isNotEmpty);
    String _otp = '';
    if (result) {
      otp.forEach((e) => _otp += e.toString());
      widget.onComplete(_otp);
    }
  }

  List<Widget> _generateTextEditors() {
    List<Widget> fields = [];

    void _feedOtp(String v, int id) {
      otp[id] = int.parse(v);
    }

    for (int i = 0; i < widget.otpLength; i++) {
      fields.add(
        Container(
          margin: const EdgeInsets.only(right: 14),
          height: widget.fieldHeight,
          width: widget.fieldWidth,
          child: TextField(
            style: TextStyle(color: widget.textColor),
            textAlign: TextAlign.center,
            textAlignVertical: TextAlignVertical.center,
            keyboardType: TextInputType.number,
            controller: _controllers[i],
            autofocus: false,
            onChanged: (String val) {
              // handle the text
              if (val.isNotEmpty) {
                _feedOtp(val, i);
                _controllers[i].text = _filledCirleUnicode;
              }

              if (i != widget.otpLength - 1 &&
                  _controllers[i].text.isNotEmpty) {
                FocusScope.of(context).nextFocus();
              } else if (i == widget.otpLength - 1 &&
                  _controllers[i].text.isNotEmpty) {
                FocusScope.of(context).unfocus();
              }
              checkValidity();
            },
            decoration: InputDecoration(
              hintText: _hollowCirleUnicode,

              hintStyle: TextStyle(color: widget.textColor),
              filled: true,
              fillColor: widget.fieldFillColor,
              // contentPadding: EdgeInsets.all(22),
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.all(
                  Radius.circular(widget.borderRadius),
                ),
              ),
            ),
          ),
        ),
      );
    }
    return fields;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: _generateTextEditors(),
    );
  }

  @override
  void dispose() {
    _disposeEditingControllers();
    super.dispose();
  }
}
