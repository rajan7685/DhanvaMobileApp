import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CurvedBottomNavBarItem {
  const CurvedBottomNavBarItem(
      {Key key,
      @required this.title,
      @required this.activeImage,
      @required this.inactiveImage});

  final Image activeImage;
  final Image inactiveImage;
  final String title;
}

class CurvedBottomNavBar extends StatefulWidget {
  const CurvedBottomNavBar(
      {Key key,
      @required this.items,
      @required this.ontap,
      this.currentIndex = 0})
      : super(key: key);

  final List<CurvedBottomNavBarItem> items;
  final Function(int) ontap;
  final int currentIndex;

  @override
  State<CurvedBottomNavBar> createState() => _CurvedBottomNavBarState();
}

class _CurvedBottomNavBarState extends State<CurvedBottomNavBar> {
  int _index;

  @override
  void initState() {
    super.initState();
    _index = widget.currentIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 6.0),
      height: 65,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(18))),
      child: Center(
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(
              widget.items.length,
              (int index) => GestureDetector(
                    onTap: () {
                      setState(() {
                        _index = index;
                      });
                      widget.ontap(index);
                    },
                    child: Column(
                      children: [
                        SizedBox(
                          width: 28,
                          height: 28,
                          child: _index == index
                              ? widget.items[index].activeImage
                              : widget.items[index].inactiveImage,
                        ),
                        SizedBox(
                          height: 6,
                        ),
                        Text(
                          widget.items[index].title,
                          style: TextStyle(
                              color: _index == index
                                  ? Color(0xff00A8A3)
                                  : Colors.grey),
                        )
                      ],
                    ),
                  )),
        ),
      ),
    );
  }
}
