abstract class SearchAppStates {}

class SearchInitialState extends SearchAppStates {}
class SearchLoadingState extends SearchAppStates {}
class SearchSuccessState extends SearchAppStates {}
class SearchErrorState extends SearchAppStates {
  final String error;

  SearchErrorState(this.error);
}