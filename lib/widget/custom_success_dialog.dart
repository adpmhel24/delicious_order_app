import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';

Future<Object?> customSuccessDialog({
  required BuildContext context,
  required String message,
  void Function()? onPositiveClick,
}) {
  Navigator.of(context).pop();
  return showAnimatedDialog(
    context: context,
    builder: (BuildContext context) {
      return ClassicGeneralDialogWidget(
        titleText: 'Success!',
        contentText: message,
        positiveText: 'Okay',
        onPositiveClick: onPositiveClick,
      );
    },
    animationType: DialogTransitionType.size,
    curve: Curves.fastOutSlowIn,
  );
}
