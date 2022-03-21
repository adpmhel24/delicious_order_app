import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../widget/custom_updater_dialog.dart';
import '/global_bloc/app_init_bloc/bloc.dart';
import 'bloc/bloc.dart';
import 'components/add_url_dialog.dart';
import 'components/login_body.dart';
import '/widget/custom_error_dialog.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key, this.onLoginCallback}) : super(key: key);

  final Function(bool loggedIn)? onLoginCallback;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LoginBloc(),
        ),
        BlocProvider(
          create: (context) => AppInitBloc()..add(OpeningApp()),
        ),
      ],
      child: Builder(
        builder: (BuildContext builderContext) {
          return BlocConsumer<AppInitBloc, AppInitState>(
            listener: (_, state) {
              context.loaderOverlay.hide();
              if (state is NoURLState) {
                showAnimatedDialog(
                  context: context,
                  builder: (_) {
                    return WillPopScope(
                      onWillPop: () async => false,
                      child: AddUrlDialog(
                        loginContext: builderContext,
                      ),
                    );
                  },
                  animationType: DialogTransitionType.size,
                  curve: Curves.fastOutSlowIn,
                );
              } else if (state is CheckingUpdate) {
                context.loaderOverlay.show();
              } else if (state is NewUpdateAvailable) {
                context.loaderOverlay.hide();
                NewUpdate.displayAlert(
                  context,
                  appName: state.devicePackageInfo.appName,
                  message: const Text(
                      "A version of Delicious Ordering App is available! "),
                  appUrl:
                      "https://github.com/adpmhel24/delicious_order_app/releases/download/v1.0.${state.availableVersion.buildNumber}/app-release.apk",
                  releaseNotes: state.availableVersion.releaseNotes,
                );
              } else if (state is Error) {
                customErrorDialog(context,
                    barrierDismissible: false,
                    message: state.message, onPositiveClick: () {
                  SystemNavigator.pop();
                });
              } else if (state is NoUpdateAvailable) {
                context.loaderOverlay.hide();
              }
            },
            builder: (_, state) => BlocListener<LoginBloc, LoginState>(
              listener: (context, state) {
                if (state.status.isSubmissionSuccess) {
                  context.loaderOverlay.hide();
                  onLoginCallback?.call(true);
                } else if (state.status.isSubmissionFailure) {
                  customErrorDialog(context, message: state.message);
                } else if (state.status.isSubmissionInProgress) {
                  context.loaderOverlay.show();
                }
              },
              child: const LoginBody(),
            ),
          );
        },
      ),
      // child: const LoginBody(),
    );
  }
}
