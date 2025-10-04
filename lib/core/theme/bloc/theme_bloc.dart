// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:depi_final_project/core/theme/app_theme.dart';
import 'package:depi_final_project/core/theme/theme_cache_helper.dart';
import 'package:equatable/equatable.dart';


part 'theme_event.dart';
part 'theme_state.dart';

/// Bloc خاص بإدارة الثيم (Theme) في التطبيق.
class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(ThemeInitial()) {
    // الاستماع لجميع أحداث ThemeEvent
    on<ThemeEvent>((event, emit) async {
      // إذا كان الحدث هو الحصول على الثيم الحالي
      if (event is GetCuurrentThemeEvent) {
        // استرجاع مؤشر الثيم المخزن من الكاش
        final themeIndex = await ThemeCacheHelper().getCachedThemeIndex();
        // البحث عن الثيم المناسب بناءً على المؤشر
        final theme = AppTheme.values.firstWhere((element) => element.index == themeIndex);
        emit(LoadingThemeState(appTheme: theme));
      } 
      // إذا كان الحدث هو تغيير الثيم
      else if (event is ChangeThemeEvent) {
        // حفظ مؤشر الثيم الجديد في الكاش
        final themeIndex = event.appTheme.index;
        await ThemeCacheHelper().cacheThemeIndex(themeIndex);
        // إصدار حالة جديدة بالثيم المحدد
        emit(LoadingThemeState(appTheme: event.appTheme));
      }
    });
  }
}
