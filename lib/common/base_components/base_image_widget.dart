import 'package:flutter/material.dart';

class BaseImageWidget extends StatefulWidget {
  final BaseImageData? data;

  const BaseImageWidget({
    super.key,
    required this.data,
  });

  @override
  State<BaseImageWidget> createState() => _BaseImageWidgetState();
}

class _BaseImageWidgetState extends State<BaseImageWidget> {
  @override
  Widget build(BuildContext context) {
    if (widget.data?.png != null) {
      try {
        if ((widget.data?.height != null && widget.data?.width != null) ||
            widget.data?.aspectRatio != null) {
          var aspectHeight = widget.data?.height?.toDouble();
          var aspectWidth = widget.data?.width?.toDouble();
          if (widget.data?.aspectRatio != null) {
            var aspectRatio = widget.data?.aspectRatio;
            aspectWidth = MediaQuery.of(context).size.width;
            aspectHeight = (aspectWidth / aspectRatio!);
          }
          return Image.network(
            widget.data!.png.toString(),
            height: aspectHeight,
            width: aspectWidth,
            fit: BoxFit.fill,
            errorBuilder: (BuildContext context, Object exception,
                StackTrace? stackTrace) {
              return SizedBox(
                height: aspectHeight,
                width: aspectWidth,
              );
            },
            loadingBuilder: (BuildContext context, Widget child,
                ImageChunkEvent? loadingProgress) {
              if (loadingProgress == null) return child;
              return SizedBox(
                height: aspectHeight,
                width: aspectWidth,
              );
            },
          );
        } else {
          return Image.network(
            widget.data!.png.toString(),
            errorBuilder: (BuildContext context, Object exception,
                StackTrace? stackTrace) {
              return const SizedBox.shrink();
            },
            loadingBuilder: (BuildContext context, Widget child,
                ImageChunkEvent? loadingProgress) {
              if (loadingProgress == null) return child;
              return const SizedBox.shrink();
            },
          );
        }
      } catch (e) {
        return const SizedBox.shrink();
      }
    } else {
      return const SizedBox.shrink();
    }
  }
}

class BaseImageData {
  final String? png;
  final int? height;
  final int? width;
  final double? aspectRatio;

  BaseImageData({
    this.png,
    this.height,
    this.width,
    this.aspectRatio,
  });
}
