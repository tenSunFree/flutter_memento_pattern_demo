import 'home_state.dart';

class HomeMemento {
  late final HomeState _state;

  HomeMemento(HomeState state) {
    _state = HomeState.copy(state);
  }

  HomeState getState() {
    return _state;
  }
}
