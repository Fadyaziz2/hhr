part of 'menu_drawer_bloc.dart';

abstract class MenuDrawerEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class MenuDrawerLoadData extends MenuDrawerEvent {
  final BuildContext context;
  final String? slug;
  MenuDrawerLoadData({this.slug, required this.context});
  @override
  List<Object?> get props => [slug, context];
}
