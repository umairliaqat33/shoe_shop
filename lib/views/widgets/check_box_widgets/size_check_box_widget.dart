// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class SizeCheckBoxWidget extends StatefulWidget {
  SizeCheckBoxWidget({
    super.key,
    required this.list,
    required this.value,
    required this.boxName,
  });
  final List list;
  bool value;
  final String boxName;
  @override
  State<SizeCheckBoxWidget> createState() => _SizeCheckBoxWidgetState();
}

class _SizeCheckBoxWidgetState extends State<SizeCheckBoxWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(widget.boxName),
        Checkbox(
          value: widget.value,
          onChanged: (bool? value) {
            if (value == true) {
              setState(() {
                widget.value = true;
              });
              widget.list.add(
                widget.boxName,
              );
            } else {
              setState(() {
                widget.value = false;
              });
              widget.list.removeWhere(
                (element) => element == widget.boxName,
              );
            }
          },
        ),
      ],
    );
  }
}
