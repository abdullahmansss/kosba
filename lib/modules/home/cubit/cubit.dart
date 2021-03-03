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

  addToCart(String id)
  {
    print(getToken());

    DioHelper.postData(
      path: ADD_CART_END_POINT,
      data:
      {
        'type':'course',
        'item_id':id,
      },
      token: 'eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImp0aSI6ImIyOWY4YjEwOTA5MmQyMWYwY2Y2MWMwODRmZTA3YmVmODJmMWQ5ZGE3OWI5MjJhOTAzOWZjMzY4OWJmMzM5NzAyMGU0ZjAwNWUwM2VhZTQ0In0.eyJhdWQiOiIxIiwianRpIjoiYjI5ZjhiMTA5MDkyZDIxZjBjZjYxYzA4NGZlMDdiZWY4MmYxZDlkYTc5YjkyMmE5MDM5ZmMzNjg5YmYzMzk3MDIwZTRmMDA1ZTAzZWFlNDQiLCJpYXQiOjE2MTQ4MDIxNTUsIm5iZiI6MTYxNDgwMjE1NSwiZXhwIjoxNjQ2MzM4MTU1LCJzdWIiOiI3MDEiLCJzY29wZXMiOltdfQ.eRK790M-QM8r7HbaKuzhcilnUPIRNPXg-v7yK4uMEX2Xy3oQhYdCjLrPxaOEGjB_R7M5lq5zSQodiXuhg7fsGNjXEoBe2avaoMEK5XOWZ1-DgNsW5O2ZXCjnwkXvbYxZFN04yOegEBgVN9ZSlx2TJBZQGK1ALqA4WvCxehY9XGUUrmY6eqAE2bITyJATCno8NpTgr_pfhO6cEteLKjv8XZb7yZ8uYRc0bQ6e8PQNUIqpoFr76LK64_4t5pScPlVLc50KUFDBWK_uzUJv89ykaS9CWNIFh6KuRB48Q29roTw0z6BwiA1x5Jem_I6ZkuSQb5jUFsvjm2AT-O8lKiCLA3-sa4HDwhOlx6KPIh7AqwtsoTAVVmAluTleFLP-Aq5wWbN2TltRKp384vPNOxlOyB_qUqvM4c3RsUdE8GruSHHtwNg5x2HWpixOpqsPLL0EdKd5gyrNLY_ShD5mf21SVgUNwCAojvhaJcJhwlwZJx5OtJ4aq4MsGr8PAgQYmv-SIjEK6VkXk6a4JFdYN1VV428nYobD0YVJRrspkUDADfXyJ_eX_hC5-LCdNEsncAZei7wflbwSqFvwG4blMszymtisrWfjKQa9RS1voHxwFvFSCXgC4MA_2G7BqfC1gDbAlN7uZHYe4uh02lbZ_NBFHxC2eToIUkmIdHcppkAWgeA',
    ).then((value)
    {
      print(value.toString());
      emit(AddToCartSuccess());
    }).catchError((error) {
      print(error.toString());
      emit(AddToCartError(error.toString()));
    });
  }

  getCart()
  {
    print(getToken());

    DioHelper.postData(
      path: GET_CART_END_POINT,
      data: null,
      token: 'eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImp0aSI6ImIyOWY4YjEwOTA5MmQyMWYwY2Y2MWMwODRmZTA3YmVmODJmMWQ5ZGE3OWI5MjJhOTAzOWZjMzY4OWJmMzM5NzAyMGU0ZjAwNWUwM2VhZTQ0In0.eyJhdWQiOiIxIiwianRpIjoiYjI5ZjhiMTA5MDkyZDIxZjBjZjYxYzA4NGZlMDdiZWY4MmYxZDlkYTc5YjkyMmE5MDM5ZmMzNjg5YmYzMzk3MDIwZTRmMDA1ZTAzZWFlNDQiLCJpYXQiOjE2MTQ4MDIxNTUsIm5iZiI6MTYxNDgwMjE1NSwiZXhwIjoxNjQ2MzM4MTU1LCJzdWIiOiI3MDEiLCJzY29wZXMiOltdfQ.eRK790M-QM8r7HbaKuzhcilnUPIRNPXg-v7yK4uMEX2Xy3oQhYdCjLrPxaOEGjB_R7M5lq5zSQodiXuhg7fsGNjXEoBe2avaoMEK5XOWZ1-DgNsW5O2ZXCjnwkXvbYxZFN04yOegEBgVN9ZSlx2TJBZQGK1ALqA4WvCxehY9XGUUrmY6eqAE2bITyJATCno8NpTgr_pfhO6cEteLKjv8XZb7yZ8uYRc0bQ6e8PQNUIqpoFr76LK64_4t5pScPlVLc50KUFDBWK_uzUJv89ykaS9CWNIFh6KuRB48Q29roTw0z6BwiA1x5Jem_I6ZkuSQb5jUFsvjm2AT-O8lKiCLA3-sa4HDwhOlx6KPIh7AqwtsoTAVVmAluTleFLP-Aq5wWbN2TltRKp384vPNOxlOyB_qUqvM4c3RsUdE8GruSHHtwNg5x2HWpixOpqsPLL0EdKd5gyrNLY_ShD5mf21SVgUNwCAojvhaJcJhwlwZJx5OtJ4aq4MsGr8PAgQYmv-SIjEK6VkXk6a4JFdYN1VV428nYobD0YVJRrspkUDADfXyJ_eX_hC5-LCdNEsncAZei7wflbwSqFvwG4blMszymtisrWfjKQa9RS1voHxwFvFSCXgC4MA_2G7BqfC1gDbAlN7uZHYe4uh02lbZ_NBFHxC2eToIUkmIdHcppkAWgeA',
    ).then((value)
    {
      print(value.toString());
      emit(AddToCartSuccess());
    }).catchError((error) {
      print(error.toString());
      emit(AddToCartError(error.toString()));
    });
  }
}