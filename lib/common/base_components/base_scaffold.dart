import 'package:flutter/material.dart';

class BaseScaffold extends StatelessWidget {
  final Widget? child;
  final PreferredSizeWidget? appBar;
  const BaseScaffold({
     this.child,
     this.appBar,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: appBar,
        body: child,
      ),
    );
  }
}
