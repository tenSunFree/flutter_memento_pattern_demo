import 'package:flutter_memento_pattern_demo/home/home_command.dart';
import 'package:flutter_memento_pattern_demo/home/home_history.dart';
import 'package:flutter_memento_pattern_demo/home/home_originator.dart';

class HomeCaretaker {
  final HomeOriginator originator = HomeOriginator();
  final HomeHistory history = HomeHistory();

  void execute() {
    final command = HomeCommand(originator);
    command.execute();
    history.add(command);
  }

  void undo() {
    history.undo();
  }
}
