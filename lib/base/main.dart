import 'package:flutter/material.dart';
import 'package:news_app/base/provider/network_provider.dart';
import 'package:news_app/base/provider/storage_provider.dart';
import 'package:news_app/base/provider/theme_provider.dart';
import 'package:provider/provider.dart';

import 'base_app.dart';

class BaseMainApp extends StatelessWidget {
  const BaseMainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => StorageAssistantProvider(),
      lazy: false,
      child: const MultiProviderApp(),
    );
  }
}

class MultiProviderApp extends StatelessWidget {
  const MultiProviderApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ThemeProvider(
            storageAssistantProvider: Provider.of<StorageAssistantProvider>(
              context,
              listen: false,
            ),
          )..initialize(),
        ),
        ChangeNotifierProvider(
          create: (_) => NetworkAssistantProvider(),
        )
      ],
      child: const BaseApp(),
    );
  }
}
