import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_news_app/widget/error_image_widget.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:skeleton_text/skeleton_text.dart';

class CustomCachedNetworkImage extends StatelessWidget {
  final String imageUrl;
  final double width;
  final double height;
  final bool isBorderRadius;

  const CustomCachedNetworkImage({
    super.key,
    required this.imageUrl,
    required this.width,
    required this.height,
    this.isBorderRadius = true,
  });

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      imageBuilder:
          (context, imageProvider) => Container(
            width: width,
            height: height,
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              borderRadius:
                  isBorderRadius ? BorderRadius.circular(10.px) : null,
              image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
            ),
          ),
      placeholder:
          (context, url) =>
              SkeletonAnimation(child: SizedBox(width: width, height: height)),
      errorWidget:
          (context, url, error) =>
              ErrorImageWidget(width: width, height: height),
    );
  }
}
