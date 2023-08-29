import 'dart:async';

import 'package:artivatic_task/model/home_data.dart';
import 'package:artivatic_task/network/custom_exception.dart';
import 'package:artivatic_task/reposiotory/home_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';


part 'home_state.dart';
part 'home_event.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {

  HomeRepository _homeRepository;

  HomeBloc(this._homeRepository) : super(HomeDataLoadingState()) {
    on<HomeEvent>((event, emit) async {

       if(event is FetchHomeDataEvent)
          emit(HomeDataLoadingState());

       try{
         emit(HomeDataSuccessState(await _homeRepository.getHomeData()));
       } on CustomException catch(e){
          emit(HomeDataErrorState(e.toString()));
       }
    });
  }
}
