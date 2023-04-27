import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta_club_api/meta_club_api.dart';

import '../../../res/enum.dart';

class HomeState extends Equatable{
  final Settings? settings;
  final NetworkStatus status;

  const HomeState({this.settings,this.status = NetworkStatus.initial});

  HomeState copy({BuildContext? context, Settings? settings}) {
    return HomeState(settings: settings ?? this.settings);
  }

  @override
  List<Object?> get props => [settings];
}
