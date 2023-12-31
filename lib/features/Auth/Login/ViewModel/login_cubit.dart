import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:graduation_project/features/profile_screen/view/pages/profile_screen.dart';
import 'package:graduation_project/features/profile_screen/viewmodel/profile_cubit.dart';

import '../../../../core/data_base/models/user.dart' as  user_model;
import '../../../../core/data_base/my_database.dart';




part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());
  static LoginCubit get(BuildContext context) => BlocProvider.of(context);

 static user_model.User currentUser = user_model.User();

  FirebaseAuth authService = FirebaseAuth.instance;
 // static my_user.User user = my_user.User();

  logout()async{
    authService.signOut();
    currentUser.id = '';
    await const FlutterSecureStorage().delete(key: 'token');
  }



  login(
      {required String email,
      required String password,
      required bool keepMeLogin}) async {


    emit(LoginLoading());
    try {
      var result = await authService.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      user_model.User? user =   await MyDataBase.readUser(result.user?.uid ?? '');
      currentUser = user!;

      if (keepMeLogin) {
        await const FlutterSecureStorage()
            .write(key: 'token', value: result.user?.uid ?? '');
      }
     // ProfileCubit.get(context).currentUser = user;
      emit(LoginSuccess('Success'));

    } on FirebaseAuthException catch (e) {
      String errorMessage = 'Something Went Wrong';
      if (e.code == 'user-not-found') {
        String errorMessage = 'User-not-found.';
        emit(LoginError(errorMessage));
      } else if (e.code == 'wrong-password') {
        String errorMessage = 'wrong-password.';
        emit(LoginError(errorMessage));
      }
      emit(LoginError(e.code??'Something Went Wrong'));
    } catch (e) {
      String errorMessage = 'Something Went Wrong$e';
      emit(LoginError(errorMessage));
    }
  }



}
