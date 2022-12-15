import 'package:flutter/material.dart';
import 'package:flutter_advanced_course/core/widgets/app_background.dart';
import 'package:flutter_advanced_course/features/feature_weather/domain/entities/current_city_entity.dart';
import 'package:flutter_advanced_course/features/feature_weather/presentation/bloc/cw_status.dart';
import 'package:flutter_advanced_course/features/feature_weather/presentation/bloc/home_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? cityName = 'Tehran';

  PageController? _pageController = PageController(initialPage: 0);

  @override
  void initState() {
    super.initState();

    BlocProvider.of<HomeBloc>(context)
        .add(LoadCurrentWeatherEvent(cityName: cityName));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Column(
      children: [
        BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            if (state.cwStatus is CwLoading) {
              return Center(
                  child: LoadingAnimationWidget.halfTriangleDot(
                      color: Colors.white, size: 50));
            } else if (state.cwStatus is CwComplete) {
              //* cast
              CwComplete cwComplete = state.cwStatus as CwComplete;

              CurrentCityEntity currentCityEntity =
                  cwComplete.currentCityEntity!;

              //do some thing
              return Expanded(
                  child: ListView(children: [
                Padding(
                  padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.02),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 400,
                    child: PageView.builder(
                      physics: const AlwaysScrollableScrollPhysics(),
                      allowImplicitScrolling: true,
                      controller: _pageController,
                      itemCount: 2,
                      itemBuilder: (context, position) {
                        if (position == 0) {
                          return Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 50),
                                child: Text(
                                  currentCityEntity.name!,
                                  style: const TextStyle(
                                      fontSize: 30, color: Colors.white),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 20),
                                child: Text(
                                  currentCityEntity.weather![0].description!,
                                  style: const TextStyle(
                                      fontSize: 20, color: Colors.grey),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 20),
                                child: AppBackground.setIconForMain(
                                    currentCityEntity.weather![0].description!),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 20),
                                child: Text(
                                  "${currentCityEntity.main!.temp!.round()}\u00B0",
                                  style: const TextStyle(
                                      fontSize: 50, color: Colors.white),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  /// max temp
                                  Column(
                                    children: [
                                      const Text(
                                        "max",
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.grey,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        "${currentCityEntity.main!.tempMax!.round()}\u00B0",
                                        style: const TextStyle(
                                          fontSize: 16,
                                          color: Colors.white,
                                        ),
                                      )
                                    ],
                                  ),

                                  /// divider
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      left: 10.0,
                                      right: 10,
                                    ),
                                    child: Container(
                                      color: Colors.grey,
                                      width: 2,
                                      height: 40,
                                    ),
                                  ),

                                  /// min temp
                                  Column(
                                    children: [
                                      const Text(
                                        "min",
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.grey,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        "${currentCityEntity.main!.tempMin!.round()}\u00B0",
                                        style: const TextStyle(
                                          fontSize: 16,
                                          color: Colors.white,
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              )
                            ],
                          );
                        } else {
                          return Container(
                            color: Colors.amber,
                          );
                        }
                      },
                    ),
                  ),
                ),

                const SizedBox(
                  height: 10,
                ),

                /// pageView Indicator
                Center(
                  child: SmoothPageIndicator(
                    controller: _pageController!,
                    // PageController
                    count: 2,
                    effect: const ExpandingDotsEffect(
                      dotWidth: 10,
                      dotHeight: 10,
                      spacing: 5,
                      activeDotColor: Colors.white,
                    ),
                    // your preferred effect
                    onDotClicked: (index) => _pageController!.animateToPage(
                      index,
                      duration: const Duration(microseconds: 500),
                      curve: Curves.bounceOut,
                    ),
                  ),
                ),
              ]));
            }
            return Text(
              'Some Thing went wrong',
              style: TextStyle(color: Colors.white),
            );
          },
        ),
      ],
    ));
  }
}
