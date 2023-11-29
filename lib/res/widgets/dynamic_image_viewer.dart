import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../const.dart';

class DynamicImageViewer extends StatelessWidget {
  final String image;

  const DynamicImageViewer({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return image.contains('svg') == true
        ? SvgPicture.network(
            image,
            height: 25,
            width: 25,
            color: colorPrimary,
          ) : CachedNetworkImage(
            imageUrl: image,
            height: 25,
            width: 25,
          );
  }
}
