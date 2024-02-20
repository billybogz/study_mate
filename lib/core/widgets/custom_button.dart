import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

enum CustomButtonType { positive, negative }

class CustomButton extends StatefulWidget {
  final VoidCallback? onPressed;
  final String title;
  final FocusNode? focusNode;
  final CustomButtonType type;
  final Color? backgroundColor;
  final double? width, height;
  final FontWeight? fontWeight;
  final double? elevation;
  final TextStyle? style;
  final double radius;
  final double? fontSize;

  const CustomButton({
    super.key,
    required this.type,
    required this.title,
    this.onPressed,
    this.focusNode,
    this.backgroundColor,
    this.width,
    this.height,
    this.fontWeight,
    this.elevation,
    this.style,
    this.radius = 40,
    this.fontSize,
  });

  const CustomButton.positive({
    super.key,
    required this.title,
    this.onPressed,
    this.focusNode,
    this.backgroundColor,
    this.width,
    this.height,
    this.fontWeight,
    this.elevation,
    this.style,
    this.radius = 40,
    this.fontSize,
  }) : type = CustomButtonType.positive;

  const CustomButton.negative({
    super.key,
    required this.title,
    this.onPressed,
    this.focusNode,
    this.backgroundColor,
    this.width,
    this.height,
    this.fontWeight,
    this.elevation,
    this.style,
    this.radius = 40,
    this.fontSize,
  }) : type = CustomButtonType.negative;

  @override
  _CustomButtonState createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height ?? 50,
      child: ElevatedButton(
        focusNode: widget.focusNode,
        onPressed: widget.onPressed ?? () {},
        style: ElevatedButton.styleFrom(
          elevation: 3,
          // backgroundColor: widget.type == CustomButtonType.positive
          //     ? widget.backgroundColor ?? AppColor.primaryAppColor
          //     : widget.backgroundColor ?? AppColor.primaryBGColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(widget.radius),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: AutoSizeText(
            widget.title,
            style: widget.style ??
                Theme.of(context).textTheme.titleSmall!.copyWith(
                      // color: widget.type == CustomButtonType.negative
                      //     ? AppColor.primaryTextColor
                      //     : null,
                      fontWeight: widget.fontWeight,
                      fontSize: widget.fontSize,
                    ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
