import 'package:flutter/material.dart';

import '../../presentation/pages/pages.dart';

class Layout {
  static const double defaultSize = 15;
  static const double bigSize = 18;
  static const double hugeSize = 25;
  static const double hugeIconSize = 38;

  static const Radius defaultBorderRadius = Radius.circular(5);


  static const double defaultSpace = 5;
  static const double defaultHorizontalSpace = 10;
  static const double defaultVerticalSpace = 5;
  static const EdgeInsets cardPadding = EdgeInsets.only(left: defaultHorizontalSpace, right: defaultHorizontalSpace, top: defaultVerticalSpace, bottom: defaultVerticalSpace);
  static const EdgeInsets sessionBlockPadding = EdgeInsets.only(left: defaultSpace, top: defaultSpace, bottom: defaultSpace);
  static const EdgeInsets cardMargin = EdgeInsets.all(defaultSpace);
  static const EdgeInsets defaultVerticalSpacing = EdgeInsets.only(top: defaultSpace, bottom: defaultSpace);
  static const EdgeInsets defaultContentMargin = EdgeInsets.all(defaultSpace * 1.5);
  static const EdgeInsets defaultPageContentMargin = EdgeInsets.only(left: defaultHorizontalSpace, top: defaultVerticalSpace, right: defaultHorizontalSpace);
  static const EdgeInsets sessionBlockChildMargin = EdgeInsets.only(left: defaultHorizontalSpace);
  static const double borderWidth = 2.0;
  static const double durationFieldWidth = 50.0;
  static const double timerCircularStrokeWidth = 20.0;
}
class MyFonts {
  static const double defaultFontSize = 15;
  static const double bigFontSize = 18;
  static const double hugeFontSize = 25;
}
class MyColors {
  static const Color cardEditBorderColor = Colors.black54;
  static const Color cardBorderColor = Colors.grey;
  static Color cardBackgroundColor = Colors.blueGrey.withOpacity(0.5);
  static Color lightCardBackgroundColor = Colors.grey.withOpacity(0.6);
  static Color sessionBlockBackgroundColor = Colors.grey.withOpacity(0.2);
  static const Color errorColor = Colors.red;
}

class MyIcons {
  static const Icon startSessionIcon = Icon(Icons.play_arrow);
  static const Icon playIcon = Icon(Icons.play_arrow);
  static const Icon pauseIcon = Icon(Icons.pause_rounded);
  static const Icon workIcon = Icon(Icons.work_outline);
  static const Icon moveUpIcon = Icon(Icons.arrow_upward);
  static const Icon moveDownIcon = Icon(Icons.arrow_downward);
  static const Icon createNewSessionIcon = Icon(Icons.add);
  static const Icon createNewIntervalIcon = Icon(Icons.add_alarm);
  static const Icon createNewBlockIcon = Icon(Icons.add_comment_outlined);
  static const Icon editIcon = Icon(Icons.edit);
  static const Icon settingsIcon = Icon(Icons.settings);
  static const Icon navigateMenuIcon = Icon(Icons.chevron_right);
  static const Icon nextIntervalIcon = Icon(Icons.account_tree);
  static const Icon addSoundIcon = Icon(Icons.add_alarm);
  static const Icon soundIcon = Icon(Icons.music_note_outlined);
  static const Icon soundPreviewIcon = Icon(Icons.volume_up_outlined);
  static const Icon restartIntervalIcon = Icon(Icons.restart_alt);
  static const Icon stopIntervalIcon = Icon(Icons.stop);
  static const Icon skipIntervalIcon = Icon(Icons.skip_next);
  static const Icon durationIcon = Icon(Icons.timer_outlined);
  static const Icon sessionIntervalIcon = Icon(Icons.query_builder);
  static const Icon sessionBlockIcon = Icon(Icons.repeat_outlined);
  static const Icon cancelIcon = Icon(Icons.cancel_outlined);
  static const Icon acceptIcon = Icon(Icons.check_circle_outlined);
  static const Icon deleteIcon = Icon(
    Icons.delete_forever,
    color: Colors.red,
  );
}

ThemeData get theme => ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      useMaterial3: true,
      cardColor: Colors.grey,
      iconTheme: const IconThemeData(size: Layout.bigSize),
  textTheme: const TextTheme(
    displayLarge: TextStyle(fontSize: MyFonts.hugeFontSize, fontWeight: FontWeight.bold),
    displayMedium: TextStyle(fontSize: MyFonts.bigFontSize, fontWeight: FontWeight.bold),
    displaySmall: TextStyle(fontSize: MyFonts.defaultFontSize),

    labelLarge: TextStyle(fontSize: MyFonts.hugeFontSize),
    labelMedium: TextStyle(fontSize: MyFonts.bigFontSize),
    labelSmall: TextStyle(fontSize: MyFonts.defaultFontSize),

  ),
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
      borderRadius: const BorderRadius.all(Layout.defaultBorderRadius),
      border: borderColor != null
          ? Border.all(
              color: borderColor,
              width: Layout.borderWidth,
            )
          : null,
    );
  }
}
