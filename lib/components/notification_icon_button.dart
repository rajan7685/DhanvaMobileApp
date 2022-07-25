import 'package:flutter/material.dart';

class NotificationIconButton extends StatefulWidget {
  const NotificationIconButton({Key key}) : super(key: key);

  @override
  State<NotificationIconButton> createState() => _NotificationIconButtonState();
}

class _NotificationIconButtonState extends State<NotificationIconButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: Color(0xFF00827F),
        borderRadius: BorderRadius.circular(16),
      ),
      child: SizedBox(
        width: 30,
        height: 30,
        child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.center,
          children: [
            Image.asset(
              'assets/images/Group_261.png',
              height: 30,
              width: 30,
            ),
            // new notifier
            Positioned(
              top: 12,
              right: 14,
              child: Container(
                padding: EdgeInsets.all(1),
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xff00D3FF),
                ),
                // child: Center(
                //   child: Text(
                //     '1',
                //     style: TextStyle(color: Colors.white),
                //   ),
                // ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
