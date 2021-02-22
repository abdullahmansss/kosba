abstract class HomeScreenStates {}

class HomeScreenInitialState extends HomeScreenStates {}

class HomeScreenLoadingState extends HomeScreenStates {}

class HomeScreenLoadingMoreState extends HomeScreenStates {}

class HomeScreenSuccess extends HomeScreenStates {}

class HomeScreenError extends HomeScreenStates {
  final String error;

  HomeScreenError(this.error);
}

class HomeScreenLoadingSearchState extends HomeScreenStates {}

class HomeScreenLoadingMoreSearchState extends HomeScreenStates {}

class HomeScreenSuccessSearch extends HomeScreenStates {}

class HomeScreenErrorSearch extends HomeScreenStates {
  final String error;

  HomeScreenErrorSearch(this.error);
}

class HomeScreenTogglePassword extends HomeScreenStates {}