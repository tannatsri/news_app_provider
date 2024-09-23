import 'package:flutter/material.dart';
import 'package:news_app/base/provider/theme_provider.dart';

import 'base_text_widget.dart';

class BaseAppBar extends StatelessWidget implements PreferredSizeWidget {
  final ThemeProvider themeProvider;
  final bool showBack;

  const BaseAppBar({
    required this.themeProvider,
    this.showBack = true,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      surfaceTintColor: HexColor(themeProvider
          .getThemeBasedColor(BaseColorEnum.primaryBackgroundColor)),
      backgroundColor: HexColor(themeProvider
          .getThemeBasedColor(BaseColorEnum.primaryBackgroundColor)),
      leading: (showBack)
          ? IconButton(
              color: (!themeProvider.isLightTheme)
                  ? HexColor("#ffffff")
                  : HexColor("#191c1f"),
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back_ios),
            )
          : null,
      actions: [
        if (themeProvider.isLightTheme)
          IconButton(
            onPressed: () {
              themeProvider.toggleTheme();
            },
            icon: const Icon(Icons.sunny),
          ),
        if (!themeProvider.isLightTheme)
          IconButton(
            color: HexColor("#ffffff"),
            onPressed: () {
              themeProvider.toggleTheme();
            },
            icon: const Icon(Icons.wb_sunny_outlined),
          )
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
