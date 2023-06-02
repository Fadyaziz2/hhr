import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'bottom_nav_state.dart';

class BottomNabCubit extends Cubit<BottomNavState> {
  BottomNabCubit() : super(const BottomNavState());

  void setTab(BottomNavTab tab) => emit(BottomNavState(tab: tab));
}