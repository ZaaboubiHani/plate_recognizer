import 'package:flutter/material.dart';

class OmniButton extends StatelessWidget {
  const OmniButton({
    super.key,
    required this.onPressed,
    this.backgroundColor = Colors.indigo,
    this.text,
    this.margin,
    this.padding,
    this.elevation,
    this.textStyle = const TextStyle(color: Colors.white),
    this.cornerRadius = 15,
    this.width,
    this.height,
    this.icon,
    this.iconPosition = AxisDirection.left,
    this.gap = 10,
    this.borderColor = Colors.transparent,
    this.borderThickness = 0,
    this.gradient,
    this.enabled = true,
  });
  final void Function()? onPressed;
  final Color backgroundColor;
  final Color borderColor;
  final double borderThickness;
  final String? text;
  final EdgeInsets? margin;
  final EdgeInsets? padding;
  final double? elevation;
  final TextStyle? textStyle;
  final double cornerRadius;
  final double? width;
  final double? height;
  final Widget? icon;
  final double gap;
  final AxisDirection iconPosition;
  final Gradient? gradient;
  final bool enabled;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(cornerRadius),
      ),
      child: ElevatedButton(
        onPressed: enabled ? onPressed : null,
        style: ElevatedButton.styleFrom(
            padding: EdgeInsets.zero,
            minimumSize: const Size(50, 20),
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            side: BorderSide(color: borderColor, width: borderThickness),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(cornerRadius),
            ),
            backgroundColor:
                gradient == null ? backgroundColor : Colors.transparent,
            elevation: elevation),
        child: Ink(
          decoration: BoxDecoration(
            gradient: gradient,
            borderRadius: BorderRadius.circular(cornerRadius),
          ),
          child: Container(
            color: Colors.transparent,
            padding: padding,
            width: width,
            height: height,
            child: iconPosition == AxisDirection.left
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      icon ?? const SizedBox(),
                      SizedBox(
                        width: icon == null || text == null ? 0 : gap,
                      ),
                      text != null
                          ? Expanded(
                              child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  text!,
                                  textAlign: TextAlign.center,
                                  style: textStyle,
                                ),
                              ),
                            )
                          : const SizedBox(),
                    ],
                  )
                : iconPosition == AxisDirection.right
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          text != null
                              ? Text(
                                  text!,
                                  textAlign: TextAlign.center,
                                  style: textStyle,
                                )
                              : const SizedBox(),
                          SizedBox(
                            width: icon == null || text == null ? 0 : gap,
                          ),
                          icon ?? const SizedBox(),
                        ],
                      )
                    : iconPosition == AxisDirection.up
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              icon ?? const SizedBox(),
                              SizedBox(
                                height: icon == null || text == null ? 0 : gap,
                              ),
                              text != null
                                  ? Text(
                                      text!,
                                      textAlign: TextAlign.center,
                                      style: textStyle,
                                    )
                                  : const SizedBox(),
                            ],
                          )
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              text != null
                                  ? Text(
                                      text!,
                                      textAlign: TextAlign.center,
                                      style: textStyle,
                                    )
                                  : const SizedBox(),
                              SizedBox(
                                height: icon == null || text == null ? 0 : gap,
                              ),
                              icon ?? const SizedBox(),
                            ],
                          ),
          ),
        ),
      ),
    );
  }
}
