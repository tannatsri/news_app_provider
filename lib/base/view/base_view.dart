import 'package:flutter/material.dart';
import 'package:news_app/base/provider/network_provider.dart';
import 'package:news_app/base/provider/storage_provider.dart';
import 'package:news_app/base/provider/theme_provider.dart';
import 'package:provider/provider.dart';

import 'base_view_controller.dart';

abstract class IView<T extends IViewController> extends StatelessWidget {
  const IView({super.key});

  T createViewController(
    BuildContext context,
    NetworkAssistantProvider apiProvider,
    StorageAssistantProvider storageProvider,
  );

  Widget buildView(BuildContext context, ThemeProvider themeProvider);

  @override
  Widget build(BuildContext context) {
    final networkAssistantProvider =
        Provider.of<NetworkAssistantProvider>(context, listen: false);
    final storageProvider =
        Provider.of<StorageAssistantProvider>(context, listen: false);
    return ChangeNotifierProvider<T>(
      create: (_) => createViewController(
        context,
        networkAssistantProvider,
        storageProvider,
      )..initialize(),
      child: Consumer(
        builder: (BuildContext context, ThemeProvider value, Widget? child) {
          return buildView(
            context,
            Provider.of<ThemeProvider>(context, listen: false),
          );
        },
      ),
    );
  }
}
