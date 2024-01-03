import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_interval_timer/presentation/pages/pages.dart';

import '../../domain/blocs/blocs.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  static MaterialPageRoute getRoute({Key? key}) {
    return MaterialPageRoute(builder: (context) => SplashScreen(key: key));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SettingsCubit, SettingsState>(
      listenWhen: (oldState, state) =>
          !oldState.isInitialized && state.isInitialized,
      listener: (context, state) {
        Future.delayed(
          Duration(seconds: 2),
          () => Navigator.of(context)
              .pushReplacement(SessionOverviewPage.getRoute()),
        );
      },
      child: Scaffold(
        body: Image.asset(
          "assets/poop_ring.png",
          fit: BoxFit.contain,
          height: double.infinity,
          width: double.infinity,
          alignment: Alignment.center,
        ),
      ),
    );
  }
}
