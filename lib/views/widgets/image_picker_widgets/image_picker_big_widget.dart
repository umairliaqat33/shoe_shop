import 'dart:io';

import 'package:flutter/material.dart';

import 'package:file_picker/file_picker.dart';
import 'package:shoe_shop/config/size_config.dart';
import 'package:shoe_shop/utils/assets.dart';
import 'package:shoe_shop/utils/colors.dart';

class ImagePickerBigWidget extends StatelessWidget {
  final String heading;
  final String description;
  final Function onPressed;
  final PlatformFile? platformFile;
  final String? imgUrl;

  const ImagePickerBigWidget({
    Key? key,
    required this.heading,
    required this.description,
    required this.onPressed,
    required this.platformFile,
    required this.imgUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: double.infinity,
        child: imgUrl != null && platformFile == null
            ? MaterialButton(
                onPressed: () async => onPressed(),
                child: SizedBox(
                  width: double.infinity,
                  height: (SizeConfig.height20(context) * 8),
                  child: Stack(children: [
                    Image.network(
                      width: double.infinity,
                      imgUrl!,
                      fit: BoxFit.contain,
                      loadingBuilder: (BuildContext context, Widget child,
                          ImageChunkEvent? loadingProgress) {
                        if (loadingProgress == null) {
                          return child;
                        }
                        return Center(
                          child: CircularProgressIndicator(
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                    loadingProgress.expectedTotalBytes!
                                : null,
                          ),
                        );
                      },
                    ),
                    Visibility(
                      visible: imgUrl != null && platformFile == null,
                      child: Container(
                        height: (SizeConfig.height20(context) * 8),
                        width: SizeConfig.width(context),
                        color: Colors.transparent,
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: Colors.transparent.withOpacity(0.3)),
                          alignment: Alignment.center,
                          child: const Text(
                            "Edit Picture",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: whiteColor,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ]),
                ),
              )
            : platformFile != null
                ? SizedBox(
                    width: (SizeConfig.width20(context) * 16.4),
                    height: (SizeConfig.height20(context) * 8),
                    child: Container(
                      color: blackColor.withOpacity(0.6),
                      child: MaterialButton(
                        onPressed: () async => onPressed(),
                        child: Image.file(
                          File(platformFile!.path!),
                          width: double.infinity,
                        ),
                      ),
                    ),
                  )
                : MaterialButton(
                    onPressed: () async => onPressed(),
                    child: Stack(
                      alignment: AlignmentDirectional.center,
                      children: [
                        Image.asset(
                          Assets.selectImgBigRectangle,
                          fit: BoxFit.contain,
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: SizeConfig.height15(context) * 5),
                          child: Column(
                            children: [
                              Text(
                                textAlign: TextAlign.center,
                                heading,
                                style: const TextStyle(
                                  color: appTextColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(
                                width: (SizeConfig.height20(context) * 9) + 3,
                                child: RichText(
                                  textAlign: TextAlign.center,
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: description,
                                        style: const TextStyle(
                                          color: greyColor,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      const TextSpan(
                                        text: '2 MB',
                                        style: TextStyle(
                                          color: greyColor,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ));
  }
}
