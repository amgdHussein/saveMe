// // import 'package:bloc_provider/bloc_provider.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_conditional_rendering/conditional.dart';
// import 'package:save_me/core/auth/sign_up/bloc/sign_up_bloc.dart';
// import 'package:save_me/modules/save_me/repositories/user_repository.dart';
// import 'package:save_me/utils/mixins/validation_mixins.dart';
// import 'package:save_me/widgets/snack_bars/error_snack_bar.dart';
// import 'package:save_me/widgets/snack_bars/submitting_snack_bar.dart';
// import 'package:sms_autofill/sms_autofill.dart';

// class SignUpPhoneForm extends StatefulWidget {
//   final UserRepository _userRepository;
//   SignUpPhoneForm({Key key, @required UserRepository userRepository})
//       : _userRepository = userRepository,
//         super(key: key);

//   @override
//   _SignUpPhoneFormState createState() => _SignUpPhoneFormState();
// }

// class _SignUpPhoneFormState extends State<SignUpPhoneForm> {
//   bool isContinue = true;
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   final TextEditingController _phoneController = TextEditingController();
//   // final TextEditingController _OTPController = TextEditingController();
//   // final FocusNode _OTPFocusNode = FocusNode();

//   // BoxDecoration get _OTPDecoration {
//   //   return BoxDecoration(
//   //     border: Border.all(color: Theme.of(context).primaryColor),
//   //     borderRadius: BorderRadius.circular(15.0),
//   //   );
//   // }

//   bool get isPopulated => _phoneController.text.isNotEmpty;

//   bool isButtonEnabled(SignUpState state) =>
//       state.isFormValid && this.isPopulated && !state.isSubmitting;

//   SignUpBloc _signUpBloc;
//   @override
//   void initState() {
//     super.initState();
//     _signUpBloc = BlocProvider.of<SignUpBloc>(context);
//     _listenOTP();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BlocListener<SignUpBloc, SignUpState>(
//       listener: (context, state) async {
//         if (state.isFailure)
//           ScaffoldMessenger.of(context).showSnackBar(errorSnackBar());

//         if (state.isSubmitting)
//           ScaffoldMessenger.of(context).showSnackBar(
//             submittingSnackBar(context: context),
//           );

//         if (state.isSuccess) {
//           // BlocProvider.of<AuthBloc>(context).add(AuthSignedIn());
//           User user = widget._userRepository.getUser();

//           if (_phoneController.text.isNotEmpty) {
//             FirebaseAuth _auth = FirebaseAuth.instance;

//             _auth.verifyPhoneNumber(
//               phoneNumber: '+20${_phoneController.text}',
//               timeout: const Duration(minutes: 2),
//               verificationCompleted: (credential) async {
//                 await FirebaseAuth.instance.signInWithCredential(credential);
//                 // AuthResult
//                 await user.updatePhoneNumber(credential);
//               },
//               verificationFailed: (FirebaseAuthException e) {
//                 if (e.code == 'invalid-phone-number') {
//                   print('The provided phone number is not valid.');
//                 }
//                 // Handle other errors
//               },
//               codeSent: (String verificationId, int resendToken) async {
//                 // Update the UI - wait for the user to enter the SMS code
//                 String smsCode = 'xxxx';

//                 // Create a PhoneAuthCredential with the code
//                 PhoneAuthCredential credential = PhoneAuthProvider.credential(
//                   verificationId: verificationId,
//                   smsCode: smsCode,
//                 );

//                 // Sign the user in (or link) with the credential
//                 await user.updatePhoneNumber(credential);
//               },
//               codeAutoRetrievalTimeout: null,
//             );

//             // FirebaseAuth auth = FirebaseAuth.instance;
//             // ConfirmationResult confirmationResult =
//             //     await auth.signInWithPhoneNumber(
//             //   _phoneController.text,
//             //   RecaptchaVerifier(
//             //     container: 'recaptcha',
//             //     size: RecaptchaVerifierSize.compact,
//             //     theme: RecaptchaVerifierTheme.dark,
//             //   ),
//             // );

//             // UserCredential userCredential =
//             //     await confirmationResult.confirm('123456');

//             // // user.updatePhoneNumber(userCredential);
//           }
//         }
//       },
//       child: BlocBuilder<SignUpBloc, SignUpState>(
//         builder: (context, state) {
//           return Conditional.single(
//             context: context,
//             conditionBuilder: (context) => isContinue,
//             widgetBuilder: (context) => Form(
//               key: _formKey,
//               autovalidateMode: AutovalidateMode.always,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   TextFormField(
//                     controller: _phoneController,
//                     keyboardType: TextInputType.phone,
//                     autocorrect: false,
//                     decoration: InputDecoration(
//                       prefix: Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 8.0),
//                         child: Text("+20"),
//                       ),
//                       suffixIcon: Icon(Icons.phone_android_rounded),
//                       labelText: "Phone Number",
//                     ),
//                     validator: Validators.isValidPhoneNumber,
//                     onChanged: (phone) {
//                       _phoneController.text = phone;
//                       _phoneController.selection = TextSelection.fromPosition(
//                         TextPosition(
//                           offset: _phoneController.text.length,
//                         ),
//                       );
//                     },
//                   ),
//                   SizedBox(height: 15),
//                   SizedBox(
//                     width: MediaQuery.of(context).size.width,
//                     child: FloatingActionButton(
//                       child: Text("Send"),
//                       onPressed: () async {
//                         final String signCode =
//                             await SmsAutoFill().getAppSignature;
//                         print(signCode);
//                         // if (_formKey.currentState.validate())
//                         setState(() {
//                           isContinue = false;
//                         });
//                       },
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             fallbackBuilder: (context) => Form(
//               key: _formKey,
//               autovalidateMode: AutovalidateMode.always,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   PinFieldAutoFill(
//                     codeLength: 4,
//                     // controller: _OTPController,
//                     onCodeChanged: (code) {
//                       print(code);
//                     },
//                   ),
//                   SizedBox(height: 15),
//                   SizedBox(
//                     width: double.infinity,
//                     child: FloatingActionButton(
//                       child: Text("Verify"),
//                       onPressed: () {
//                         // if (isButtonEnabled(state)) _onFormSubmitted();
//                       },
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     _phoneController.dispose();
//     super.dispose();
//   }

//   void _listenOTP() async {
//     await SmsAutoFill().listenForCode;
//   }

//   void _onPhoneChange() {
//     // _signUpBloc.add(
//     //   SignUpPhoneChange(
//     //     phoneNumber: _phoneController.text,
//     //   ),
//     // );
//   }

//   void _onFormSubmitted() {
//     // _signUpBloc.add(
//     //   SignUpPhoneSubmitted(
//     //     phoneNumber: _phoneController.text,
//     //   ),
//     // );
//   }

//   void _showSnackBar(String pin, BuildContext context) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         duration: const Duration(seconds: 3),
//         content: Container(
//           height: 80.0,
//           child: Center(
//             child: Text(
//               'Pin Submitted. Value: $pin',
//               style: const TextStyle(fontSize: 25.0),
//             ),
//           ),
//         ),
//         backgroundColor: Colors.deepPurpleAccent,
//       ),
//     );
//   }
// }
