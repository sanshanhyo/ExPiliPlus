import 'package:ex_piliplus/pages/main/view.dart';
import 'package:ex_piliplus/pages/onboarding/view.dart';
import 'package:ex_piliplus/utils/storage_pref.dart';
import 'package:flutter/material.dart';

class RootPage extends StatefulWidget {
  const RootPage({super.key});

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  late int _onboardingVersion = Pref.onboardingVersion;

  void _handleOnboardingFinished() {
    if (!mounted) return;
    setState(() {
      _onboardingVersion = Pref.onboardingVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _onboardingVersion >= 1
        ? const MainApp()
        : OnboardingPage(onFinished: _handleOnboardingFinished);
  }
}
