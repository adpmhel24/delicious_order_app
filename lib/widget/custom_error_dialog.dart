import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:loader_overlay/loader_overlay.dart';

Future<Object?> customErrorDialog(BuildContext context,
    {required String message,
    void Function()? onPositiveClick,
    bool? barrierDismissible}) {
  context.loaderOverlay.hide();
  return showAnimatedDialog(
    barrierDismissible: barrierDismissible ?? true,
    context: context,
    builder: (BuildContext context) {
      return WillPopScope(
        onWillPop: () async => false,
        child: ClassicGeneralDialogWidget(
          titleText: 'Error!',
          contentText: message,
          positiveText: 'Okay',
          onPositiveClick: onPositiveClick ??
              () {
                Navigator.of(context).pop();
              },
        ),
      );
    },
    animationType: DialogTransitionType.size,
    curve: Curves.fastOutSlowIn,
  );
}
