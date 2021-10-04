class HomeState {
  late int step;
  late String title;
  late List<HomeStateItem> list;

  HomeState(this.step, this.title, this.list);

  HomeState.initial() {
    step = 0;
    title = '探索感興趣的主題';
    list = [
      HomeStateItem(text: '商業財經'),
      HomeStateItem(text: '認知思維'),
      HomeStateItem(text: '歷史文化')
    ];
  }

  bool isNoSelected() {
    bool isNoSelected = true;
    list.forEach((item) {
      if (item.isSelected) isNoSelected = false;
    });
    return isNoSelected;
  }

  HomeState.copy(HomeState shape) : this(shape.step, shape.title, shape.list);
}

class HomeStateItem {
  late String text;
  late bool isSelected;

  HomeStateItem({this.text = "", this.isSelected = false});
}
