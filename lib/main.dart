import 'package:flutter/material.dart';
import 'package:rive_example/rive_example_state_machine.dart';
import 'package:rive_example/rive_example_stateless.dart';

// flutter run --dart-define=shouldRunStateMachineExample=true

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    // false if no --dart-define=shouldRunStateMachineExample=true is passed when calling flutter run
    // can also just switch the default value and hot reload
    const shouldRunStateMachineExample = bool.fromEnvironment('shouldRunStateMachineExample', defaultValue: false);

    debugPrint('should run state machine example: $shouldRunStateMachineExample\n');
    return const MaterialApp(
      home: shouldRunStateMachineExample ? RiveExampleStateMachine() : RiveExampleStateless(),
    );
  }
}
