import 'package:flutter/cupertino.dart';
import 'package:flutter_advanced_course/features/feature_weather/domain/entities/current_city_entity.dart';

@immutable
abstract class CwStatus {}

class CwLoading extends CwStatus {}

class CwComplete extends CwStatus {
  final CurrentCityEntity? currentCityEntity;

  CwComplete({this.currentCityEntity});
}

class CwError extends CwStatus {
  final String? msg;
  CwError({this.msg});
}
