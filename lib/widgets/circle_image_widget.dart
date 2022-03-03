import 'package:flutter/material.dart';
import 'package:movie_booking_app/resources/dimension.dart';

class CircleImageView extends StatelessWidget {
  final double size;
  final bool isNetworkImage;
  final String urlImage;

  CircleImageView({
    this.size = image_circle_container_size,
    this.isNetworkImage = false,
    required this.urlImage,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: isNetworkImage
              ? DecorationImage(
                  image: NetworkImage(urlImage), fit: BoxFit.cover)
              : DecorationImage(image: AssetImage(urlImage), fit: BoxFit.cover),
        ));
  }
}
