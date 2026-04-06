part of 'theme_bloc.dart';

class ThemeState extends Equatable {
  final bool isDark;
  final bool hideAmount;
  final String selectedTheme;
  final bool isInvestorMode;
  final List<String> themeList;

  ThemeState({
    required this.isDark,
    this.hideAmount = false,
    this.selectedTheme = ApiKeyConstants.light,
    this.themeList = const [
      ApiKeyConstants.light,
      ApiKeyConstants.dark,
      ApiKeyConstants.systemDefault,
    ],
    this.isInvestorMode = true,
  });

  ThemeState copyWith({
    bool? isDark,
    bool? hideAmount,
    String? selectedTheme,
    List<String>? themeList,
    bool? isInvestorMode,
  }) {
    return ThemeState(
      isDark: isDark ?? this.isDark,
      hideAmount: hideAmount ?? this.hideAmount,
      selectedTheme: selectedTheme ?? this.selectedTheme,
      themeList: themeList ?? this.themeList,
      isInvestorMode: isInvestorMode ?? this.isInvestorMode,
    );
  }

  @override
  List<Object?> get props => [isDark, hideAmount, selectedTheme, themeList, isInvestorMode];
}
