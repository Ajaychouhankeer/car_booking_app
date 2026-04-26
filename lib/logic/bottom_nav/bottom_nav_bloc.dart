import 'package:flutter_bloc/flutter_bloc.dart';

import 'bottom_nav_event.dart';
import 'bottom_nav_state.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'bottom_nav_event.dart';
import 'bottom_nav_state.dart';

class BottomNavBloc extends Bloc<BottomNavEvent, BottomNavState> {

  BottomNavBloc() : super(BottomNavState.initial()) {

    /// 🔹 TAB CHANGE
    on<ChangeTabEvent>((event, emit) {

      final newHistory = List<int>.from(state.history);

      if (newHistory.isEmpty || newHistory.last != event.index) {
        newHistory.add(event.index);
      }

      emit(state.copyWith(
        currentIndex: event.index,
        history: newHistory,
      ));
    });

    /// 🔹 BACK TAB
    on<BackTabEvent>((event, emit) {

      final newHistory = List<int>.from(state.history);

      if (newHistory.length > 1) {
        newHistory.removeLast();

        emit(state.copyWith(
          currentIndex: newHistory.last,
          history: newHistory,
        ));
      }
    });

    on<ResetTabEvent>((event, emit) {
      emit(BottomNavState(
        currentIndex: event.index,
        history: [event.index], // 👈 IMPORTANT
      ));
    });

  }
}

// class BottomNavBloc extends Bloc<BottomNavEvent, BottomNavState> {
//
//   BottomNavBloc() : super(BottomNavState(0)) {
//
//     on<ChangeTabEvent>((event, emit) {
//       emit(BottomNavState(event.index));
//     });
//
//   }
// }