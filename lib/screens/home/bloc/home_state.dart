part of 'home_bloc.dart';

@immutable
abstract class HomeState {}

abstract class HomeActionState extends HomeState {}

final class HomeInitial extends HomeState {}

class HomeLoadingState extends HomeState {}

class HomeLoadedSuccess extends HomeState {
  final List<Blog> products;

  HomeLoadedSuccess({required this.products});
}

class HomeErrorState extends HomeState {}



