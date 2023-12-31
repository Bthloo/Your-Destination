import 'package:bloc/bloc.dart';
import 'package:graduation_project/core/api_manager/api_manager.dart';
import 'package:graduation_project/core/models/MapSearchResponse.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchInitial());

  search({required String searchName}) async{
    emit(SearchLoading());
    try {
     MapSearchResponse response = await ApiManager.search(keyWord: searchName);
     emit(SearchSuccess(response));
    } catch (e) {
      String errorMessage = 'Something Went Wrong$e';
      emit(SearchError(errorMessage));
    }
  }
}
