import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_advanced_course/core/resources/data_state.dart';
import 'package:flutter_advanced_course/features/feature_weather/domain/entities/current_city_entity.dart';
import 'package:flutter_advanced_course/features/feature_weather/domain/use_cases/get_current_weather_usecase.dart';
import 'package:flutter_advanced_course/features/feature_weather/presentation/bloc/cw_status.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {

  final GetCurrentWeatherUseCase getCurrentWeatherUseCase;

  HomeBloc(this.getCurrentWeatherUseCase) : super(HomeState(cwStatus: CwLoading())) {
    
    on<LoadCurrentWeatherEvent>((event, emit) async {

     //In First Time Display Loading
     emit(state.copyWith(newStatus: CwLoading()));

     DataState dataState =  await getCurrentWeatherUseCase(event.cityName!);

     if (dataState is DataSuccess) {
       
       emit(state.copyWith(newStatus: CwComplete( currentCityEntity: dataState.data))); 

     } else if(dataState is DataFailed){
       
       emit(state.copyWith(newStatus: CwError(msg: dataState.error)));
     } 


    });
  }
}
