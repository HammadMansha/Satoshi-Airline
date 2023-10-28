import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:satoshi/Utils/app_constants.dart';

class CircularCachedNetworkImage extends StatelessWidget {
  final String imageURL;
  final double? height;
  final double? width;
  final Color borderColor;
  final BoxFit fit;
  final double borderWidth;
  final BoxShape shape;
  final String errorImage;
  final double radius;

  const CircularCachedNetworkImage(
      {super.key,
      required this.imageURL,
      this.width,
      this.height,
      this.borderColor = Colors.transparent,
      this.fit = BoxFit.cover,
      this.borderWidth = 2,
      this.shape = BoxShape.circle,
      this.errorImage = AppConstants.loadingGif,
      this.radius = 300});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        // color: borderColor,
        shape: shape,
      ),
      child: Container(
        decoration: BoxDecoration(
          shape: shape,
          color: Colors.white, // inner circle color
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(radius)),
          child: CachedNetworkImage(
            imageUrl: imageURL,
            fit: fit,
            placeholder: (context, url) => Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(
                  color: Color(0xff62c8a9),
                )
              ],
            ),
            errorWidget: (context, url, error) => Lottie.asset(
              AppConstants.imageerror,
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}
