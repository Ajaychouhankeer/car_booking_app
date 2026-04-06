part of 'theme_bloc.dart';

class ThemeEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadList extends ThemeEvent {}

class LoadTheme extends ThemeEvent {}

class ToggleTheme extends ThemeEvent {
  final String theme;
  ToggleTheme({required this.theme});

  @override
  List<Object?> get props => [theme];
}

class ThemeApply extends ThemeEvent {}
class ThemeChangeHideAmount extends ThemeEvent {}

class ToggleSelfInvestorMode extends ThemeEvent{
  final bool isSelfMode;
  ToggleSelfInvestorMode({required this.isSelfMode});
  @override
  List<Object?> get props => [isSelfMode];
}

class ResetSelfInvestorMode extends ThemeEvent{}