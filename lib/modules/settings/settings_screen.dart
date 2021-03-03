import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:naruto/shared/components/components.dart';
import 'package:naruto/shared/cubit/cubit.dart';
import 'package:naruto/shared/cubit/states.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              defaultButton(
                press: () {
                  AppCubit.get(context).changeLocalization('en');
                },
                text: getLocale(context).english,
              ),
              SizedBox(
                height: 20.0,
              ),
              defaultButton(
                press: () {
                  AppCubit.get(context).changeLocalization('ar');
                },
                text: getLocale(context).arabic,
              ),
              SizedBox(
                height: 20.0,
              ),
              Row(
                children: [
                  Expanded(
                    child: Text(
                        getLocale(context).darkMode,
                    ),
                  ),
                  CupertinoSwitch(
                    value: AppCubit.get(context).isDark,
                    onChanged: (value)
                    {
                      AppCubit.get(context).changeAppTheme(value);
                    },
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
