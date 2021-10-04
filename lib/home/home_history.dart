import 'dart:collection';
import 'package:flutter_memento_pattern_demo/home/home_command.dart';

class HomeHistory {
  final ListQueue<HomeCommand> _list = ListQueue<HomeCommand>();

  bool get isEmpty => _list.isEmpty;

  bool get isMax => _list.length == 2;

  void add(HomeCommand command) {
    _list.add(command);
  }

  void undo() {
    if (_list.isNotEmpty) {
      final command = _list.removeLast();
      command.undo();
    }
  }
}
