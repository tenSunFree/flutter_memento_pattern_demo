import 'package:flutter_memento_pattern_demo/home/home_memento.dart';
import 'package:flutter_memento_pattern_demo/home/home_state.dart';
import 'home_originator.dart';

class HomeCommand {
  final HomeOriginator _originator;
  late final HomeMemento _memento;

  HomeCommand(this._originator) {
    _memento = _originator.createMemento();
  }

  void execute() {
    final state = _originator.state;
    switch (state.step) {
      case 0:
        state.step = 1;
        state.title = '選擇你想聽的內容語言';
        state.list = [
          HomeStateItem(text: 'English'),
          HomeStateItem(text: '日本語'),
          HomeStateItem(text: '简体中文')
        ];
        break;
      case 1:
        state.step = 2;
        state.title = '選擇你使用的頻率';
        state.list = [
          HomeStateItem(text: '每週1天'),
          HomeStateItem(text: '每週3天'),
          HomeStateItem(text: '每週7天')
        ];
        break;
    }
  }

  void undo() {
    _originator.restore(_memento);
  }
}
