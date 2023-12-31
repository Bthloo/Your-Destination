import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project/features/Auth/Login/animation_enum.dart';
import 'package:graduation_project/features/home_screen/view/pages/home_screen.dart';
import 'package:rive/rive.dart';

import '../../../../../Core/general_components/custom_form_field.dart';
import '../../../../../core/general_components/ColorHelper.dart';
import '../../../../../core/general_components/build_show_toast.dart';
import '../../../../../core/general_components/my_validators.dart';
import '../../../Register/View/Pages/register_screen.dart';
import '../../ViewModel/login_cubit.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  static const String routeName = "login";

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  LoginCubit loginCubit = LoginCubit();

  bool keepMeLogged = false;
  bool isVisible = false;

  Artboard? riveArtBoard;

  late RiveAnimationController idleAnimationController;
  late RiveAnimationController handsDownAnimationController;
  late RiveAnimationController handsUpAnimationController;
  late RiveAnimationController lookLeftAnimationController;
  late RiveAnimationController lookRightAnimationController;
  late RiveAnimationController successAnimationController;
  late RiveAnimationController failAnimationController;
  final passwordFocusNode = FocusNode();
  bool isLookingRight = false;
  bool isLookingLeft = false;

  void removeAllControllers() {
    riveArtBoard?.removeController(idleAnimationController);
    riveArtBoard?.removeController(handsDownAnimationController);
    riveArtBoard?.removeController(handsUpAnimationController);
    riveArtBoard?.removeController(lookLeftAnimationController);
    riveArtBoard?.removeController(lookRightAnimationController);
    riveArtBoard?.removeController(successAnimationController);
    riveArtBoard?.removeController(failAnimationController);
    isLookingLeft = false;
    isLookingRight = false;
  }

  void addIdleController() {
    removeAllControllers();
    riveArtBoard?.addController(idleAnimationController);
    debugPrint('idle');
  }

  void addHandsDownController() {
    removeAllControllers();
    riveArtBoard?.addController(handsDownAnimationController);
    debugPrint('hands down');
  }

  void addHandsUpController() {
    removeAllControllers();
    riveArtBoard?.addController(handsUpAnimationController);
    debugPrint('hands up');
  }

  void addLookLeftController() {
    removeAllControllers();
    isLookingLeft = true;
    riveArtBoard?.addController(lookLeftAnimationController);
    debugPrint('look left');
  }

  void addLookRightController() {
    removeAllControllers();
    isLookingRight = true;
    riveArtBoard?.addController(lookRightAnimationController);
    debugPrint('look right');
  }

  void addSuccessController() {
    removeAllControllers();
    riveArtBoard?.addController(successAnimationController);
    debugPrint('success');
  }

  void addFailController() {
    removeAllControllers();
    riveArtBoard?.addController(failAnimationController);
    debugPrint('fail');
  }

  void checkPasswordFocusNode() {
    removeAllControllers();
    passwordFocusNode.addListener(() {
      if (passwordFocusNode.hasFocus) {
        addHandsUpController();
      } else if (!passwordFocusNode.hasFocus) {
        addHandsDownController();
      }
    });
  }

  @override
  void initState() {
    super.initState();
    idleAnimationController = SimpleAnimation(AnimationEnum.idle.name);
    handsDownAnimationController =
        SimpleAnimation(AnimationEnum.hands_down.name);
    handsUpAnimationController = SimpleAnimation(AnimationEnum.Hands_up.name);
    lookLeftAnimationController =
        SimpleAnimation(AnimationEnum.Look_down_left.name);
    lookRightAnimationController =
        SimpleAnimation(AnimationEnum.Look_down_right.name);
    successAnimationController = SimpleAnimation(AnimationEnum.success.name);
    failAnimationController = SimpleAnimation(AnimationEnum.fail.name);
    rootBundle.load("assets/rive/loginn_animation.riv").then((data) {
      final file = RiveFile.import(data);
      final artBoard = file.mainArtboard;
      artBoard.addController(idleAnimationController);
      setState(() {
        riveArtBoard = artBoard;
      });
    });

    checkPasswordFocusNode();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: const Color(0xff171717),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xff171717),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                SizedBox(
                    height: MediaQuery.of(context).size.height * .30,
                    child: riveArtBoard == null
                        ? SizedBox(
                            height: MediaQuery.of(context).size.height * .30)
                        : Rive(artboard: riveArtBoard!)),
                // const Text(
                //   'Login',
                //   style: TextStyle(
                //       color: Colors.white,
                //       fontWeight: FontWeight.bold,
                //       fontSize: 25),
                // ),
                const SizedBox(
                  height: 10,
                ),

                CustomFormField(
                    onChange: (value) {
                      if (value!.isNotEmpty &&
                          value.length < 20 &&
                          !isLookingLeft) {
                        addLookLeftController();
                      } else if (value!.isNotEmpty &&
                          value.length > 20 &&
                          !isLookingRight) {
                        addLookRightController();
                      }
                    },
                    keyboardType: TextInputType.emailAddress,
                    hintText: 'Enter Your Email',
                    validator: (value) => MyValidators.emailValidator(value),
                    controller: emailController),
                const SizedBox(
                  height: 20,
                ),
                CustomFormField(
                  passwordFocusNode: passwordFocusNode,
                  isPassword: !isVisible,
                  suffix: IconButton(
                      onPressed: () {
                        setState(() {
                          isVisible = !isVisible;
                        });
                      },
                      icon: isVisible
                          ? const Icon(
                              Icons.visibility,
                              color: Colors.white,
                            )
                          : const Icon(Icons.visibility_off,
                              color: Colors.white)),
                  hintText: 'Enter Your password',
                  validator: (value) => MyValidators.passwordValidator(value),
                  controller: passwordController,
                ),

                const SizedBox(
                  height: 40,
                ),
                Row(
                  children: [
                    Checkbox(
                      activeColor: ColorHelper.mainColor,
                      side: const BorderSide(color: Colors.white),
                      overlayColor: MaterialStatePropertyAll(
                          Colors.white.withOpacity(.1)),
                      checkColor: Colors.white,
                      value: keepMeLogged,
                      onChanged: (value) {
                        setState(() {
                          keepMeLogged = value!;
                        });
                      },
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Text(
                      'keep Me Logged In',
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                buildBlocConsumerMainButton(),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Don't Have an Account ? ",
                      style: TextStyle(
                        color: Color(0xffEDEDED),
                      ),
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(
                              context, RegisterScreen.routeName);
                        },
                        child: const Text("Register")),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  login() async {
    Future.delayed(const Duration(milliseconds: 500), () {
      if (formKey.currentState?.validate() == false) {
        addFailController();
        return;
      }
      loginCubit.login(
        email: emailController.text,
        password: passwordController.text,
        keepMeLogin: keepMeLogged,
      );
    });
  }

  Widget buildBlocConsumerMainButton() {
    return BlocConsumer<LoginCubit, LoginState>(
      bloc: loginCubit,
      listener: (context, state) {
        if (state is LoginError) {
          addFailController();
          buildShowToast(state.message);
        } else if (state is LoginSuccess) {
          buildShowToast(state.message);
          Navigator.pushReplacementNamed(context, HomeScreen.routeName);
        }
      },
      builder: (context, state) {
        if (state is LoginLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        return SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              passwordFocusNode.unfocus();
              login();
            },
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Login',
                style: TextStyle(fontSize: 20),
              ),
            ),
          ),
        );
      },
    );
  }
}
