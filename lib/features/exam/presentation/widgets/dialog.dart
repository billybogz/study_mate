import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomDialog extends StatelessWidget {
  /// If [icon] is null, Assets.svg.systemIcons.modal.warning.svg() is used.
  ///
  /// If [confirmText] is null, 'OK' is used.
  ///
  /// If [cancelText] is null, 'Cancel' is used.
  ///
  /// [onConfirm] and [onCancel] both dismiss the Dialog after triggering the callback.
  ///
  /// If [onCancel] is not null, its button will show to the right of [onConfirm] button.
  /// To make them on top of each other, set [areButtonsStacked] to true.
  ///
  /// If [body] is displayed in more that 10 lines, the view becomes scrollable.
  ///
  const CustomDialog({
    required this.title,
    this.body,
    this.customBody,
    this.confirmText,
    this.cancelText,
    this.icon,
    this.onConfirm,
    this.onCancel,
    this.areButtonsStacked = false,
    this.textButtonMargin = 16,
    this.showCancelButton = false,
    super.key,
  });

  final Widget? icon;
  final String title;
  final String? body;
  final Widget? customBody;
  final String? confirmText;
  final String? cancelText;
  final VoidCallback? onConfirm;
  final VoidCallback? onCancel;
  final bool areButtonsStacked;
  final double textButtonMargin;
  final bool showCancelButton;

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      key: const Key('annotated_region_key'),
      sized: false,
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Colors.black54,
      ),
      child: Dialog(
        surfaceTintColor: Colors.white,
        insetPadding: const EdgeInsets.all(
          20,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            20,
          ),
        ),
        child: Padding(
          key: const Key('main_padding_key'),
          padding: const EdgeInsets.all(
            16,
          ),
          child: Column(
            key: const Key('main_column_key'),
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: SizedBox(
                  key: const Key('sizedbox_1_key'),
                  height: 70,
                  width: 70,
                  child: Padding(
                    key: const Key('icon_sizedbox_key'),
                    padding: const EdgeInsets.all(
                      4.0,
                    ),
                    child: Icon(
                      Icons.warning_amber_rounded,
                      size: 70,
                      color: Colors.redAccent[100],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              _TitleView(title: title),
              if (customBody != null) ...[
                const SizedBox(height: 8),
                customBody!,
              ],
              if (body != null && body != '' && customBody == null) ...[
                const SizedBox(height: 8),
                ConstrainedBox(
                  key: const Key('constrainedbox_key'),
                  constraints: BoxConstraints.loose(
                    const Size.fromHeight(
                      210,
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: _BodyView(body: body),
                  ),
                ),
              ],
              const SizedBox(height: 32),
              if (onCancel == null) ...[
                const _ConfirmButton(),
              ],
              if (onCancel != null) ...[
                if (areButtonsStacked) ...[
                  Column(
                    key: const Key('child_column_key'),
                    children: [
                      ElevatedButton(
                        onPressed: () {},
                        child: const Text('O'),
                      ),
                      const SizedBox(height: 16),
                      if (showCancelButton) const _CancelButton(),
                    ],
                  ),
                ] else ...[
                  Row(
                    children: [
                      if (showCancelButton)
                        const Expanded(
                          key: Key('cancel_expanded_key'),
                          child: _CancelButton(),
                        ),
                      const SizedBox(
                        key: Key('sizedbox_3_key'),
                        width: 7,
                      ),
                      Expanded(
                        key: const Key('confirm_expanded_key'),
                        child: _ConfirmButton(
                          onConfirm: onConfirm,
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _CancelButton extends StatelessWidget {
  const _CancelButton();

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      child: const Text('Cancel'),
    );
  }
}

class _BodyView extends StatelessWidget {
  const _BodyView({
    required this.body,
  });

  final String? body;

  @override
  Widget build(BuildContext context) {
    return Text(
      key: const Key('body_key'),
      body!,
      textAlign: TextAlign.center,
      style: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        height: 1.43,
        color: Colors.black,
      ),
    );
  }
}

class _TitleView extends StatelessWidget {
  const _TitleView({
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      key: const Key('title_key'),
      title,
      textAlign: TextAlign.center,
      style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w700,
          height: 1.5,
          color: Colors.deepPurple),
    );
  }
}

class _ConfirmButton extends StatelessWidget {
  // ignore: unused_element
  const _ConfirmButton({this.onConfirm});

  final VoidCallback? onConfirm;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onConfirm,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.deepPurple,
      ),
      child: const Text(
        'Understood!',
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }
}
