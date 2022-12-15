import 'package:flutter/material.dart';
import 'package:flutter_advanced_course/features/feature_weather/presentation/bloc/home_bloc.dart';
import 'package:flutter_advanced_course/locator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/widgets/main_wrapper.dart';

void main() async {
  await setUp();
  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MultiBlocProvider(
        providers: [ 
         BlocProvider(create: (_)=> locator<HomeBloc>()),
        ],
        child: MainWrapper())));
}
