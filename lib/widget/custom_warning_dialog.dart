import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';

Future<Object?> customWarningDialog({
  required BuildContext context,
  required String message,
  void Function()? onPositiveClick,
  void Function()? onNegativeClick,
}) {
  return showAnimatedDialog(
    context: context,
    builder: (BuildContext context) {
      return ClassicGeneralDialogWidget(
        titleText: 'Warning!',
        contentText: message,
        negativeText: 'Cancel',
        positiveText: 'Okay',
        onNegativeClick: (onNegativeClick == null)
            ? Navigator.of(context).pop
            : onNegativeClick,
        onPositiveClick: onPositiveClick,
      );
    },
    animationType: DialogTransitionType.size,
    curve: Curves.fastOutSlowIn,
  );
}
