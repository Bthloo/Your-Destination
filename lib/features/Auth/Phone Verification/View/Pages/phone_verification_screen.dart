// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:mab_drive/Core/ColorHelper.dart';
// import 'package:mab_drive/Features/Auth/Register/ViewModel/Register%20Cubit/register_cubit.dart';
// import 'package:pin_code_fields/pin_code_fields.dart';
//
// import '../../../../../Core/general_components/build_show_toast.dart';
//
// class PhoneVerificationScreen extends StatelessWidget {
//   PhoneVerificationScreen({super.key});
//
//   static const String routeName = "OtpScreen";
//   late String otpCode;
//   var formKey = GlobalKey<FormState>();
//   final TextEditingController otpController = new TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//
//     var args = ModalRoute
//         .of(context)!
//         .settings
//         .arguments;
//
//     return Scaffold(
//       backgroundColor: Color(0xff171717),
//       appBar: AppBar(
//         iconTheme: IconThemeData(
//             color: Colors.white
//         ),
//         elevation: 0,
//         backgroundColor: Color(0xff171717),
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(10.0),
//         child: Form(
//           key: formKey,
//           child: Column(
//             children: [
//               const Text(
//                 'We sent you a code ',
//                 style: TextStyle(
//                     color: Colors.white,
//                     fontWeight: FontWeight.bold,
//                     fontSize: 25),
//               ),
//               Text(
//                 'We sent it to +$args',
//                 style: TextStyle(color: Colors.white60, fontSize: 16),
//               ),
//               SizedBox(height: 60,),
//               Container(
//                 child: PinCodeTextField(
//
//                   validator: (value) {
//                     if (value?.length != 6) {
//                       return "Please enter 6 digit code";
//                     }
//                     return null;
//                   },
//                   appContext: context,
//                   autoFocus: true,
//                   cursorColor: Colors.black,
//                   keyboardType: TextInputType.number,
//                   length: 6,
//                   obscureText: false,
//                   animationType: AnimationType.fade,
//                   controller: otpController,
//                   textStyle: TextStyle(
//                       color: Colors.white
//                   ),
//                   pinTheme: PinTheme(
//
//                     shape: PinCodeFieldShape.box,
//                     borderRadius: BorderRadius.circular(5),
//                     fieldHeight: 50,
//                     fieldWidth: 40,
//                     borderWidth: 1,
//                     activeColor: ColorHelper.mainColor,
//                     inactiveColor: Color(0xff444444),
//                     inactiveFillColor: Color(0xff444444),
//                     activeFillColor: ColorHelper.mainColor,
//                     selectedColor: ColorHelper.mainColor,
//                     selectedFillColor: Color(0xff444444),
//                   ),
//                   animationDuration: const Duration(milliseconds: 300),
//                   backgroundColor: Color(0xff171717),
//                   enableActiveFill: true,
//                   onCompleted: (code) {
//                     otpCode = code;
//                     print("Completed");
//                   },
//
//                   onChanged: (value) {
//                     print(value);
//                   },
//                 ),
//               ),
//               SizedBox(height: 30,),
//               BlocProvider(
//                 create: (context) => RegisterCubit()..register(),
//                 child: BlocConsumer<RegisterCubit, RegisterState>(
//                   listener: (context, state) {
//                   },
//                   builder: (context, state) {
//                     if(state is RegisterLoading ){
//                       return Center(child: CircularProgressIndicator());
//                     }
//                     else if(state is RegisterError){
//                       buildShowToast(state.message);
//                     }
//                     else if(state is RegisterSuccess){
//                       buildShowToast(state.message);
//                     }
//                     return SizedBox(
//                       width: double.infinity,
//                       child: ElevatedButton(
//                         onPressed: () {
//                         },
//                         child: const Padding(
//                           padding: EdgeInsets.all(8.0),
//                           child: Text(
//                             'Send',
//                             style: TextStyle(fontSize: 20),
//                           ),
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   void register(String phone) {
//     if (formKey.currentState?.validate() == false) {
//       return;
//     }
//
//
//   }
// }
