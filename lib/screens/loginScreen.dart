//import 'package:chat_app/main.dart';
import 'package:chat_app/constants.dart';
import 'package:chat_app/screens/chat_screen.dart';
import 'package:chat_app/screens/cubit/chat_cubit/chat_cubit.dart';
import 'package:chat_app/screens/cubit/login_cubit/login_cubit.dart';
import 'package:chat_app/screens/signup_screen.dart';
import 'package:chat_app/widgets/custom_button.dart';
import 'package:chat_app/widgets/text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/main.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  static String id = 'LoginScreen';
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String? pass;

  String? email;
  bool isLoading = false;
  GlobalKey<FormState> formKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginLoading) {
          isLoading = true;
        } else if (state is LoginSucess) {
          BlocProvider.of<ChatCubit>(context).recieveMessage();
          Navigator.pushNamed(context, ChatScreen.id, arguments: email);
          isLoading = false;
        } else if (state is LoginFailure) {
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
                          'LOGIN',
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
                          BlocProvider.of<LoginCubit>(context)
                              .loginUser(email: email!, pass: pass!);
                          BlocProvider.of<LoginCubit>(context).email = email;
                        }
                      },
                      conText: "Login",
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Don\'t have an account? '),
                        GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, SignupScreen.id);
                            },
                            child: const Text('Sign Up')),
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

  Future<void> loginUser() async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email!,
      password: pass!,
    );
  }
}
