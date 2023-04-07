part of 'more_bloc.dart';

abstract class MoreEvent extends Equatable{
  @override
  List<Object?> get props => [];
}

class OnSlugChanged extends MoreEvent{
  final String slug;
  OnSlugChanged({required this.slug});
  @override
  List<Object?> get props => [slug];
}

class ContentLoadRequest extends MoreEvent{}