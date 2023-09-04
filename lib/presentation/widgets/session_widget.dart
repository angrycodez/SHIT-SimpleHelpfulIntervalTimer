import 'package:flutter/material.dart';
import 'package:simple_interval_timer/core/theme/theme_constants.dart';
import 'package:simple_interval_timer/data/models/models.dart';

import '../pages/session_page.dart';

class SessionWidget extends StatelessWidget {
  final Session session;
  const SessionWidget(this.session, {super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(
        SessionPage.getRoute(
          session,
          key: Key(session.id),
        ),
      ),
      child: Container(
        margin: Layout.cardMargin,
        padding: Layout.cardPadding,
        decoration: MyDecoration.cardDecoration(context),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(session.name),
            Text(session.duration.toString()),
            IconButton(
              onPressed: () {},
              icon: MyIcons.startSessionIcon,
            ),
          ],
        ),
      ),
    );
  }
}
