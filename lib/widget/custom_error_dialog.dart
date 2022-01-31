import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';

Future<Object?> customErrorDialog(BuildContext context, String message) {
  Navigator.of(context).pop();
  return showAnimatedDialog(
    context: context,
    builder: (BuildContext context) {
      return ClassicGeneralDialogWidget(
        titleText: 'Error!',
        contentText: message,
        positiveText: 'Okay',
        onPositiveClick: () {
          Navigator.of(context).pop();
        },
      );
    },
    animationType: DialogTransitionType.size,
    curve: Curves.fastOutSlowIn,
  );
}
