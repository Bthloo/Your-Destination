import 'package:bloc/bloc.dart';
import 'package:graduation_project/Features/Auth/Login/Models/user.dart' as MyUser;


part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());
  //FirebaseAuth authService = FirebaseAuth.instance;

  register(
      {required String email,
      required String name,
      required String password,
      required String phone,
      }) async {

    //
    // emit(RegisterLoading());
    // try {
    //   var result = await authService.createUserWithEmailAndPassword(
    //     email: email,
    //     password: password,
    //   );
    //
    //   var myUser =
    //       MyUser.UserModel(id: result.user?.uid, name: name, email: email,phone: phone);
    //   await MyDataBase.addUser(myUser);
    //   emit(RegisterSuccess('Success'));
    // } on FirebaseAuthException catch (e) {
    //   String errorMessage = 'Something Went Wrong';
    //   if (e.code == 'weak-password') {
    //     String errorMessage = 'The password provided is too weak.';
    //     emit(RegisterError(errorMessage));
    //   } else if (e.code == 'email-already-in-use') {
    //     String errorMessage = 'The account already exists for that email.';
    //     emit(RegisterError(errorMessage));
    //   }
    // } catch (e) {
    //   String errorMessage = 'Something Went Wrong$e';
    //   emit(RegisterError(errorMessage));
    //   print(e);
    // }
  }
}
