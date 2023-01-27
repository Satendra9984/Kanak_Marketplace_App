import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class MyBottomNavBar extends StatefulWidget {
  final List<Widget> items;
  final Function(int widgetIndex) onSelected;
  const MyBottomNavBar({
    super.key,
    required this.items,
    required this.onSelected,
  });

  @override
  State<MyBottomNavBar> createState() => _MyBottomNavBarState();
}

class _MyBottomNavBarState extends State<MyBottomNavBar> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      alignment: Alignment.bottomCenter,
      child: Row(
          mainAxisSize: MainAxisSize.min,
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ...widget.items.map((item) {
              return GestureDetector(
                onTap: () {
                  int index = widget.items.indexOf(item);
                  setState(() {
                    currentIndex = index;
                  });
                  widget.onSelected(index);
                },
                child: item,
              );
            }).toList(),
          ]),
    );
  }
}
