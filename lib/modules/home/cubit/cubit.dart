import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:naruto/models/courses/courses_model.dart';
import 'package:naruto/modules/home/cubit/states.dart';
import 'package:naruto/shared/components/components.dart';
import 'package:naruto/shared/end_points.dart';
import 'package:naruto/shared/network/remote/dio_helper.dart';

class HomeScreenCubit extends Cubit<HomeScreenStates>
{
  HomeScreenCubit() : super(HomeScreenInitialState());

  static HomeScreenCubit get(context) => BlocProvider.of(context);

  CoursesModel model;
  List<Data> dataModel;
  int currentPage = 2;
  int totalPages = 0;

  getCourses() {
    emit(HomeScreenLoadingState());

    DioHelper.postData(
      path: COURSES_END_POINT,
      data: null,
      token: getToken(),
    ).then((value) {
      //print(jsonDecode(value.toString())['result']);

      model = CoursesModel.fromJson(jsonDecode(value.toString()));
      dataModel = model.result.data;
      totalPages = model.result.lastPage;
      emit(HomeScreenSuccess());
    }).catchError((error) {
      print(error.toString());
      emit(HomeScreenError(error.toString()));
    });
  }

  getMoreCourses() {
    emit(HomeScreenLoadingMoreState());

    DioHelper.postData(
      path: COURSES_END_POINT,
      data: null,
      token: getToken(),
      query: {
        'page': currentPage.toString(),
      },
    ).then((value) {
      var model = CoursesModel.fromJson(jsonDecode(value.toString()));
      dataModel.addAll(model.result.data);
      currentPage++;
      emit(HomeScreenSuccess());
    }).catchError((error) {
      print(error.toString());
      emit(HomeScreenError(error.toString()));
    });
  }

  CoursesModel modelSearch;
  List<Data> dataModelSearch;
  int currentPageSearch = 2;
  int totalPagesSearch = 0;
  String search = '';

  getCoursesSearch(String value) {
    search = value;
    emit(HomeScreenLoadingSearchState());

    DioHelper.postData(
      path: SEARCH_END_POINT,
      data: {
        'type': 1,
        'q': value,
      },
      token: getToken(),
    ).then((value) {
      //print(jsonDecode(value.toString())['result']['data']);

      modelSearch = CoursesModel.fromJson(jsonDecode(value.toString()));
      dataModelSearch = modelSearch.result.data;
      totalPagesSearch = modelSearch.result.lastPage;
      emit(HomeScreenSuccessSearch());
    }).catchError((error) {
      print(error.toString());
      emit(HomeScreenErrorSearch(error.toString()));
    });
  }

  getMoreCoursesSearch() {
    emit(HomeScreenLoadingMoreSearchState());

    DioHelper.postData(
      path: SEARCH_END_POINT,
      data: {
        'type': 1,
        'q': search,
      },
      token: getToken(),
      query: {
        'page': currentPageSearch.toString(),
      },
    ).then((value)
    {
      var model = CoursesModel.fromJson(jsonDecode(value.toString()));
      dataModelSearch.addAll(model.result.data);
      currentPageSearch++;
      emit(HomeScreenSuccessSearch());
    }).catchError((error) {
      print(error.toString());
      emit(HomeScreenErrorSearch(error.toString()));
    });
  }
}