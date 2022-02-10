import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import '/global_bloc/app_init_bloc/bloc.dart';
import 'bloc/bloc.dart';
import 'components/add_url_dialog.dart';
import 'components/login_body.dart';
import '/widget/custom_loading_dialog.dart';
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
              if (state is NoURLState) {
                showAnimatedDialog(
                  context: context,
                  builder: (_) {
                    return AddUrlDialog(
                      loginContext: builderContext,
                    );
                  },
                  animationType: DialogTransitionType.size,
                  curve: Curves.fastOutSlowIn,
                );
              }
            },
            builder: (_, state) => BlocListener<LoginBloc, LoginState>(
              listener: (context, state) {
                if (state.status.isSubmissionSuccess) {
                  onLoginCallback?.call(true);
                } else if (state.status.isSubmissionFailure) {
                  customErrorDialog(context, state.message);
                } else if (state.status.isSubmissionInProgress) {
                  customLoadingDialog(context);
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
