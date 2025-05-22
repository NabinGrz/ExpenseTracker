import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:expensetracker/core/theme/app_theme.dart'; // Your AppTheme file
import 'package:equatable/equatable.dart';

part 'theme_event.dart';
part 'theme_state.dart';

const String _themePrefsKey = 'isDarkMode';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(ThemeState(themeData: AppTheme.lightTheme, isDarkMode: false)) {
    on<ThemeLoadStarted>(_onThemeLoadStarted);
    on<ThemeChanged>(_onThemeChanged);
  }

  Future<void> _onThemeLoadStarted(
    ThemeLoadStarted event,
    Emitter<ThemeState> emit,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    final bool isDarkMode = prefs.getBool(_themePrefsKey) ?? false; // Default to light mode
    emit(ThemeState(
      themeData: isDarkMode ? AppTheme.darkTheme : AppTheme.lightTheme,
      isDarkMode: isDarkMode,
    ));
  }

  Future<void> _onThemeChanged(
    ThemeChanged event,
    Emitter<ThemeState> emit,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_themePrefsKey, event.isDarkMode);
    emit(ThemeState(
      themeData: event.isDarkMode ? AppTheme.darkTheme : AppTheme.lightTheme,
      isDarkMode: event.isDarkMode,
    ));
  }
}
