import 'package:flutter/material.dart';

import '../../presentation/pages/pages.dart';

class Layout {
  static const EdgeInsets cardPadding = EdgeInsets.all(10);
  static const EdgeInsets cardMargin = EdgeInsets.all(10);
  static const double borderWidth = 2.0;
  static const double durationFieldWidth = 50.0;
}

class MyColors {
  static const Color cardEditBorderColor = Colors.amber;
  static const Color cardBorderColor = Colors.grey;
  static const Color errorColor = Colors.red;
}

class MyIcons {
  static const Icon startSessionIcon = Icon(Icons.play_arrow);
  static const Icon pauseIcon = Icon(Icons.pause);
  static const Icon workIcon = Icon(Icons.work);
  static const Icon moveUpIcon = Icon(Icons.arrow_upward);
  static const Icon moveDownIcon = Icon(Icons.arrow_downward);
  static const Icon createNewSessionIcon = Icon(Icons.add);
  static const Icon createNewIntervalIcon = Icon(Icons.add_alarm);
  static const Icon createNewBlockIcon = Icon(Icons.add_comment_outlined);
  static const Icon editOnIcon = Icon(Icons.edit);
  static const Icon editOffIcon = Icon(Icons.edit_off);
  static const Icon settingsIcon = Icon(Icons.settings);
  static const Icon navigateMenuIcon = Icon(Icons.chevron_right);
  static const Icon addSoundIcon = Icon(Icons.add_alarm);
  static const Icon soundIcon = Icon(Icons.music_note_outlined);
  static const Icon deleteIcon = Icon(
    Icons.delete_forever,
    color: Colors.red,
  );
}

ThemeData get theme => ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      useMaterial3: true,
      cardColor: Colors.grey,
    );

class StandardComponents {
  static AppBar getAppBar(BuildContext context, String title) {
    return AppBar(
      title: Text(title),
      backgroundColor: Theme.of(context).primaryColor,
      actions: [
        IconButton(
          onPressed: () => Navigator.of(context).push(SettingsPage.getRoute()),
          icon: MyIcons.settingsIcon,
        ),
      ],
    );
  }
}

class MyDecoration {
  static BoxDecoration cardDecoration(BuildContext context,
      {Color? color, Color? borderColor}) {
    ThemeData theme = Theme.of(context);
    return BoxDecoration(
      color: color ?? theme.cardColor,
      borderRadius: const BorderRadius.all(Radius.circular(5)),
      border: borderColor != null
          ? Border.all(
              color: borderColor,
              width: Layout.borderWidth,
            )
          : null,
    );
  }
}
