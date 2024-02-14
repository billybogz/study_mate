import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomDialog extends StatelessWidget {
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
    this.secondDescription,
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
  final String? secondDescription;

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      key: const Key('annotated_region_key'),
      sized: false,
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Colors.black54,
      ),
      child: WillPopScope(
        onWillPop: () => Future<bool>.value(false),
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
            padding: const EdgeInsets.all(32),
            child: Column(
              key: const Key('main_column_key'),
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                if (icon != null)
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
                        child: icon,
                      ),
                    ),
                  ),
                if (icon != null) const SizedBox(height: 16),
                _TitleView(title: title),
                if (customBody != null) ...<Widget>[
                  const SizedBox(height: 8),
                  customBody!,
                ],
                if (body != null &&
                    body != '' &&
                    customBody == null) ...<Widget>[
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
                if (secondDescription != null &&
                    secondDescription != '') ...<Widget>[
                  const SizedBox(height: 16),
                  ConstrainedBox(
                    constraints: BoxConstraints.loose(
                      const Size.fromHeight(
                        210,
                      ),
                    ),
                    child: SingleChildScrollView(
                      child: _BodyView(body: secondDescription),
                    ),
                  ),
                ],
                const SizedBox(height: 32),
                if (onCancel == null) ...<Widget>[
                  _ConfirmButton(confirmText: confirmText),
                ],
                if (onCancel != null) ...<Widget>[
                  if (areButtonsStacked) ...<Widget>[
                    Column(
                      key: const Key('child_column_key'),
                      children: <Widget>[
                        ElevatedButton(
                          onPressed: () {},
                          child: const Text('O'),
                        ),
                        const SizedBox(height: 16),
                        if (showCancelButton) const _CancelButton(),
                      ],
                    ),
                  ] else ...<Widget>[
                    Row(
                      children: <Widget>[
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
                            confirmText: confirmText,
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
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        height: 1.43,
        color: Colors.grey[600],
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
        fontSize: 24,
        fontWeight: FontWeight.w900,
        height: 1.5,
      ),
    );
  }
}

class _ConfirmButton extends StatelessWidget {
  const _ConfirmButton({this.onConfirm, required this.confirmText});

  final VoidCallback? onConfirm;
  final String? confirmText;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onConfirm,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.deepPurple,
      ),
      child: Text(
        confirmText ?? 'Ok',
        style: const TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }
}
