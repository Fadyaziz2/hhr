import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onesthrm/res/shared_preferences.dart';

part 'language_event.dart';
part 'language_state.dart';

class LanguageBloc extends Bloc<LanguageEvent, LanguageState> {
  LanguageBloc() : super(const LanguageState()) {
    on<SelectLanguage>(_onSelectLanguage);
  }

  FutureOr<void> _onSelectLanguage(
      SelectLanguage event, Emitter<LanguageState> emit) {
    if (event.selectIndex == 0) {
      SharedUtil.setLanguageIntValue('key_select_language', event.selectIndex);
      event.context.setLocale(const Locale('en', 'US'));
    } else if (event.selectIndex == 1) {
      event.context.setLocale(const Locale('bn', 'BN'));
    } else if (event.selectIndex == 2) {
      event.context.setLocale(const Locale('ar', 'AR'));
    }
    emit(state.copy(selectedIndex: event.selectIndex));
  }
}
