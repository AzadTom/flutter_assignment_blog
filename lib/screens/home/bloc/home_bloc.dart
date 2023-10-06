import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter_03/data/blog.dart';
import 'package:flutter_03/data/blogmodel.dart';
import 'package:meta/meta.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<HomeInitialEvent>(homeInitialEvent);

  }

  FutureOr<void> homeInitialEvent(
      HomeInitialEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoadingState());

    List<Blog> results = await fetchData();

    emit(HomeLoadedSuccess(products: results));
  }

 
}
