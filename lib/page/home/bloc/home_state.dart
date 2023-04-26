import 'package:flutter/cupertino.dart';
import 'package:meta_club_api/meta_club_api.dart';

class HomeState {
  final Settings? settings;

  HomeState({this.settings});

  HomeState copy({BuildContext? context, Settings? settings}) {
    return HomeState(settings: settings ?? this.settings);
  }
}
