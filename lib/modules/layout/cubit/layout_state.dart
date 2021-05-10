part of 'layout_cubit.dart';

class LayoutState {
  final int tab;
  final Widget screen;

  LayoutState({@required this.tab, this.screen});

  factory LayoutState.initial() {
    return LayoutState(tab: 0);
  }

  factory LayoutState.changing({@required int tab, @required Widget screen}) {
    return LayoutState(
      tab: tab,
      screen: screen,
    );
  }

  @override
  String toString() => 'LayoutState(tab: $tab, screen: $screen)';
}
