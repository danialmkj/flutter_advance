import 'package:flutter/material.dart';
import 'package:flutter_advanced_course/core/widgets/bottom_nav.dart';
import 'package:flutter_advanced_course/features/feature_bookmark/presentation/screens/bookmark_screen.dart';
import 'package:flutter_advanced_course/features/feature_weather/domain/entities/current_city_entity.dart';
import 'package:flutter_advanced_course/features/feature_weather/presentation/bloc/cw_status.dart';
import 'package:flutter_advanced_course/features/feature_weather/presentation/bloc/home_bloc.dart';
import 'package:flutter_advanced_course/features/feature_weather/presentation/screens/home_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// class MainWrapper extends StatefulWidget {
//   MainWrapper({Key? key}) : super(key: key);

//   @override
//   State<MainWrapper> createState() => _MainWrapperState();
// }

// class _MainWrapperState extends State<MainWrapper> {
//   @override
//   void initState() {
//     super.initState();

//     //Fetch Tehran Weather
//     BlocProvider.of<HomeBloc>(context).add(LoadCurrentWeatherEvent(cityName: 'Tehran'));
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(),
//       body: BlocBuilder<HomeBloc, HomeState>(
//         builder: (context, state) {
//           if (state.cwStatus is CwLoading) {
//             return Center(
//               child: CircularProgressIndicator(),
//             );
//           } else if (state.cwStatus is CwComplete) {

//             //* Fetch Data From CwComplete & cast state.cwStatus To CwComplete
//             CwComplete cwComplete = state.cwStatus as CwComplete;

//            CurrentCityEntity currentCityEntity = cwComplete.currentCityEntity!;

//             return Center(child: Text(currentCityEntity.name.toString()));

//           } else if (state.cwStatus is CwError) {
//             return Center(child: Text('Error'));
//           }
//           return Container();
//         },
//       ),
//     );
//   }
// }


class MainWrapper extends StatelessWidget {
 MainWrapper({super.key});

 final PageController _pageController = PageController(initialPage: 0);

 List<Widget> pageViewPages = [
  HomeScreen(),
  BookMarkScreen(),
 ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNav(Controller: _pageController),
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage('assets/images/pic_bg.jpg') , fit: BoxFit.cover)
        ),
        child: PageView(
          controller: _pageController,
          children: pageViewPages,
        ),
      ),
    );
  }
}