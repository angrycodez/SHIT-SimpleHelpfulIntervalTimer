import 'package:flutter/material.dart';
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
          IconButton(onPressed: () => session.addInterval(), icon: MyIcons.createNewIntervalIcon,),
          IconButton(onPressed: () => session.addBlock(), icon: MyIcons.createNewBlockIcon,),
        ],
      ),
    );
  }
}
