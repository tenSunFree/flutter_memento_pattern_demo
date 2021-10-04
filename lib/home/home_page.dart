import 'package:flutter/material.dart';
import 'package:flutter_memento_pattern_demo/common/util/custom_scroll_behavior.dart';
import 'package:flutter_memento_pattern_demo/home/home_caretaker.dart';

class HomePage extends StatefulWidget {
  const HomePage();

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeCaretaker _caretaker = HomeCaretaker();

  void execute() {
    setState(() {
      _caretaker.execute();
    });
  }

  void _undo() {
    setState(() {
      _caretaker.undo();
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_caretaker.originator.state.step == 0) {
          return true;
        } else {
          _undo();
          return false;
        }
      },
      child: Scaffold(body: buildStack()),
    );
  }

  Stack buildStack() {
    return Stack(children: <Widget>[
      Container(
        color: const Color(0xFF131313),
        child: Column(children: <Widget>[
          buildExpanded(4),
          Align(
              alignment: Alignment.centerLeft,
              child: Container(
                  margin: EdgeInsets.only(left: 16),
                  child: Text(_caretaker.originator.state.title,
                      style: TextStyle(color: Colors.white, fontSize: 25)))),
          buildExpanded(2),
          buildListView(),
          buildExpanded(1),
          buildContinueButton(),
          buildExpanded(2),
        ]),
      ),
      buildUndoButton(),
    ]);
  }

  Widget buildUndoButton() {
    return _caretaker.history.isEmpty
        ? Container()
        : Positioned(
            top: 40,
            left: 16,
            child: GestureDetector(
                child: Icon(Icons.arrow_back_outlined, color: Colors.white),
                onTap: () {
                  _undo();
                }),
          );
  }

  ScrollConfiguration buildListView() {
    return ScrollConfiguration(
        behavior: CustomScrollBehavior(),
        child: ListView.builder(
            shrinkWrap: true,
            itemCount: _caretaker.originator.state.list.length,
            itemBuilder: (context, index) {
              return buildListViewItem(index);
            }));
  }

  Expanded buildExpanded(int flex) {
    return Expanded(
      child: SizedBox(),
      flex: flex,
    );
  }

  StatelessWidget buildContinueButton() {
    return !_caretaker.history.isMax
        ? GestureDetector(
            child: Container(
                margin: EdgeInsets.only(left: 16, bottom: 40, right: 16),
                alignment: Alignment(0, 0),
                height: 50,
                width: 300,
                decoration: new BoxDecoration(
                  gradient: _caretaker.originator.state.isNoSelected()
                      ? LinearGradient(colors: [
                          Color(0xFF421D1D),
                          Color(0xFF421D1D),
                          Color(0xFF421D1D)
                        ])
                      : LinearGradient(colors: [
                          Color(0xFFFF4444),
                          Color(0xFFFF4444),
                          Color(0xFFFF4444)
                        ]),
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
                child: Text('繼續',
                    style: TextStyle(
                        color: _caretaker.originator.state.isNoSelected()
                            ? Color(0xFF565050)
                            : Colors.white))),
            onTap: () {
              if (!_caretaker.originator.state.isNoSelected()) execute();
            },
          )
        : Container(
            height: 50,
            width: 300,
            margin: EdgeInsets.only(left: 16, bottom: 40, right: 16),
          );
  }

  GestureDetector buildListViewItem(int index) {
    return GestureDetector(
      child: Container(
        margin: EdgeInsets.only(left: 16, bottom: 40, right: 16),
        alignment: Alignment(0, 0),
        height: 50,
        width: double.infinity,
        decoration: new BoxDecoration(
            gradient: _caretaker.originator.state.list[index].isSelected
                ? LinearGradient(colors: [
                    Color(0xFFF3D6BD),
                    Color(0xFFE3DDD3),
                    Color(0xFFCAE8F7)
                  ])
                : LinearGradient(colors: [
                    Color(0xFF282828),
                    Color(0xFF282828),
                    Color(0xFF282828)
                  ]),
            borderRadius: BorderRadius.all(Radius.circular(12))),
        child: Text('${_caretaker.originator.state.list[index].text}',
            style: TextStyle(
                color: _caretaker.originator.state.list[index].isSelected
                    ? Colors.black
                    : Colors.white)),
      ),
      onTap: () {
        setState(() {
          _caretaker.originator.state.list[index].isSelected =
              !_caretaker.originator.state.list[index].isSelected;
        });
      },
    );
  }
}
