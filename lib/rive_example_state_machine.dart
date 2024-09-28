import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rive/rive.dart';

class RiveExampleStateMachine extends StatefulWidget {
  const RiveExampleStateMachine({super.key});

  @override
  State<RiveExampleStateMachine> createState() => _RiveExampleStateMachineState();
}

class _RiveExampleStateMachineState extends State<RiveExampleStateMachine> {
  Artboard? riveArtBoard;

  SMIBool? shouldDance;

  SMITrigger? shouldLookUp;

  @override
  void initState() {
    super.initState();
    rootBundle.load('assets/rive/dash.riv').then((data) async {
      try {
        // when using RiveFile.import then RiveFile.initialize() should be called manually.
        await RiveFile.initialize();

        // load rive file from binary data (bytes of data) retrieved from the rive animation
        final riveFile = RiveFile.import(data);

        //  the art board is the root of the animation, extracted fro mthe rive file
        final artBoard = riveFile.mainArtboard;

        // create state machine controller from the extracted artboard
        final controller = StateMachineController.fromArtboard(artBoard, 'birb');

        // add controller to the artboard
        if (controller != null) {
          debugPrint('adding state machine controller\n');

          artBoard.addController(controller);

          // find the type of action you want to perform from the StateMachineController

          //   - the action could be null and may need to be set first client side

          shouldDance = controller.findSMI('dance');

          // shouldLookUp = controller.findSMI('look up');

          shouldLookUp = controller.getTriggerInput('look up');

          for (var input in controller.inputs) {
            debugPrint('input name: ${input.name}');
            debugPrint('input type: ${input.runtimeType}');
            debugPrint('input value: ${input.value}\n');
          }

          // update artboard variable for this widget
          riveArtBoard = artBoard;

          notifyWidget();
        }
      } catch (err, _) {
        debugPrint('ERROR: ${err.toString()}');
      }
    });
  }

  /// notifies widget about updates to its state
  void notifyWidget() => setState(() {});

  void toogleDance(bool value) {
    shouldDance?.value = value;
    notifyWidget();
  }

  void toogleLookUp() {
    shouldLookUp?.value = true;

    debugPrint('should look up: ${shouldLookUp?.value}\n');

    notifyWidget();
  }

  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w600,
      color: Colors.black,
    );
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        surfaceTintColor: Colors.transparent,
        shadowColor: const Color(0xff00eaff),
        title: const Text(
          'Rive State Machine',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
      body: riveArtBoard == null
          ? const SizedBox()
          : Column(
              children: [
                Flexible(
                  flex: 2,
                  child: Rive(
                    artboard: riveArtBoard!,
                  ),
                ),
                Flexible(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Do The Dash!',
                        style: textStyle,
                      ),
                      const SizedBox(width: 6),
                      Switch.adaptive(
                        value: shouldDance?.value ?? false,
                        onChanged: toogleDance,
                        activeColor: const Color(0xff00eaff),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: toogleLookUp,
                  child: const Text(
                    'Look to The Sky!',
                    style: textStyle,
                  ),
                ),
              ],
            ),
    );
  }
}
