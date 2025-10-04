part of 'theme_bloc.dart';

/// الفئة الأساسية للأحداث الخاصة بالثيم.
sealed class ThemeEvent extends Equatable {
  const ThemeEvent();

  @override
  List<Object> get props => [];
}

/// حدث الحصول على الثيم الحالي من الكاش.
class GetCuurrentThemeEvent extends ThemeEvent {}

/// حدث تغيير الثيم إلى ثيم جديد.
class ChangeThemeEvent extends ThemeEvent {
  final AppTheme appTheme;
  // تم تصحيح المُنشئ بحيث لا يتكرر تمرير المتغير.
  const ChangeThemeEvent(this.appTheme);
  
  @override
  List<Object> get props => [appTheme];
}
