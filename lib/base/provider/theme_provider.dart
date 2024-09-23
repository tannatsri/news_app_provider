import 'package:flutter/cupertino.dart';
import 'package:news_app/base/provider/storage_provider.dart';

class ThemeProvider extends ChangeNotifier {
  bool isLightTheme = true;

  final StorageAssistantProvider storageAssistantProvider;

  ThemeProvider({
    required this.storageAssistantProvider,
  });

  void toggleTheme() {
    isLightTheme = !isLightTheme;
    storageAssistantProvider
        .saveJson("theme", {'is_light_theme': isLightTheme});
    notifyListeners();
  }
  void initialize()async {
    final data = await storageAssistantProvider.fetchJson('theme');
    isLightTheme = data?['is_light_theme'] ?? true;
  }

  String getThemeBasedColor(BaseColorEnum color) {
    return (isLightTheme) ? color.lightCode : color.darkCode;
  }
}

enum BaseColorEnum {
  primaryBackgroundColor(lightCode: "#f7f7f7", darkCode: "#0C0C0C"),
  primaryComponentBackgroundColor(lightCode: "#ffffff", darkCode: "#161616"),
  primaryTextBgColor(lightCode: "#191c1e", darkCode: "#FFFFFE"),
  secondaryTextBgColor(lightCode: "#757778", darkCode: "#C0C2C6"),
  tertiaryTextBgColor(lightCode: "#bdbdbd", darkCode: "#A0A0A0")
  ;

  const BaseColorEnum({
    required this.lightCode,
    required this.darkCode,
  });

  final String lightCode;
  final String darkCode;
}
