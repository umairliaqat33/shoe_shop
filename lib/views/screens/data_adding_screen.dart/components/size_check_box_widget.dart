import 'package:flutter/material.dart';
import 'package:shoe_shop/utils/colors.dart';
import 'package:shoe_shop/views/widgets/check_box_widgets/size_check_box_widget.dart';

class SizeCheckBoxColumnWidget extends StatelessWidget {
  const SizeCheckBoxColumnWidget({
    super.key,
    required List<String> sizeList,
    required bool size2125,
    required bool size2630,
    required bool size3136,
    required bool size3237,
    required bool size3641,
    required bool size1519,
  })  : _sizeList = sizeList,
        _size2125 = size2125,
        _size2630 = size2630,
        _size3136 = size3136,
        _size3237 = size3237,
        _size3641 = size3641,
        _size1519 = size1519;

  final List<String> _sizeList;
  final bool _size2125;
  final bool _size2630;
  final bool _size3136;
  final bool _size3237;
  final bool _size3641;
  final bool _size1519;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(
        10,
      ),
      decoration: BoxDecoration(
        border: Border.all(
          color: lightGrey,
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(
            10,
          ),
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Please select your Sizes:",
              style: TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizeCheckBoxWidget(
                  list: _sizeList,
                  value: _size2125,
                  boxName: '21/25',
                ),
                SizeCheckBoxWidget(
                  list: _sizeList,
                  value: _size2630,
                  boxName: '26/30',
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizeCheckBoxWidget(
                  list: _sizeList,
                  value: _size3136,
                  boxName: '31/36',
                ),
                SizeCheckBoxWidget(
                  list: _sizeList,
                  value: _size3237,
                  boxName: '32/37',
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizeCheckBoxWidget(
                  list: _sizeList,
                  value: _size3641,
                  boxName: '36/41',
                ),
                SizeCheckBoxWidget(
                  list: _sizeList,
                  value: _size1519,
                  boxName: '15/19',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
