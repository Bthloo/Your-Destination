import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:graduation_project/core/data_base/my_database.dart';
import 'package:graduation_project/features/Auth/Login/ViewModel/login_cubit.dart';

import '../../../../core/data_base/models/ride_request.dart';

part 'history_state.dart';

class HistoryCubit extends Cubit<HistoryState> {
  HistoryCubit() : super(HistoryInitial());
  List<QueryDocumentSnapshot<RideRequest>> history = [];
  getData()async{
    history = [];
    emit(HistoryLoading());
    try {
      QuerySnapshot<RideRequest> data = await MyDataBase.getHistory(id: LoginCubit.currentUser.id);
      history.addAll(data.docs);
      emit(HistorySuccess(history));
    }on TimeoutException catch (ex) {
      emit(HistoryError('$ex'));
    }catch (ex) {
      emit(HistoryError('Something Went Wrong \n $ex'));
    }
  }
}
