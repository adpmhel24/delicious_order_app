import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

class NewUpdate {
  late BuildContext _context;
  late String _appName;
  late String _appUrl;
  Text? _message;
  String? _releaseNotes;

  static final NewUpdate _newUpdateInstance = NewUpdate._internal();
  factory NewUpdate() => _newUpdateInstance;
  NewUpdate._internal();

  static displayAlert(
    context, {
    required Text? message,
    required String appUrl,
    required String appName,
    String? releaseNotes,
  }) {
    // Singleton properties
    _newUpdateInstance._context = context;
    _newUpdateInstance._appName = appName;
    _newUpdateInstance._message = message;
    _newUpdateInstance._appUrl = appUrl;
    _newUpdateInstance._releaseNotes = releaseNotes;

    _newUpdateInstance._showMaterialAlertDialog();
  }

  void _showMaterialAlertDialog() {
    showAnimatedDialog(
      context: _context,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async => false,
          child: AlertDialog(
            title: Text(
              'Update $_appName',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.sp),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _message ?? const Text("A new version is available"),
                SizedBox(
                  height: 10.h,
                ),
                const Text("Please update for you to continue using this app."),
                SizedBox(
                  height: 15.h,
                ),
                Wrap(
                  children: [
                    Text(
                      "Release Notes: ",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20.sp),
                    ),
                    Text(_releaseNotes ?? ""),
                  ],
                ),
                SizedBox(
                  height: 15.h,
                ),
              ],
            ),
            actions: [
              ElevatedButton(
                onPressed: () async {
                  await launch(_appUrl);
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.w),
                  child: const Text("Update Now"),
                ),
              )
            ],
          ),
        );
      },
      animationType: DialogTransitionType.size,
      curve: Curves.fastOutSlowIn,
    );
  }
}
