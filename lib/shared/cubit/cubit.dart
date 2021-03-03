import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:naruto/models/courses/courses_model.dart';
import 'package:naruto/modules/home/cubit/states.dart';
import 'package:naruto/shared/components/components.dart';
import 'package:naruto/shared/cubit/states.dart';
import 'package:naruto/shared/end_points.dart';
import 'package:naruto/shared/localization/localization_model.dart';
import 'package:naruto/shared/network/remote/dio_helper.dart';

class AppCubit extends Cubit<AppStates>
{
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  LocalizationModel localizationModel;

  changeLocalization(String code) async
  {
    saveLocaleCode(code);

    String translation =
        await rootBundle.loadString('assets/translations/$code.json');

    changeAppDirection(code);

    loadLocalization(
      json: translation,
    );
  }

  loadLocalization({
    @required String json,
  })
  {
    localizationModel = LocalizationModel.fromJson(json);

    print(json);

    setTitles();

    emit(AppLoadLocal());
  }

  List<String> titles = [];

  setTitles()
  {
    titles.add('');
    titles.add(localizationModel.search);
    titles.add(localizationModel.cart);
    titles.add(localizationModel.settings);
  }

  TextDirection appDirection = TextDirection.ltr;

  changeAppDirection(String code)
  {
    appDirection = code == 'ar' ? TextDirection.rtl : TextDirection.ltr;

    emit(AppChangeDirection());
  }

  bool isDark = false;

  setAppTheme()
  {
    isDark = getAppTheme()??false;

    emit(AppChangeTheme());
  }

  changeAppTheme(bool value)
  {
    saveAppTheme(value);
    isDark = value;

    emit(AppChangeTheme());
  }
}