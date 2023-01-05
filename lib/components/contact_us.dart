import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

import '../constants.dart';

class ContactUs {
  Widget contactUsButton() {
    return FloatingActionButton(
      onPressed: _callNumber,
      backgroundColor: Colors.green,
      child: const Icon(Icons.phone_enabled),
    );
  }

  _callNumber() async {
    bool res = await FlutterPhoneDirectCaller.callNumber(Constant.contactNo);
  }
}
