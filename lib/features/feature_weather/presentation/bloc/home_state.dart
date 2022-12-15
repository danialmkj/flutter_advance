part of 'home_bloc.dart';

class HomeState {
  CwStatus? cwStatus;
  HomeState({required this.cwStatus});

  HomeState copyWith({CwStatus? newStatus}) {
    return HomeState(cwStatus: newStatus ?? this.cwStatus);
  }
}
