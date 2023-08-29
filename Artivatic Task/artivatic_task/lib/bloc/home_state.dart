part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();
}


class HomeDataLoadingState extends HomeState {

  HomeDataLoadingState();

  @override
  List<Object> get props => [];
}

class HomeDataSuccessState extends HomeState{

  HomeDataSuccessState(this.homeData);

  final HomeData homeData;

  @override
  List<Object?> get props => [homeData];

}

class HomeDataErrorState extends HomeState{

  HomeDataErrorState(this.errorMsg);

  String errorMsg;

  @override
  List<Object?> get props => [];
}
