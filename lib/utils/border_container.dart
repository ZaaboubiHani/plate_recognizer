import 'package:flutter/material.dart';

class BorderContainer extends StatelessWidget {
  const BorderContainer({
    required this.child,
    this.margin,
    this.padding,
    this.cornerRadius = 15,
    this.borderThickness = 0,
    this.borderColor = Colors.transparent,
    this.backgroundColor = Colors.indigo,
    this.width,
    this.height,
    this.elevation,
    this.gradient,
    this.corners,
    super.key,
    this.border,
  });
  final Widget child;
  final EdgeInsets? margin;
  final EdgeInsets? padding;
  final double cornerRadius;
  final (double, double, double, double)? corners;
  final double borderThickness;
  final Color borderColor;
  final Color backgroundColor;
  final double? width;
  final double? height;
  final double? elevation;
  final Gradient? gradient;
  final BoxBorder? border;
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      color: Colors.transparent,
      duration: const Duration(milliseconds: 300),
      margin: margin,
      child: Material(
        color: Colors.transparent,
        elevation: elevation ?? 0,
        borderRadius: corners == null
            ? BorderRadius.circular(cornerRadius)
            : BorderRadius.only(
                topLeft: Radius.circular(corners!.$1),
                topRight: Radius.circular(corners!.$2),
                bottomRight: Radius.circular(corners!.$3),
                bottomLeft: Radius.circular(corners!.$4)),
        clipBehavior: Clip.antiAlias,
        child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            width: width,
            height: height,
            padding: padding,
            decoration: BoxDecoration(
              border: border ??
                  Border.all(color: borderColor, width: borderThickness),
              borderRadius: corners == null
                  ? BorderRadius.circular(cornerRadius)
                  : BorderRadius.only(
                      topLeft: Radius.circular(corners!.$1),
                      topRight: Radius.circular(corners!.$2),
                      bottomRight: Radius.circular(corners!.$3),
                      bottomLeft: Radius.circular(corners!.$4)),
              gradient: gradient,
              color: backgroundColor,
            ),
            child: child),
      ),
    );
  }
}
