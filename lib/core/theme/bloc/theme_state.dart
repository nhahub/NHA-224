part of 'theme_bloc.dart';

/// الفئة الأساسية للحالات الخاصة بالثيم.
sealed class ThemeState extends Equatable {
  const ThemeState();
  
  @override
  List<Object> get props => [];
}

/// الحالة الابتدائية للثيم.
final class ThemeInitial extends ThemeState {}

/// حالة تحميل الثيم والتي تحتوي على الثيم الحالي.
final class LoadingThemeState extends ThemeState {
  final AppTheme appTheme;
  const LoadingThemeState({ required this.appTheme });
  
  @override
  List<Object> get props => [appTheme];
}
