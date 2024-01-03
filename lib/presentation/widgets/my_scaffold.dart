
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_interval_timer/domain/blocs/timer_cubit.dart';
import 'package:simple_interval_timer/presentation/widgets/timer_bar.dart';

class MyScaffold extends StatelessWidget{
  final AppBar appBar;
  final Widget body;

  const MyScaffold({required this.appBar, required this.body, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: Column(
        children: [
          _timerBar(),
          Expanded(child: body),
        ],
      ),
    );
  }

  Widget _timerBar(){
    return BlocBuilder<TimerCubit, TimerState>(
        builder: (context, state){
          if(state is! TimerStateLoaded || !state.isTicking){
            return const SizedBox.shrink();
          }
          return TimerBar(timerState: state);
        }
    );
  }

}