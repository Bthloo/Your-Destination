part of 'history_cubit.dart';

abstract class HistoryState {}

class HistoryInitial extends HistoryState {}
class HistoryLoading extends HistoryState {}
class HistorySuccess extends HistoryState {
  List<QueryDocumentSnapshot<RideRequest>> request;
  HistorySuccess(this.request);
}
class HistoryError extends HistoryState{
  String? message;
  HistoryError(this.message);
}
