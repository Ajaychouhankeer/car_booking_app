abstract class BottomNavEvent {}

class ChangeTabEvent extends BottomNavEvent {
  final int index;

  ChangeTabEvent(this.index);
}

class BackTabEvent extends BottomNavEvent {}

class ResetTabEvent extends BottomNavEvent {
  final int index;
  ResetTabEvent(this.index);
}