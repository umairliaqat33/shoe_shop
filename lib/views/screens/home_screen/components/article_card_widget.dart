import 'package:flutter/material.dart';
import 'package:shoe_shop/utils/colors.dart';
import 'package:shoe_shop/views/screens/home_screen/components/article_card_upper_widget.dart';

class ArticleCardWidget extends StatelessWidget {
  const ArticleCardWidget({
    super.key,
    required this.articleName,
    required this.deleteFunction,
    required this.editFunction,
    required this.totalColors,
    required this.totalQuantity,
  });
  final String articleName;
  final int totalQuantity;
  final int totalColors;
  final VoidCallback deleteFunction;
  final VoidCallback editFunction;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        ArcticleCardUpperWidget(
          articleNumber: articleName,
          totalColors: totalColors,
          totalQuantity: totalQuantity,
        ),
        const Divider(
          color: lightGrey,
        ),
      ],
    );
  }

// SizedBox(
//                   width: 50,
//                   child: Column(
//                     children: [
//                       IconButton(
//                         onPressed: () => deleteFunction(),
//                         icon: const Icon(
//                           Icons.delete_rounded,
//                           color: lightGrey,
//                         ),
//                       ),
//                       IconButton(
//                         onPressed: () => editFunction(),
//                         icon: const Icon(
//                           Icons.edit,
//                           color: lightGrey,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
}
