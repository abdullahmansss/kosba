import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:naruto/layout/cubit/cubit.dart';
import 'package:naruto/layout/cubit/states.dart';

class HomeLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => HomeLayoutCubit(),
      child: BlocConsumer<HomeLayoutCubit, HomeLayoutStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              titleSpacing: 20.0,
              title: Text(HomeLayoutCubit.get(context)
                  .titles[HomeLayoutCubit.get(context).currentIndex]),
              // actions: HomeLayoutCubit.get(context)
              //     .actions[HomeLayoutCubit.get(context).currentIndex],
            ),
            body: HomeLayoutCubit.get(context)
                .widgets[HomeLayoutCubit.get(context).currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              showSelectedLabels: false,
              showUnselectedLabels: false,
              onTap: (index) {
                HomeLayoutCubit.get(context).changeIndex(index);
              },
              currentIndex: HomeLayoutCubit.get(context).currentIndex,
              items: [
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.home,
                  ),
                  label: 'home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.search,
                  ),
                  label: 'search',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.shopping_bag_outlined,
                  ),
                  label: 'cart',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.settings,
                  ),
                  label: 'settings',
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
