import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_interval_timer/core/theme/theme_constants.dart';
import 'package:simple_interval_timer/data/models/models.dart';

import '../../domain/blocs/blocs.dart';

class SessionEditControlsWidget extends StatelessWidget {
  SessionCubit session;

  SessionEditControlsWidget(this.session, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(onPressed: () => _deleteSession(context), icon: MyIcons.deleteIcon,),
          IconButton(onPressed: () => session.addInterval(context), icon: MyIcons.createNewIntervalIcon,),
          IconButton(onPressed: () => session.addBlock(), icon: MyIcons.createNewBlockIcon,),
        ],
      ),
    );
  }

  void _deleteSession(BuildContext context){
    Navigator.of(context).pop();
    session.deleteSession();
  }
}
