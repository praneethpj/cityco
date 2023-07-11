import 'package:cached_network_image/cached_network_image.dart';
import 'package:cityco/widgets/customized_circular_indicator.dart';
import 'package:flutter/material.dart';

class ImageWidgetContainer extends StatelessWidget {
  final String image;
  ImageWidgetContainer({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
          child: SizedBox(
            child: CachedNetworkImage(
              filterQuality: FilterQuality.medium,
              width: constraints.minWidth + 1 * 300,
              height: constraints.maxHeight,
              fit: BoxFit.cover,
              imageUrl: image,
              placeholder: (context, url) =>
                  const CustomizedCircularIndicator(),
              errorWidget: (context, url, error) => Text("Url is corrupt"),
            ),
          ),
        );
      },
    );
  }
}
