import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:onesthrm/res/enum.dart';

abstract class SupportEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetSupportData extends SupportEvent {

  final Filter filter;
  final String? date;

  GetSupportData({this.filter = Filter.open,this.date});

  @override
  List<Object> get props => [filter];
}

class SelectDatePicker extends SupportEvent {
 final  BuildContext context;
  SelectDatePicker(this.context);

  @override
  List<Object> get props => [context];
}

class OnFilterUpdate extends SupportEvent {
  final Filter filter;
  OnFilterUpdate({this.filter = Filter.open});

  @override
  List<Object> get props => [filter];
}
