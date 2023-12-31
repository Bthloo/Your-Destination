part of 'search_cubit.dart';


abstract class SearchState {}

class SearchInitial extends SearchState {}
class SearchLoading extends SearchState{}
class SearchSuccess extends SearchState{
  MapSearchResponse? searchResponse;
  SearchSuccess(this.searchResponse);
}
class SearchError extends SearchState{
  String? message;
  SearchError(this.message);
}

