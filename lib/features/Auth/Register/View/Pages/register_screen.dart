import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/core/general_components/ColorHelper.dart';

import '../../../../../Core/general_components/custom_form_field.dart';
import '../../../../../core/general_components/build_show_toast.dart';
import '../../../../../core/general_components/my_validators.dart';
import '../../../Login/View/Pages/login_screen.dart';
import '../../ViewModel/Register Cubit/register_cubit.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  static const String routeName = "register";

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  Country textCountry = Country(
      phoneCode: '20',
      countryCode: 'EG',
      e164Sc: 0,
      geographic: true,
      level: 1,
      name: 'Egypt',
      example: '1001234567',
      displayName: ' Egypt (EG) [+20]',
      displayNameNoCountryCode: '0',
      e164Key: '20-EG-0');
  final TextEditingController rePasswordController = TextEditingController();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController nameController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final TextEditingController phoneController = TextEditingController();
  RegisterCubit registerCubit = RegisterCubit();

  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xff171717),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xff171717),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                const Text(
                  'Join us via your Email',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 25),
                ),
                const Text(
                  'Please Enter your Details',
                  style: TextStyle(color: Colors.white60, fontSize: 16),
                ),
                const SizedBox(
                  height: 40,
                ),
                CustomFormField(
                    keyboardType: TextInputType.name,
                    hintText: 'Enter Your Name',
                    validator: (value) => MyValidators.nameValidator(value),
                    controller: nameController),
                const SizedBox(
                  height: 20,
                ),
                CustomFormField(
                    prefix: TextButton.icon(
                      onPressed: () {
                        showCountry(context);
                      },
                      icon: Text(
                        textCountry.flagEmoji,
                        style: const TextStyle(fontSize: 30),
                      ),
                      label: Text(
                        '+${textCountry.phoneCode}',
                        style:
                            const TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                    // Row(
                    //   children: [
                    //     Text(textCountry.flagEmoji,style: TextStyle(
                    //       fontSize: 35
                    //     ),),
                    //     Text('+${textCountry.phoneCode}',style: TextStyle(
                    //         fontSize: 17,color: Colors.white
                    //     ),)
                    //   ],
                    // ),
                    keyboardType: TextInputType.name,
                    hintText: 'Enter Your Phone Number',
                    validator: (value) => MyValidators.phoneValidator(value),
                    controller: phoneController),
                const SizedBox(
                  height: 20,
                ),
                CustomFormField(
                    keyboardType: TextInputType.emailAddress,
                    hintText: 'Enter Your Email',
                    validator: (value) => MyValidators.emailValidator(value),
                    controller: emailController),
                const SizedBox(
                  height: 20,
                ),
                CustomFormField(
                    hintText: 'Enter Your password',
                    isPassword : true,
                    validator: (value) => MyValidators.passwordValidator(value),
                    controller: passwordController),
                const SizedBox(
                  height: 20,
                ),
                CustomFormField(
                    hintText: 'Enter password confirmation',
                    isPassword : true,
                    validator: (value) => MyValidators.repeatPasswordValidator(
                        value: value, password: passwordController.text),
                    controller: rePasswordController),
                const SizedBox(
                  height: 40,
                ),
                BlocConsumer<RegisterCubit, RegisterState>(
                  bloc: registerCubit,
                  listener: (context, state) {},
                  builder: (context, state) {
                    if (state is RegisterLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is RegisterError) {
                      buildShowToast(state.message);
                    } else if (state is RegisterSuccess) {
                      buildShowToast(state.message);
                      return SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            register();
                          },
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'Register',
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                        ),
                      );
                    }
                    return SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          register();
                        },
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            ' Next',
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      ),
                    );
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Allready Have an Account ? ",
                      style: TextStyle(
                        color: Color(0xffEDEDED),
                      ),
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(
                              context, LoginScreen.routeName);
                        },
                        child: const Text("Login")),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void register() async {
    if (formKey.currentState?.validate() == false) {
      return;
    }
    registerCubit.register(
        email: emailController.text,
        name: nameController.text,
        password: passwordController.text,
        phone: phoneController.text);
  }

  void showCountry(BuildContext context) {
    showCountryPicker(
      exclude: <String>['IL'],
        context: context,
        countryListTheme: const CountryListThemeData(
          flagSize: 25,
          backgroundColor: ColorHelper.darkColor,
          searchTextStyle: TextStyle(color: Colors.white),
          textStyle: TextStyle(fontSize: 16, color: Colors.white),
          bottomSheetHeight: 500,
          borderRadius:  BorderRadius.all(Radius.circular(20)),
          inputDecoration: InputDecoration(
            labelText: 'Search',
            labelStyle: TextStyle(color: Colors.white),
            prefixIconColor:  Colors.white,
            prefixIcon: Icon(Icons.search),
            filled: true,
            fillColor: Color(0xff444444),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)),

            ),
          ),
        ),
        showPhoneCode: true,
        onSelect: (Country country) {
          setState(() {
            textCountry = country;
          });
        });
  }
}
