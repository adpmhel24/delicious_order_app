import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Future<Object?> customLoadingDialog(BuildContext context) {
  return showAnimatedDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        content: SizedBox(
          height: 100.h,
          child: const Center(
            child: CircularProgressIndicator(),
          ),
        ),
      );
    },
    animationType: DialogTransitionType.size,
    curve: Curves.fastOutSlowIn,
  );
}
