import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:naruto/modules/home/cubit/cubit.dart';
import 'package:naruto/modules/home/cubit/states.dart';
import 'package:naruto/shared/components/components.dart';

class SearchScreen extends StatelessWidget
{
  var searchController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context)
  {
    return BlocConsumer<HomeScreenCubit, HomeScreenStates>(
      listener: (context, state) {},
      builder: (context, state)
      {
        var model = HomeScreenCubit.get(context).modelSearch;

        return Column(
          children:
          [
            Form(
              key: formKey,
              child: defaultFormField(
                con: searchController,
                label: 'Search',
                type: TextInputType.text,
                validate: 'enter a valid data',
                submit: (value)
                {
                  if (formKey.currentState.validate())
                  {
                    HomeScreenCubit.get(context).getCoursesSearch(value);
                  }
                },
              ),
            ),
            Expanded(
              child: ConditionalBuilder(
                condition: state is! HomeScreenLoadingSearchState,
                builder: (context) => ConditionalBuilder(
                  condition: model != null && model.result.data.length > 0,
                  builder: (context) => SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      children:
                      [
                        ListView.separated(
                          physics: BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) => courseItem(model.result.data[index]),
                          separatorBuilder: (context, index) => Container(
                            width: double.infinity,
                            height: 1.0,
                            color: Colors.grey[300],
                          ),
                          itemCount: model.result.data.length,
                        ),
                        if(HomeScreenCubit.get(context).currentPageSearch <= HomeScreenCubit.get(context).totalPagesSearch)
                          Container(
                            height: 40.0,
                            child: ConditionalBuilder(
                              condition: state is! HomeScreenLoadingMoreSearchState,
                              builder: (context) => defaultButton(
                                press: ()
                                {
                                  if(HomeScreenCubit.get(context).currentPageSearch <= HomeScreenCubit.get(context).totalPagesSearch)
                                  {
                                    HomeScreenCubit.get(context).getMoreCoursesSearch();
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
                  fallback: (context) => Center(
                    child: Text(
                      'please enter search',
                    ),
                  ),
                ),
                fallback: (context) => progressIndicator(),
              ),
            ),
          ],
        );
      },
    );
  }
}
