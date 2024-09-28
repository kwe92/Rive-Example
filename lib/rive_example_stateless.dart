import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class RiveExampleStateless extends StatelessWidget {
  const RiveExampleStateless({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Rive Example',
          style: TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: const RiveAnimation.asset(
        'assets/rive/dash.riv',
        fit: BoxFit.contain,
      ),
    );
  }
}
