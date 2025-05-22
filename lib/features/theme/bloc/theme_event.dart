part of 'theme_bloc.dart';

@immutable
abstract class ThemeEvent {}

class ThemeLoadStarted extends ThemeEvent {} // Event to load saved theme
class ThemeChanged extends ThemeEvent {
  final bool isDarkMode;
  ThemeChanged({required this.isDarkMode});
}
