import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:naruto/layout/cubit/states.dart';
import 'package:naruto/modules/cart/cart_screen.dart';
import 'package:naruto/modules/home/home_screen.dart';
import 'package:naruto/modules/search/search_screen.dart';
import 'package:naruto/modules/settings/settings_screen.dart';

class HomeLayoutCubit extends Cubit<HomeLayoutStates>
{
  HomeLayoutCubit() : super(HomeLayoutInitialState());

  static HomeLayoutCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget> widgets = [
    HomeScreen(),
    SearchScreen(),
    CartScreen(),
    SettingsScreen(),
  ];

  List<List<Widget>> actions = [
    [
      IconButton(
        onPressed: () {},
        icon: Icon(
          Icons.search,
        ),
      ),
      IconButton(
        onPressed: () {},
        icon: Icon(
          Icons.notifications,
        ),
      ),
    ],
    [
      IconButton(
        onPressed: () {},
        icon: Icon(
          Icons.notifications,
        ),
      ),
    ],
    [
      IconButton(
        onPressed: () {},
        icon: Icon(
          Icons.add_a_photo_outlined,
        ),
      ),
    ],
    [],
  ];

  changeIndex(int index)
  {
    currentIndex = index;
    emit(HomeLayoutIndexState());
  }
}