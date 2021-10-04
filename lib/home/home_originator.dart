import 'package:flutter_memento_pattern_demo/home/home_memento.dart';
import 'home_state.dart';

class HomeOriginator {
  late HomeState state;

  HomeOriginator() {
    state = HomeState.initial();
  }

  HomeMemento createMemento() {
    return HomeMemento(state);
  }

  void restore(HomeMemento memento) {
    state = memento.getState();
  }
}
