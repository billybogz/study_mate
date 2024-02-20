import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    this.controller,
    this.labelText,
    this.validator,
    this.isRequired = true,
    this.hintText,
    this.minLines,
    this.maxLines,
    this.showLabelError = true,
    this.onChanged,
    this.inputFormatters,
    this.textCapitalization = TextCapitalization.none,
    this.fillColor,
    this.textInputAction,
    this.readOnly = false,
    this.suffixIcon,
    this.initialValue,
    this.keyboardType,
    this.maxLength,
    this.isLoading = false,
    this.prefixIcon,
  });

  final TextEditingController? controller;
  final String? labelText;
  final String? hintText;
  final String? Function(String?)? validator;
  final bool isRequired, showLabelError;
  final int? minLines, maxLines;
  final void Function(String)? onChanged;
  final List<TextInputFormatter>? inputFormatters;
  final TextCapitalization textCapitalization;
  final Color? fillColor;
  final TextInputAction? textInputAction;
  final bool readOnly;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final String? initialValue;
  final TextInputType? keyboardType;
  final int? maxLength;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialValue,
      readOnly: readOnly,
      onChanged: onChanged,
      textInputAction: textInputAction ?? TextInputAction.next,
      controller: controller,
      obscureText: false,
      keyboardType: keyboardType,
      // decoration: FieldInputDecoration().decoration(
      //   context,
      //   labelText: labelText,
      //   hintText: hintText,
      //   fillColor: fillColor,
      //   suffixIcon: suffixIcon,
      //   prefixIcon:
      //       isLoading ? _PrefixLoader(labelText: labelText) : prefixIcon,
      //   counterText: maxLength != null ? '' : null,
      // ),
      // style: context.textTheme.bodyMedium!.copyWith(
      //   fontFamily: ksecondaryFont,
      //   color: AppColor.primaryAppColor,
      //   fontSize: 16,
      //   fontWeight: FontWeight.w600,
      // ),
      minLines: minLines,
      maxLines: maxLines,
      validator: (String? value) {
        return isRequired
            ? value == Null || value!.isEmpty
                ? '${showLabelError ? labelText : 'This'} is required'
                : null
            : null;
      },
      inputFormatters: inputFormatters,
      textCapitalization: textCapitalization,
      maxLength: maxLength,
    );
  }
}

// ignore: unused_element
class _PrefixLoader extends StatelessWidget {
  const _PrefixLoader({
    required this.labelText,
  });

  final String? labelText;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        const SizedBox(width: 20),
        Text(
          labelText!,
          style: Theme.of(context).textTheme.bodySmall!.copyWith(
                fontSize: 13.5,
              ),
        ),
        const SizedBox(width: 8),
        const CupertinoActivityIndicator(),
      ],
    );
  }
}
