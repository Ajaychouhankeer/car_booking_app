// class BottomNavState {
//   final int currentIndex;
//
//   BottomNavState(this.currentIndex);
// }

class BottomNavState {
  final int currentIndex;
  final List<int> history;

  BottomNavState({
    required this.currentIndex,
    required this.history,
  });

  factory BottomNavState.initial() {
    return BottomNavState(
      currentIndex: 0,
      history: [0],
    );
  }

  BottomNavState copyWith({
    int? currentIndex,
    List<int>? history,
  }) {
    return BottomNavState(
      currentIndex: currentIndex ?? this.currentIndex,
      history: history ?? this.history,
    );
  }
}