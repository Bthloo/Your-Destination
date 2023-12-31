import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'waiting_screen_state.dart';

class WaitingScreenCubit extends Cubit<WaitingScreenState> {
  WaitingScreenCubit() : super(WaitingScreenInitial());

}
