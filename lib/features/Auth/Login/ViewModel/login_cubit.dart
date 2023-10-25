import 'package:bloc/bloc.dart';

import '../Models/user.dart';


part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());
 // FirebaseAuth authService = FirebaseAuth.instance;
  static UserModel user = UserModel();
  login(
      {required String email,
      required String password,
      required bool keepMeLogin}) async {


    // emit(LoginLoading());
    // try {
    //   var result = await authService.signInWithEmailAndPassword(
    //     email: email,
    //     password: password,
    //   );
    //   await MyDataBase.readUser(result.user?.uid ?? '');
    //   if (keepMeLogin) {
    //     await const FlutterSecureStorage()
    //         .write(key: 'token', value: result.user?.uid ?? '');
    //   }
    //   var user = await MyDataBase.readUser(result.user?.uid ?? "");
    //   emit(LoginSuccess('Success'));
    //
    // } on FirebaseAuthException catch (e) {
    //   String errorMessage = 'Something Went Wrong';
    //   if (e.code == 'user-not-found') {
    //     String errorMessage = 'User-not-found.';
    //     emit(LoginError(errorMessage));
    //   } else if (e.code == 'wrong-password') {
    //     String errorMessage = 'wrong-password.';
    //     emit(LoginError(errorMessage));
    //   }
    //   emit(LoginError(e.code));
    // } catch (e) {
    //   String errorMessage = 'Something Went Wrong$e';
    //   emit(LoginError(errorMessage));
    // }
  }



}
