import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_interval_timer/core/theme/theme_constants.dart';
import 'package:simple_interval_timer/data/datasources/local/database.dart';
import 'package:simple_interval_timer/domain/blocs/session_database_cubit.dart';
import 'package:simple_interval_timer/presentation/pages/session_overview_page.dart';

void main() {
  runApp(const SimpleIntervalTimerApp());
}

class SimpleIntervalTimerApp extends StatelessWidget {
  final String title = "SHIT - Simple Helpful Interval Timer";
  const SimpleIntervalTimerApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SessionDatabaseCubit(SessionDatabase()),
      child: Builder(
        builder: (context) => MaterialApp(
          title: title,
          theme: theme,
          home: HomePage(title),
        ),
      ),
    );
  }
}

class HomePage extends StatelessWidget{
  final String title;
  const HomePage(this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: StandardComponents.getAppBar(context, title),
      body: FutureBuilder(
        future: context
            .read<SessionDatabaseCubit>()
            .sessionRepository
            .getSessions(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return SessionOverviewPage(snapshot.requireData);
          }
          return const CircularProgressIndicator();
        },
      ),
    );
  }

}
