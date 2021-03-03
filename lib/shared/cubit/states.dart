abstract class AppStates {}

class AppInitialState extends AppStates {}

class AppLoadingState extends AppStates {}

class AppLoadingMoreState extends AppStates {}

class AppSuccess extends AppStates {}

class AppError extends AppStates {
  final String error;

  AppError(this.error);
}

class AppLoadingSearchState extends AppStates {}

class AppLoadingMoreSearchState extends AppStates {}

class AppSuccessSearch extends AppStates {}

class AppErrorSearch extends AppStates {
  final String error;

  AppErrorSearch(this.error);
}

class AppTogglePassword extends AppStates {}

class AppLoadLocal extends AppStates {}

class AppChangeDirection extends AppStates {}

class AppChangeTheme extends AppStates {}