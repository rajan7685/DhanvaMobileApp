import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';

import '../flutter_flow/flutter_flow_theme.dart';

enum ToastType { Error, Success, Info, Default }

class Toast {
  Toast._();

  static Map<ToastType, Color> _colorMap = {
    ToastType.Default: Color(0xFF0096FF),
    ToastType.Error: Color(0xffC21010),
    ToastType.Success: Colors.green.shade800,
    ToastType.Info: Colors.teal,
  };

  static void showToast(BuildContext context,
      {String message = 'This is a simple toast',
      ToastType type = ToastType.Default}) {
    SnackBar _snackbar = SnackBar(
      backgroundColor: _colorMap[type],
      shape: StadiumBorder(),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 18),
      margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).size.height * .6,
          // top: MediaQuery.of(context).size.height * .15,
          left: MediaQuery.of(context).size.width * .1,
          right: MediaQuery.of(context).size.width * .1),
      dismissDirection: DismissDirection.up,
      behavior: SnackBarBehavior.floating,
      content: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (type == ToastType.Error)
            Icon(
              Icons.error_outline_outlined,
              size: 18,
              color: Colors.white,
            ),
          SizedBox(width: 6),
          Flexible(
              child: Text(
            message,
            style: FlutterFlowTheme.of(context).bodyText1.override(
                  fontFamily: 'Poppins',
                  fontSize: 12,
                  color: Colors.white,
                  // fontWeight: FontWeight.w300,
                ),
          )),
        ],
      ),
    );
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(_snackbar);
  }
}
