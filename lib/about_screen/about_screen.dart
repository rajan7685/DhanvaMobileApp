import 'package:flutter/material.dart';

class AboutScreenWidget extends StatefulWidget {
  const AboutScreenWidget({Key key}) : super(key: key);

  @override
  State<AboutScreenWidget> createState() => _AboutScreenWidgetState();
}

class _AboutScreenWidgetState extends State<AboutScreenWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffEDF3F3),
      body: SafeArea(
        child: Column(
          children: [],
        ),
      ),
    );
  }
}
