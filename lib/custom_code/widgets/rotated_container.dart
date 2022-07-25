// Automatic FlutterFlow imports
import '../../flutter_flow/flutter_flow_theme.dart';
import '../../flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';

// Begin custom widget code
class RotatedContainer extends StatefulWidget {
  const RotatedContainer({
    Key key,
    this.width,
    this.height,
    this.angle,
  }) : super(key: key);

  final double width;
  final double height;
  final double angle;

  @override
  _RotatedContainerState createState() => _RotatedContainerState();
}

class _RotatedContainerState extends State<RotatedContainer> {
  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: widget.angle,
    );
  }
}
