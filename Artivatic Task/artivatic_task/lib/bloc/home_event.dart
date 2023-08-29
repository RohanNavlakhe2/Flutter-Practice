part of 'home_bloc.dart';

abstract class HomeEvent {
  const HomeEvent();
}

class FetchHomeDataEvent extends HomeEvent{}
class RefreshHomeDataEvent extends HomeEvent{}
