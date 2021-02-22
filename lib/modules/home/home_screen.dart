import 'dart:ui';

import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:naruto/modules/home/cubit/cubit.dart';
import 'package:naruto/modules/home/cubit/states.dart';
import 'package:naruto/shared/components/components.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeScreenCubit, HomeScreenStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var model = HomeScreenCubit.get(context).model;

        return ConditionalBuilder(
          condition: state is! HomeScreenLoadingState,
          builder: (context) => SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                ExpansionTile(
                  title: Text(
                    '',
                  ),
                ),
                ListView.separated(
                  physics: BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) =>
                      courseItem(model.result.data[index]),
                  separatorBuilder: (context, index) => Container(
                    width: double.infinity,
                    height: 1.0,
                    color: Colors.grey[300],
                  ),
                  itemCount: model.result.data.length,
                ),
                if (HomeScreenCubit.get(context).currentPage <=
                    HomeScreenCubit.get(context).totalPages)
                  Container(
                    height: 40.0,
                    child: ConditionalBuilder(
                      condition: state is! HomeScreenLoadingMoreState,
                      builder: (context) => defaultButton(
                        press: () {
                          if (HomeScreenCubit.get(context).currentPage <=
                              HomeScreenCubit.get(context).totalPages) {
                            HomeScreenCubit.get(context).getMoreCourses();
                          }
                        },
                        radius: 0.0,
                        text: 'load more..',
                      ),
                      fallback: (context) => progressIndicator(),
                    ),
                  )
              ],
            ),
          ),
          fallback: (context) => progressIndicator(),
        );
      },
    );
  }
}
