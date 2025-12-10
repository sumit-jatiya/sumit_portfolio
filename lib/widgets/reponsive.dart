import 'package:flutter/material.dart';

enum ScreenType { mobile, tablet, desktop }

ScreenType getScreenType(double width) {
  if (width < 600) {
    return ScreenType.mobile;
  } else if (width < 1000) {
    return ScreenType.tablet;
  } else {
    return ScreenType.desktop;
  }
}

class ResponsiveScreen extends StatelessWidget {
  const ResponsiveScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final screenType = getScreenType(width);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Responsive Screen"),
      ),
      body: Center(
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: _buildUI(screenType),
        ),
      ),
    );
  }

  Widget _buildUI(ScreenType type) {
    switch (type) {
      case ScreenType.mobile:
        return _mobileUI();
      case ScreenType.tablet:
        return _tabletUI();
      case ScreenType.desktop:
        return _desktopUI();
    }
  }

  // 📱 Mobile UI
  Widget _mobileUI() {
    return Container(
      key: const ValueKey("mobile"),
      padding: const EdgeInsets.all(20),
      child: const Text(
        "Mobile View",
        style: TextStyle(fontSize: 20, color: Colors.blue),
      ),
    );
  }

  // 📟 Tablet UI
  Widget _tabletUI() {
    return Container(
      key: const ValueKey("tablet"),
      padding: const EdgeInsets.all(30),
      child: const Text(
        "Tablet View",
        style: TextStyle(fontSize: 24, color: Colors.green),
      ),
    );
  }

  // 🖥 Desktop UI
  Widget _desktopUI() {
    return Container(
      key: const ValueKey("desktop"),
      padding: const EdgeInsets.all(40),
      child: const Text(
        "Desktop View",
        style: TextStyle(fontSize: 28, color: Colors.red),
      ),
    );
  }
}
