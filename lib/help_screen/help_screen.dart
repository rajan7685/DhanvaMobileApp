import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

class HelpScreenWidget extends StatefulWidget {
  const HelpScreenWidget({Key key}) : super(key: key);

  @override
  State<HelpScreenWidget> createState() => _HelpScreenWidgetState();
}

class _HelpScreenWidgetState extends State<HelpScreenWidget> {
  String _appName;
  String _appVersion;
  String _packageName;
  String _appBuildNumber;

  void loadVersioningDetails() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    _appName = packageInfo.appName;
    _packageName = packageInfo.packageName;
    _appVersion = packageInfo.version;
    _appBuildNumber = packageInfo.buildNumber;
    setState(() {
      // update UI with above data
    });
  }

  @override
  void initState() {
    super.initState();
    loadVersioningDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                // SizedBox(
                //   width: 4,
                // ),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(Icons.arrow_back_rounded,
                      size: 26, color: Color(0xff00A8A3)),
                ),
                Spacer(),
                Text("Help",
                    style: TextStyle(
                        color: Color(0xff00A8A3),
                        fontSize: 22,
                        fontWeight: FontWeight.bold)),
                Spacer(),
              ],
            ),
            SizedBox(
              height: 55,
            ),
            Text(
              _appName ?? '',
              style: TextStyle(
                  color: Color(0xff00A8A3),
                  fontSize: 32,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Text(
                  'App Version : ${_appVersion ?? '__._._'}',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(
              height: 6,
            ),
            Row(
              children: [
                Text(
                  'App Build Number : ${_appBuildNumber ?? '___'}',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
