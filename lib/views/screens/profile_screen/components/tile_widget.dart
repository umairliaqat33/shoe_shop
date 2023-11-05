import 'package:flutter/material.dart';

import 'package:shoe_shop/utils/colors.dart';

class TileWidget extends StatelessWidget {
  final String text;
  final String? trailingImg;
  final String? leadingImg;
  final VoidCallback? onTap;
  final Color titleTextColor;

  const TileWidget({
    Key? key,
    required this.text,
    required this.trailingImg,
    required this.leadingImg,
    required this.onTap,
    this.titleTextColor = appTextColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: onTap,
        title: Text(
          text,
          style: TextStyle(
            color: titleTextColor,
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
        ),
        trailing: trailingImg == null
            ? null
            : Image.asset(
                trailingImg!,
              ),
        leading: leadingImg == null
            ? null
            : Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Image.asset(
                  leadingImg!,
                  color: Colors.black,
                ),
              ),
        horizontalTitleGap: 0,
      ),
    );
  }
}
