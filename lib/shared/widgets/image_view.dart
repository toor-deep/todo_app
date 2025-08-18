import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:todo/shared/assets/images.dart';

class CustomFileImage extends StatelessWidget {
  final File file;
  final double? width;
  final double? height;
  final String? assetImage;
  final BoxFit? fit;
  const CustomFileImage(
      {super.key,
        required this.file,
        this.width,
        this.height,
        this.assetImage,
        this.fit});

  @override
  Widget build(BuildContext context) {
    return Image.file(
      file,
      width: width,
      height: height,
      fit: fit,
      errorBuilder: (
          BuildContext context,
          Object error,
          StackTrace? stackTrace,
          ) {
        return Image.asset(
          assetImage ?? AppImages.on1,
          height: height,
          width: width,
          fit: fit,
        );
      },
    );
  }
}


class HostedImage extends StatelessWidget {
  const HostedImage(this.url,
      {super.key,
        this.fit = BoxFit.cover,
        this.assetImage,
        this.errorWidget,
        this.assetBoxFit = BoxFit.cover,
        this.size = const Size(100, 100)});
  final String url;
  final BoxFit fit;
  final BoxFit assetBoxFit;
  final Size size;
  final String? assetImage;
  final Widget? errorWidget;

  @override
  Widget build(BuildContext context) {
    String secureUrl = url;

    return SizedBox(
      height: size.height,
      width: size.width,
      child: CachedNetworkImage(
        imageUrl: secureUrl,
        fit: fit,
        placeholder: (
            BuildContext context,
            String url,
            ) {
          return Skeletonizer(
              enabled: true,
              child: Container(
                height: size.height,
                width: size.width,
                color: Colors.black,
              ));
        },
        errorWidget: (
            BuildContext context,
            String url,
            Object error,
            ) {
          return errorWidget??Image.asset(
            assetImage ?? AppImages.on1,
            height: size.height,
            width: size.width,
            fit: assetBoxFit,
          );

        },
      ),
    );
  }
}
