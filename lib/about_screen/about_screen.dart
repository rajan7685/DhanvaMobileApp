import 'package:dhanva_mobile_app/components/notification_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class AboutScreenWidget extends StatefulWidget {
  const AboutScreenWidget({Key key}) : super(key: key);

  @override
  State<AboutScreenWidget> createState() => _AboutScreenWidgetState();
}

class _AboutScreenWidgetState extends State<AboutScreenWidget> {
  @override
  WebViewController _controller;

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffEDF3F3),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 6,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6),
              child: Row(
                //mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () async {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.arrow_back_sharp,
                      color: Color(0xff00A8A3),
                      size: 32,
                    ),
                  ),
                  // NotificationIconButton()
                ],
              ),
            ),
            SizedBox(
              height: 14,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                'About Us',
                style: TextStyle(
                    color: Color(0xff00A8A3),
                    fontSize: 26,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              child: WebView(
                initialUrl: 'https://dhanva.icu/',
                javascriptMode: JavascriptMode.unrestricted,
                onWebViewCreated: (WebViewController webViewController) {
                  _controller = webViewController;
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
