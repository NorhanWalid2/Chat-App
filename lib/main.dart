import 'package:chat_app/firebase_options.dart';
import 'package:chat_app/screens/chat_screen.dart';
import 'package:chat_app/screens/cubit/chat_cubit/chat_cubit.dart';
import 'package:chat_app/screens/cubit/login_cubit/login_cubit.dart';
import 'package:chat_app/screens/cubit/sign_up_cubit/sign_up_cubit.dart';
import 'package:chat_app/screens/loginScreen.dart';
import 'package:chat_app/screens/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(RelaxCofee());
}

class RelaxCofee extends StatelessWidget {
  const RelaxCofee({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LoginCubit(),
        ),
        BlocProvider(
          create: (context) => SignUpCubit(),
        ),
        BlocProvider(
          create: (context) => ChatCubit(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.light(),
        routes: {
          LoginScreen.id: (context) => LoginScreen(),
          SignupScreen.id: (context) => SignupScreen(),
          ChatScreen.id: (context) => ChatScreen()
        },
        initialRoute: LoginScreen.id,
      ),
    );
  }
}

void showSnackBar(BuildContext context, String message, Color color) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: color,
      content: Text(message),
    ),
  );
}
