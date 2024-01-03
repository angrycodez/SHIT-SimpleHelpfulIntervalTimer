import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_interval_timer/core/theme/theme_constants.dart';
import 'package:simple_interval_timer/data/datasources/local/database.dart';
import 'package:simple_interval_timer/domain/blocs/session_database_cubit.dart';
import 'package:simple_interval_timer/domain/blocs/settings_cubit.dart';
import 'package:simple_interval_timer/domain/blocs/timer_cubit.dart';
import 'package:simple_interval_timer/presentation/pages/pages.dart';
import 'package:simple_interval_timer/presentation/pages/session_overview_page.dart';
import 'package:window_manager/window_manager.dart';

import 'core/helper/platform.dart';

void main() {
  runApp(const SimpleIntervalTimerApp());
  if (isDesktop()) {
    windowManager.setSize(const Size(420, 620));
  }
}

class SimpleIntervalTimerApp extends StatelessWidget {
  static const String title = "SHIT - Simple Helpful Interval Timer";
  const SimpleIntervalTimerApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => SessionDatabaseCubit(SessionDatabase())),
        BlocProvider(create: (_) => TimerCubit()),
        BlocProvider(
          create: (context) =>
              SettingsCubit(context.read<SessionDatabaseCubit>()),
        ),
      ],
      child: Builder(
        builder: (context) => MaterialApp(
          title: title,
          theme: theme,
          home: const HomePage(title),
        ),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  final String title;
  const HomePage(this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    return const SplashScreen();
  }
}
