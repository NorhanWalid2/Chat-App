//import 'package:chat_app/screens/home_screen.dart';
//import 'package:chat_app/screens/signup_screen.dart';
import 'package:chat_app/constants.dart';
import 'package:chat_app/main.dart';
import 'package:chat_app/screens/cubit/sign_up_cubit/sign_up_cubit.dart';
import 'package:chat_app/screens/loginScreen.dart';
import 'package:chat_app/widgets/custom_button.dart';
import 'package:chat_app/widgets/text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class SignupScreen extends StatelessWidget {
  static String id = 'signUp';
  String? pass;

  String? email;

  bool isLoading = false;

  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignUpCubit, SignUpState>(
      listener: (context, state) {
        // TODO: implement listener
        if (state is SignUpLoading) {
          isLoading = true;
        } else if (state is SignUpSucess) {
          Navigator.pushNamed(context, LoginScreen.id);
          isLoading = false;
        } else if (state is SignUpFailure) {
          isLoading = false;
          showSnackBar(context, state.errorMessage, Colors.red);
        }
      },
      builder: (context, state) => ModalProgressHUD(
        inAsyncCall: isLoading,
        child: Scaffold(
          backgroundColor: kbackGroundColor,
          body: Center(
            child: Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Form(
                key: formKey,
                child: ListView(
                  children: [
                    const SizedBox(
                      height: 50,
                    ),
                    const CircleAvatar(
                      radius: 100,
                      backgroundColor: Colors.black,
                      child: CircleAvatar(
                        backgroundImage: AssetImage(
                            'assets/Coffee Cup Vector Logo Design Template Premium Coffee Shop PNG Images _ EPS Free Download - Pikbest.jpeg'),
                        radius: 100,
                      ),
                    ),
                    const Center(
                      child: Text(
                        'Relax Coffee',
                        style: TextStyle(
                          fontSize: 30,
                          fontFamily: 'Pacifico',
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                      // width: 100,
                    ),
                    const Row(
                      children: [
                        Text(
                          'Sign Up',
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    CustomTextField(
                      onchange: (data) {
                        email = data;
                      },
                      icon: const Icon(Icons.email),
                      obscure: false,
                      hint: "enter your email",
                      labeltextt: 'email',
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    CustomTextField(
                      onchange: (data) {
                        pass = data;
                      },
                      icon: const Icon(Icons.password),
                      obscure: true,
                      hint: "enter your password",
                      labeltextt: 'password',
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomButton(
                      ontap: () async {
                        if (formKey.currentState!.validate()) {
                          BlocProvider.of<SignUpCubit>(context)
                              .registerUser(email: email!, pass: pass!);
                        }
                      },
                      conText: "Sign Up",
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Do have an account? '),
                        GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: const Text('LogIn')),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> registerUser() async {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email!,
      password: pass!,
    );
  }
}
